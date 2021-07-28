terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.51.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "emea-se-playground-2019"
    workspaces = {
          name = "lbolli-demo-aws-network"
    }
  }
}

resource "random_id" "identifier" {
  byte_length = 1
}

provider "random" {}

resource "random_pet" "name" {}


resource "aws_db_instance" "demo" {
  identifier                = "rds-postgres-${var.project_name}"
  instance_class            = "db.t3.micro"
  allocated_storage         = 5
  max_allocated_storage     = 25
  backup_retention_period   = 5
  engine                    = "postgres"
  engine_version            = "13.1"
  username                  = var.db_user
  password                  = var.db_password
  db_subnet_group_name      = aws_db_subnet_group.demo.name
  vpc_security_group_ids    = data.terraform_remote_state.network.outputs.db_security_group_ids
  parameter_group_name      = aws_db_parameter_group.demo.name
  publicly_accessible       = false
  skip_final_snapshot       = true

  tags = {
    Name    = "rds-postgres-${var.project_name}"
    Project = var.project_name
    Owner   = var.owner
    TTL     = var.resource_ttl
  }
}

resource "aws_db_subnet_group" "demo" {
  name       = "rds-subnet-group-${var.project_name}"
  subnet_ids = data.terraform_remote_state.network.outputs.private_database_subnet_ids

  tags = {
    Name    = "rds-subnet-group-${var.project_name}"
    Project = var.project_name
    Owner   = var.owner
    TTL     = var.resource_ttl
  }
}

resource "aws_db_parameter_group" "demo" {
  name   = "aws-demo-${var.project_name}"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

// resource "aws_db_instance" "demo_replica" {
//   name                      = "rds-postgres-replica-${var.project_name}"
//   identifier                = "rds-postgres-replica-${var.project_name}"
//   replicate_source_db       = aws_db_instance.demo.identifier
//   instance_class            = "db.t3.micro"
//   apply_immediately         = true
//   publicly_accessible       = false
//   skip_final_snapshot       = true
//   vpc_security_group_ids    = data.terraform_remote_state.network.outputs.db_security_group_ids
//   parameter_group_name      = aws_db_parameter_group.demo.name

//   tags = {
//     Name    = "rds-postgres-replica-${var.project_name}"
//     Project = var.project_name
//     Owner   = var.owner
//     TTL     = var.resource_ttl
//   }
// }