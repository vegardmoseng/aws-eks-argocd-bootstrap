terraform {
  backend "remote" {
    organization = "vmoseng-certs"

    workspaces {
      name = "aws-eks-apps"
    }
  }
}

data "terraform_remote_state" "remote-backend-infra" {
  backend = "remote"

  config = {
    organization = "vmoseng-certs"
    workspaces = {
      name = "aws-eks-infra"
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
   tags = {
     Environment = "dev"
   }
 }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.remote-backend-infra.outputs.eks-cluster
    cluster_ca_certificate = data.terraform_remote_state.remote-backend-infra.outputs.certificate-authority
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.remote-backend-infra.outputs.eks-cluster
  cluster_ca_certificate = data.terraform_remote_state.remote-backend-infra.outputs.certificate-authority
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
    command     = "aws"
  }
}