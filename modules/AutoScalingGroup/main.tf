locals {
    Env = var.environement
}


resource "aws_autoscaling_group" "AutoScaler_application" {
  name = "${var.asg_name}-${local.Env}"
  capacity_rebalance  = var.capacity_rebalance
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [ "subnet-084d349a44e1854e1", "subnet-04035f4c858511081", "subnet-0e6c444e98ba29a85"]
  default_instance_warmup = 200
  health_check_grace_period = var.health_check_grace_period
  health_check_type  = var.health_check_type
  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 110
  }
   instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  /* warm_pool {
    pool_state                  = "Hibernated"
    min_size                    = 5
    max_group_prepared_capacity = 20

    instance_reuse_policy {
      reuse_on_scale_in = true
    }
  } */

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 2
      on_demand_percentage_above_base_capacity = 25
      spot_allocation_strategy                 = "capacity-optimized"
      on_demand_allocation_strategy = "prioritized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = var.launch_template
        version = var.template_version
      }

      override {
        instance_type     = var.Primary_intance_type
        weighted_capacity = var.Primary_intance_weight_capacity
      }

      override {
        instance_type     = var.Secondary_intance_type
        weighted_capacity = var.Secondary_intance_weight_capacity
      }
    }
  }
}