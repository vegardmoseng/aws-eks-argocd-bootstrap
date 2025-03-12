resource "kubernetes_namespace" "ns-argocd-operator" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "helm-argocd" {
  name       = var.argo_name
  chart      = var.argo_chart
  namespace  = "argocd"
  values     = ["${file("./argo-helm/charts/argo-cd/values.yaml")}"]
}

resource "helm_release" "helm-argocd-applicationset" {
  name       = var.argo_appset_name
  chart      = var.argo_appset_chart
  namespace  = "argocd"
  values     = ["${file("./argo-helm/charts/argocd-applicationset/values.yaml")}"]
}


resource "kubernetes_ingress" "argocd-ingress" {
  metadata {
    name        = var.alb_ingress_argo_name
    namespace   = "argocd"
    annotations = {
                    "kubernetes.io/ingress.class" = "alb"
                    "alb.ingress.kubernetes.io/scheme" = "internet-facing"
                    "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{ "HTTP" : 80, "HTTPS" : 443 }])
                    "alb.ingress.kubernetes.io/certificate-arn" = var.alb_cert_arn
                    "alb.ingress.kubernetes.io/actions.ssl-redirect" = jsonencode({ "Type" : "redirect", "RedirectConfig" : { "Protocol" : "HTTPS", "Port" : "443", "StatusCode" : "HTTP_301" } })
                }
    labels      = {
                    "app" = "argocd-ingress"
                }   
  }
  spec {
    rule {
      http {
        path {
          backend {
            service_name = "${var.argo_name}-server"
            service_port = 80
          }
        }
        path {
          backend {
            service_name = "ssl-redirect"
            service_port = "use-annotation"
          }
        }
      }
    }
  }
}

