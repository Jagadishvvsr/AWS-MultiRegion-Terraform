# Auto Scaling Group Module (Weighted Capacity with Spot Optimization)

This module provisions an Amazon EC2 Auto Scaling Group using a weighted capacity model instead of scaling purely by instance count. It is designed to optimize cost and performance by combining On-Demand and Spot Instances.

# Key Features

Weighted Instance Types
The module supports two instance types:

* primary_instance_type
* secondary_instance_type

Each instance type is assigned a weight using:
* primary_instance_weight_capacity
* secondary_instance_weight_capacity

This allows scaling based on capacity units rather than the number of instances.

* On-Demand and Spot Distribution
  * Ensures a base desired capacity using On-Demand Instances
  * Scales additional capacity using 75% Spot Instances for cost efficiency
  * Enables flexible and rapid scaling while minimizing cost
* Capacity Rebalancing
   Capacity rebalancing is enabled (default: true) to proactively replace Spot Instances that are at risk of interruption.
   This improves availability by launching replacement instances before disruption occurs.
* Extensive Parameterization
  The module is designed for reusability and exposes key configuration options:
  * Launch template and version
  * min_size, max_size, desired capacity
  * Cooldown periods
  * Scale-in and scale-out warm-up times
  * Health check type and grace period
  * Subnet IDs
  * Capacity rebalance toggle
* Scaling Policies and Monitoring
  * Includes a CPU-based scaling policy using Amazon     CloudWatch
  * Alarm configuration is parameterized (e.g., alarm name)
  * Automatically triggers scale-in and scale-out actions
* Step Adjustments
   Step adjustments in the scaling policy are intentionally not parameterized to keep the module simple and avoid misconfiguration. These values should be tuned carefully based on workload requirements.
* Instance Refresh Support
   Supports instance refresh for rolling updates when the launch template changes, ensuring controlled and consistent updates.
* No Warm Pool
   Warm pools are not used in this module, as the design focuses on Spot Instances where pre-initialized capacity is less practical.
# Additional Notes
   * The module can be reused independently for CPU monitoring by leveraging the CloudWatch alarm configuration.
   * Variable names are aligned closely with their respective configuration options for clarity and ease of use.
   * Refer to the variables.tf file for the full list of required and optional inputs.