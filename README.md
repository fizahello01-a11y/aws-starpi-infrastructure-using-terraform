# aws-starpi-infrastructure-using-terraform
This project deploys a private EC2 instance running Strapi in a VPC using Terraform with public/private subnets a NAT gateway,security groups and an Application Load Balancer (ALB).

Architecture:

VPC with public and private subnets

NAT Gateway in the public subnet for private EC2 outbound internet access

Private EC2 instance running Strapi using Docker

Application Load Balancer (ALB) in the public subnet to access the app externally

Security Groups control traffic:

ALB allows inbound HTTP/HTTPS traffic

EC2 allows inbound traffic only from the ALB

terraform-strapi/
├── modules/
│   ├── vpc/      → VPC, subnets, NAT Gateway
│   ├── ec2/      → EC2 instance with Docker & Strapi
│   └── alb/      → Application Load Balancer & target group
├── scripts/
│   └── user_data.sh → EC2 startup script for Docker & Strapi
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
