resource "kubernetes_namespace" "flask" {
  metadata {
    name = var.app_name
  }
}

resource "helm_release" "flask" {
  name             = var.app_name
  chart            = "../helm-chart"
  namespace        = kubernetes_namespace.flask.metadata[0].name
  create_namespace = false
}