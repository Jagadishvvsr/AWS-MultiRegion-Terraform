environment = "Dev"

# VPC
public_subnet_count = 2
private_subnet_count = 2

# launch template

Template_name="Testforroot"
template_AMI ="ami-091138d0f0d41ff90" 
instance_keyname="ansible"
instance_type="t3.micro"
user_data="Scripts/user_data.sh"
instance_profile=null


# ASG
#launch_template
template_version = 1
#Primary_instance_type
#Secondary_instance_type
#target_group_arns= 
#subnet_ids=
Secondary_instance_type = "m6a.2xlarge"



# TARGET GROUP
Name = "App-target-group-blue"


# LoadBalancer

#aws_target_group_blue=
#target_group_green_weight=
#target_group_blue_weight=
#aws_target_group_green=
Listener_port=80
Listener_protocol="HTTP"
#stickiness=
#stickiness_duration=

# cache

preferred_availability_zones = ["us-east-1a, us-east ]