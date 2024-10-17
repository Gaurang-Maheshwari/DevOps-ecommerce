# provider.tf
provider "kubernetes" {
  config_path = "C:\Users\gaura\.kube\config"
  config_context = "minikube"
}
