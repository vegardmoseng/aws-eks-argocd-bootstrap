resource "kubernetes_role" "k8s_azdevops_serviceaccount_role" {
  metadata {
    name      = var.k8s_azdevops_serviceaccount_role_name
    namespace = "argocd"
  }

  rule {
    api_groups     = [""]
    resources      = ["pods", "namespaces"]
    verbs          = ["get", "list", "watch", "create"]
  }
  rule {
    api_groups     = ["apps"]
    resources      = ["deployments", "namespaces"]
    verbs          = ["get", "list", "create", "delete"]
  }
  rule {
    api_groups     = ["argoproj.io"]
    resources      = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_role_binding" "k8s_azdevops_serviceaccount_role_binding" {
  metadata {
    name      = var.k8s_azdevops_serviceaccount_role_binding_name
    namespace = "argocd"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = var.k8s_azdevops_serviceaccount_role_name
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.k8s_azdevops_serviceaccount_name
    namespace = "argocd"
  }
}