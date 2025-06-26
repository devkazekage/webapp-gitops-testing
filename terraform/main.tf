# resource "kubernetes_namespace" "flask" {
#   metadata {
#     name = var.app_name
#   }
# }

# resource "helm_release" "flask" {
#   name             = var.app_name
#   chart            = "../helm-chart"
#   namespace        = kubernetes_namespace.flask.metadata[0].name
#   create_namespace = false
# }

resource "kubernetes_namespace" "argocd" {
  metadata { name = "argocd" }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
}

# data "external" "admin_password" {
#   program = ["bash", "-c", "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"]
# }

resource "argocd_application" "flask_app" {
  metadata {
    name      = "flask-app"
    namespace = "argocd"
  }

  spec {
    project = "default"

    source {
      repo_url        = "https://github.com/avi070440/flask-helm.git"
      target_revision = "main"
      path            = "helm"
      chart           = "flask-app"
      helm {
        value_files = ["values.yaml"]
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "flask-app"
    }

    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }
    }
  }
}
