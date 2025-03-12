resource "kubernetes_service_account" "cn_cos_onboarding_ie_k8s_alb_serviceaccount" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
                  "eks.amazonaws.com/role-arn" = var.eks_role_arn
                }
    labels = {
           "app.kubernetes.io/component" = "controller"
           "app.kubernetes.io/name"      = "aws-load-balancer-controller"
            }
 }
}

resource "kubernetes_service_account" "k8s_azdevops_serviceaccount" {
  metadata {
    name                            = var.k8s_azdevops_serviceaccount_name
    namespace                       = "argocd" 
    
 }
 automount_service_account_token = false
}


