data "aws_availability_zones" "availability_zones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}




module "Custom_vpc" {
    source = "../../modules/Vpc"
    public_subnet_count = var.public_subnet_count
    private_subnet_count = var.private_subnet_count
    Env = "dev"

}

module "Secondary_vpc"{
  providers = {
    aws = aws.secondary
  }
  source = "../../modules/Vpc"
  public_subnet_count= var.public_subnet_count
  private_subnet_count=var.private_subnet_count
  Env = "dev"
}

module "Security" {
    source = "../../modules/Security"
    Custom_vpc = module.Custom_vpc.vpc_id

}

module "Secondary_security" {
  providers = {
    aws = aws.secondary
  }
  source = "../../modules/Security"
  Custom_vpc = module.Secondary_vpc.vpc_id
}


module "blue_launch_template" {
    source = "../../modules/LaunchTemplate"

     
    instance_type = var.instance_type
    instance_keyname = var.instance_keyname
    template_AMI=var.template_AMI

    template_security_group= module.Security.AutoScalingGroup_SG_Id 
    instance_profile=var.instance_profile

    user_data = var.user_data

    Template_name=var.Template_name
}

## secondary passive region

module "Secondary_blue_launch_template" {
    providers = {
    aws = aws.secondary
  }
    source = "../../modules/LaunchTemplate"
     
    instance_type = var.instance_type
    instance_keyname = var.instance_keyname
    template_AMI=var.Secondary_template_AMI

    template_security_group= module.Secondary_security.AutoScalingGroup_SG_Id 
    instance_profile=var.instance_profile

    user_data = var.user_data

    Template_name=var.Template_name
}


module "blue_target_group" {
    source = "../../modules/TargetGroup"
    vpc_id = module.Custom_vpc.vpc_id
    Name = var.Name

}

module "Secondary_blue_target_group" {
    providers = {
    aws = aws.secondary
  }
    source = "../../modules/TargetGroup"
    vpc_id = module.Secondary_vpc.vpc_id
    Name = var.Name

}

module "ASG" {
  source = "../../modules/AutoScalingGroup" 
  asg_name = "Blue_asg_${var.environment}"
  subnet_ids = module.Custom_vpc.private_subnets_ids
  launch_template = module.blue_launch_template.launch_template_id
  target_group_arns = [module.blue_target_group.target_group_arn]
  template_version = var.template_version
}


module "Secondary_ASG" {
  providers = {
    aws = aws.secondary
  }
  source = "../../modules/AutoScalingGroup" 
  asg_name = "Blue_asg_${var.environment}"
  subnet_ids = module.Secondary_vpc.private_subnets_ids
  launch_template = module.Secondary_blue_launch_template.launch_template_id
  target_group_arns = [module.Secondary_blue_target_group.target_group_arn]
  template_version = var.template_version
}

module "Application_loadbalancer" {
  source = "../../modules/LoadBalancer"
  security_groups = [module.Security.ApplicationLoadBalancer_SG_Id]
  subnet_ids = module.Custom_vpc.public_subnets_ids
  aws_target_group_blue=module.blue_target_group.target_group_arn
  target_group_blue_weight=100
}

module "Secondary_Application_loadbalancer" {
  providers = {
    aws = aws.secondary
  }
  source = "../../modules/LoadBalancer"
  security_groups = [module.Secondary_security.ApplicationLoadBalancer_SG_Id]
  subnet_ids = module.Secondary_vpc.public_subnets_ids
  aws_target_group_blue=module.Secondary_blue_target_group.target_group_arn
  target_group_blue_weight=100
}

module "Elasticache" {
  source = "../../modules/ElastiCache-Valkey"
  cache_subnetgroup_ids = flatten([module.Custom_vpc.private_subnets_ids ])  #module.Secondary_vpc.private_subnets_ids
  #preferred_availability_zones = [var.#preferred_availability_zones]
  security_group_ids = [module.Security.ElasticacheVolkey_SG_Id]
  num_cache_clusters = var.num_cache_clusters
  secondary_region = var.secondary_region
}


module "Aurora-GDB" {
  source = "../../modules/Aurora"
  database_name = "application_db-${var.environement}"
  vpc_security_group_ids_primary = [module.Security.Aurora_SG_Id, module.Secondary_security.Aurora_SG_Id]
  Aurora_port = var.Aurora_port
  availability_zones_primary= var.availability_zones_primary
  db_subnet_group_name_primary= var.db_subnet_group_name_primary
}