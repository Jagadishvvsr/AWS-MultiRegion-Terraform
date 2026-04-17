locals {
  ENV = var.environment
}


resource "aws_launch_template" "Green_prod_template" {
  name = "Application-green-${local.ENV}"
  image_id = var.Green_prod_template_AMI
  instance_type = var.green_instance_type
  vpc_security_group_ids = [var.green_template_security_group]
  key_name = var.create_key == 0 ? var.green_instance_keyname : var.public_key_path

  user_data = filebase64(var.user_data)

  iam_instance_profile {
    name = var.green_instance_profile
  }
  disable_api_stop        = true
  disable_api_termination = true
  ebs_optimized = true

  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 10
    }
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = var.metadata_hop_limit
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = false
  }

  monitoring {
    enabled = true
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "green(update)_APPLication_${local.ENV}"
    }
  }
  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "green(update)_Application_volume_${local.ENV}"
    }
  }


}