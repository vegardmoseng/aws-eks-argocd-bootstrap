# backend.tf
variable "eks_cluster_name" {
    type = string
}

variable "aws_region" {
    type = string
}


# alb-controller.tf
variable "alb_controller_name" {
    type = string
}

variable "alb_controller_helm_repo" {
    type = string
}

variable "alb_controller_helm_chart" {
    type = string
}

variable "alb_cert_arn" {
    type = string
}

# argocd.tf 
variable "argo_name" {
    type = string
}

variable "argo_chart" {
    type = string
}

variable argo_appset_name {
    type = string
}

variable argo_appset_chart {
    type = string
}

variable "alb_ingress_argo_name" {
    type = string
}


# serviceAccount.tf 
variable "aws_account_number" {
    type = string
}

variable "iam_policy_ALBController" {
    type = string
}

variable "k8s_azdevops_serviceaccount_name" {
    type = string  
}

variable "eks_role_arn" {
    type = string
}


# secrets.tf 
variable "k8s_azdevops_serviceaccount_secret_name" {
    type = string
}

# rbac.tf
variable "k8s_azdevops_serviceaccount_role_name" {
    type = string
}

variable "k8s_azdevops_serviceaccount_role_binding_name" {
    type = string
}

# amc.tf
variable "grafana_domain_name" {
    type = string
}

variable "argo_domain_name" {
    type = string
}