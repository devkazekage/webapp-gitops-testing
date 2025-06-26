variable "app_name" {
  type        = string
  description = "Name of the app to use for namespace and Helm release"
}

variable "argocd_password" {
  description = "Argo CD admin password"
  type        = string
  sensitive   = true
}
