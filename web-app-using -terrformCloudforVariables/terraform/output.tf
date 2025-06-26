output "namespace_name" {
  description = "The name of the Kubernetes namespace created"
  value       = kubernetes_namespace.flask.metadata[0].name
}

output "helm_release_name" {
  description = "The name of the Helm release"
  value       = helm_release.flask.name
}

output "app_url" {
  description = "The external URL for the Flask app (if exposed via LoadBalancer)"
  value       = try(helm_release.flask.metadata[0].annotations["external_url"], "Not available")
}
