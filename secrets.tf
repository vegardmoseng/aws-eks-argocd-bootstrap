resource "kubernetes_secret" "k8s_azdevops_serviceaccount_secret" {
  metadata {
    name = var.k8s_azdevops_serviceaccount_secret_name
    namespace = "argocd"
    annotations = {
                  "kubernetes.io/service-account.name" = var.k8s_azdevops_serviceaccount_name
                }
 }
 type = "kubernetes.io/service-account-token"
}