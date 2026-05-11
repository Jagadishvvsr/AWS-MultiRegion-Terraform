
## Multi-Region AWS Infrastructure (RDS + Valkey)

This repository contains modular Terraform infrastructure for deploying a multi-region AWS architecture, including reusable modules for:

* VPC
* Amazon EC2 Auto Scaling (ASG)
* Elastic Load Balancing (ALB)
* Amazon Aurora (RDS / Aurora)
* Amazon ElastiCache (Valkey / Redis-compatible global datastore)

It is designed for reusability, scalability, and multi-region disaster recovery.

# Architecture Overview

This infrastructure supports:

  * Active-passive multi-region deployment
  * Disaster recovery with failover capability
  * Private subnet-based compute and data layers
  * Public ALB exposure only
  * Weighted and cost-optimized scaling strategy


# 🌐 VPC Module

The VPC module is fully modular and supports multiple deployment modes:

## Features
   * Creates public and private subnets automatically
   * Supports:
   * Fixed subnet count (public_subnet_count, private_subnet_count)
   * OR custom CIDR + AZ mapping
   * Automatic AZ distribution
   * NAT Gateway per AZ for high availability
   * Separate route tables for public and private subnets
   * Internet Gateway for public routing
   * VPC Flow Logs enabled
## Security Model
   * Application workloads deployed in private subnets
   * Public subnets only host load balancers
   * No direct internet access for compute or database layers

This module is designed for enterprise reuse across environments and teams.

# RDS / Aurora Module

The database layer uses Amazon Aurora in a global setup:

## Features
   * Primary region with read replica in secondary region
   * Asynchronous replication
   * Failover support for disaster recovery
   * Secondary region can act as read-only endpoint
   * Deployed in private subnets
   * Access restricted via security groups (only ASG allowed)

# Valkey (ElastiCache) Module

This module uses Amazon ElastiCache with global replication:

## Features
  * Global datastore setup (primary + replica region)
  * Asynchronous replication
  * Failover support
  * Private subnet deployment
  * Restricted access from ASG only

## Used for:

  * Session storage
  * Caching layer
  * Low-latency distributed reads

# Auto Scaling Group

Built using Amazon EC2 Auto Scaling:

## Features
   * Multi-region ASG deployment (active/passive model)
   * Launch template-based configuration
   * Private subnet placement
   * ALB-only access via security groups
   * Scaling Strategy
   * CPU-based scaling policies
   * Mixed instance policy:
   * On-demand base capacity
   * Up to 75% spot instances for cost optimization
   * Supports instance refresh for rolling updates

# Target Group

## Features
  * Multi-region support
  * Configurable:
  * Stickiness (ALB cookie / application cookie)
  * Routing algorithm (least outstanding requests)
  * Slow start duration
  * Deregistration delay
  * Health checks enabled
  * Deployment Strategy Support
  * Blue/green deployments via weighted routing
  * Canary deployments via ASG instance refresh

# Load Balancer Module

Uses Elastic Load Balancing (Application Load Balancer):

## Features
  * Public subnet deployment
  * Listener rules configurable per environment
  * Routes traffic to target groups
  * Supports blue/green routing patterns
  * Security Model
  * Only ALB is internet-facing
  * EC2 instances are accessible only via:
  * ALB security group
  * AWS Systems Manager (SSM)

# Multi-Region Failover

Failover is handled using:
  * Amazon Route 53
  * Health check-based routing policies
  * Active-passive failover strategy


# Use Cases
  * Disaster recovery architecture
  * Multi-region high availability systems
  * Low-latency global read workloads
  * Cost-optimized scalable compute systems


# Architecture Diagram

<img width="5120" height="2733" alt="Multi-Region-AWS (1)" src="https://github.com/user-attachments/assets/b7978e5b-638a-42c5-bfe0-fc4951433a3f" />


# FULL STACK ARCHITECTURE

![alt text](<Screenshot 2026-03-21 123152.png>)
