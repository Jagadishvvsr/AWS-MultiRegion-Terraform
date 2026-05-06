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


module "blue_target_group" {
    source = "../../modules/TargetGroup"
}

module "ASG" {
  source = "../../modules/AutoScalingGroup"

}