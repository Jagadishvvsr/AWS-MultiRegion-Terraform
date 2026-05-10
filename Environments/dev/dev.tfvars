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
Secondary_template_AMI="ami-02166c47d457c16a3"


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

preferred_availability_zones = ["us-east-1a"] 
num_cache_clusters = 1
secondary_region = "us-west-1"


##  Aurora

global_cluster_identifier="application-global-cluster"
Aurora_engine="aurora-postgresql"
Aurora_engine_version="11.9"
database_name="applciation_db"
primary_cluster_identifier="application-postgres-primary"
db_subnet_group_name_primary="default"
secondary_cluster_identifier="application-postgres-secondary"
db_subnet_group_name_secondary="Secondary"
primary_instance_identifier="application-postgres-secondary"
primary_instance_class="db.r4.large"
secondary_instance_identifier="application-secondary-instance"
secondary_instance_class="db.r4.large"
availability_zones_primary=["us-east-1a", "us-east-1b", "us-east-1c"]
secret_replica_region="us-west-2"