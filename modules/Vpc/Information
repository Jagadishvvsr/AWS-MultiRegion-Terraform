This VPC is fully modularised for reusability with custom Subnets to be provided either to be number of subnets (Private and public) with cidr block and az as variable list "cidr = optional(string)
    az = optional(string)" , if not the number of private and public subnets needed with variables "public_subnet_count" and "private_subnet_count" , with this information provided this module will automatically create a vpc with the provided private and public subnet count and providees a CIDR provided or automatic and creates a NAT on single az , all the subnets are spread between azs automatically even if not provided. and NAT is created per AZ and is assigned to a private route table per AZ and a public route table is created and a internet gateway is assigned to it.

    this module creates , privarte and public subnets , private and public routetable, NAT gateways, INternet gateway assigns thee respective routes for the subnest to the route table.

    This vpc , solves both high availablity with multi az NAT and also makes sure the necessary security is in place for out applciation which needs to be deployed in the private suibnet with no internet access. We can also choose only a private sunets to be created with the help of vraibles by provoding only private subnet vraible.

    This VPC can be reused accross the organisation at various scales. All the required information such as "enable_dns_support" and "instance_tenancy" and vpc cidr block are provided "Vpc_Cidr_Block" with the same names through the varaible file.

this solves both security and decreases reworking accross of our organisation. with all the logging enabled with "vpc flow logs" this is a complete virutal private cloud for both sagfety and sclaabnlityu to deplpy our applications in through ec2 instances in private subnet , Load balancers in public subent etc

thank you.


🌐 Modular AWS VPC (Terraform) – Reusable, Scalable, and Production-Ready

This module provisions a fully modular and reusable Virtual Private Cloud (VPC) on AWS, designed to support both custom subnet definitions and automated subnet generation based on user inputs.

🔧 Flexible Subnet Configuration

The module supports two modes of subnet creation:

1. Custom Subnet Input

Users can explicitly define subnets using:

cidr = optional(string)
az   = optional(string)

This allows precise control over:

CIDR ranges
Availability Zone placement
2. Automatic Subnet Generation

If custom subnets are not provided, the module dynamically creates subnets using:

public_subnet_count
private_subnet_count

In this mode:

CIDR blocks are automatically calculated
Subnets are evenly distributed across available Availability Zones
AZ assignment is handled intelligently, even when not explicitly specified

🌍 Networking Architecture

This module builds a complete VPC networking stack:

✅ Core Components Created
VPC with configurable CIDR (Vpc_Cidr_Block)
Public Subnets
Private Subnets
Internet Gateway
Public Route Table (with Internet Gateway route)
Private Route Tables (per AZ)
NAT Gateways (one per AZ for high availability)

🔁 Routing Design
Public Subnets
Associated with a shared public route table
Route: 0.0.0.0/0 → Internet Gateway
Private Subnets
Each AZ gets its own route table
Route: 0.0.0.0/0 → NAT Gateway (same AZ)

This ensures:

No cross-AZ traffic for outbound internet
High availability and fault isolation

🔐 Security & Isolation
Application workloads can be deployed in private subnets with no direct internet exposure
Internet access (if needed) is controlled via NAT Gateways
Supports secure architectures like:
Private EC2 instances
Public Load Balancers (in public subnets)

⚙️ Configuration Options

The module exposes key VPC settings:

Vpc_Cidr_Block
enable_dns_support
enable_dns_hostnames
instance_tenancy

It also allows selective deployment:

Only private subnets
Only public subnets
Or both

📊 Observability
Supports enabling VPC Flow Logs for network visibility and auditing
Helps in debugging, monitoring, and security analysis

🚀 Design Goals

This VPC module is built to:

✔ Support multi-AZ high availability
✔ Avoid CIDR conflicts and manual subnet planning
✔ Reduce repetitive infrastructure setup
✔ Enable secure-by-default architectures
✔ Scale across different environments (dev, staging, prod)

🧠 Summary

This module provides a complete, production-ready VPC foundation that balances:

Flexibility (custom or automatic subnet creation)
Scalability (multi-AZ, reusable design)
Security (private subnet isolation)
Reliability (NAT per AZ, fault tolerance)

It can be reused across the organization to standardize infrastructure and accelerate application deployment.\



🚀 Built a Fully Modular AWS VPC Terraform Module (Production-Ready Networking Layer)

I recently built a reusable Terraform module that provisions a complete AWS VPC networking stack designed for real-world, multi-environment usage.

The goal wasn’t just to “create infrastructure”, but to design something that is scalable, deterministic, and safe by default for production workloads.

🧩 What this module handles

This module supports two flexible modes:

1. Custom subnet mode

Users can pass CIDR + AZ explicitly
Full control over network layout

2. Auto-generated mode

Subnets are generated using public_subnet_count and private_subnet_count
CIDR allocation is derived using cidrsubnet
Subnets are automatically distributed across available AZs

🏗️ Architecture it builds
VPC with configurable CIDR block
Public subnets (multi-AZ)
Private subnets (multi-AZ)
Internet Gateway
NAT Gateway per AZ
Public route table (IGW-based routing)
Private route tables (NAT-based routing per AZ)

🔐 Design decisions (important part)
Each AZ gets its own NAT Gateway → avoids cross-AZ traffic and improves resilience
Private subnets are fully isolated from direct internet access
Public subnets handle ingress components like load balancers
Route tables are strictly aligned per AZ to ensure predictable traffic flow

⚙️ What makes it reusable
Works with both custom and auto subnet definitions
Prevents CIDR overlap using controlled index separation
Fully parameterized (VPC CIDR, tenancy, DNS settings, subnet counts)
Designed to be reused across dev / staging / production without modification

📌 Why I built this

Most VPC setups are either:

too rigid for scaling
or
too manually managed and error-prone

This module tries to strike a balance between:

automation
control
and production-grade networking safety
🧠 Key takeaway

Infrastructure design is not just about provisioning resources — it’s about making failure modes predictable and scaling behavior consistent across environments.