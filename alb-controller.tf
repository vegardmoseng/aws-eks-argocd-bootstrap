locals {
  namespace = "kube-system"
}

resource "helm_release" "helm-alb-controller" {
  name       = var.alb_controller_name
  repository = var.alb_controller_helm_repo
  chart      = var.alb_controller_helm_chart
  namespace  = local.namespace

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
}