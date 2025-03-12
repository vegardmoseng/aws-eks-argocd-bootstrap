resource "aws_acm_certificate" "grafana_acm_cert" {
  domain_name       = var.grafana_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "argo_acm_cert" {
  domain_name       = var.argo_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


