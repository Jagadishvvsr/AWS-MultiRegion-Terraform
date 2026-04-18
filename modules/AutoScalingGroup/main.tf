locals {
    Env = var.environement
}

resource "aws_autoscaling_group" "AutoScaler_application" {
  name = "${var.name}-${local.Env}"
  capacity_rebalance  = var.capacity_rebalance
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.example1.id, aws_subnet.example2.id]
  default_instance_warmup = 200
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

  warm_pool {
    pool_state                  = "Hibernated"
    min_size                    = 1
    max_group_prepared_capacity = 10

    instance_reuse_policy {
      reuse_on_scale_in = true
    }
  }

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
        instance_type     = "c4.large"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "c3.large"
        weighted_capacity = "2"
      }
    }
  }
}