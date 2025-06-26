terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.37.1"
    }
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7.8.2"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop" # or "minikube", "your-aks-cluster", etc.
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "docker-desktop" # Change if using minikube, aks, etc.
  }
}

provider "argocd" {
  server_addr = "localhost:8080"
  username    = "admin"
  password    = var.argocd_password
  insecure    = true
}





