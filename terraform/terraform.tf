terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
#      version = "~> 5.25.0"
      version = "~> 5.47.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
#      version = "~> 2.23.0"
      version = "~> 2.31.0"
    }
  }

  backend "s3" {
    bucket = "gitops-vprofile-actions"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

  # required_version = "~> 1.6.3"
  # 升级到 2026 年的主流版本
  required_version = "~> 1.14.0"
}
##
##
##