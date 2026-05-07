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

module "Security" {
    source = "../../modules/Security"
    Custom_vpc = module.Custom_vpc.vpc_id

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


module "blue_target_group" {
    source = "../../modules/TargetGroup"
    vpc_id = module.Custom_vpc.vpc_id
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


