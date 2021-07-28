variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Value of the 'Project' tag for all resources"
  type        = string
  default     = "aws-stack-demo"
}

variable "owner" {
  description = "Value of Project owner"
  type        = string
  default     = "lbolli@hashicorp.com"
}

variable "resource_ttl" {
  description = "Value Time to live for the object created (in hours)"
  type        = number
  default     = 48
}

variable "db_user" {
  description = "RDS root user name"
  type        = string
  default     = "aws-demo-user"
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}