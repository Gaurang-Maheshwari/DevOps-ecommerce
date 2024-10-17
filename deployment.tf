# Deployment for mern-server
resource "kubernetes_deployment" "mern_server" {
  metadata {
    name = "mern-server"
    labels = {
      app = "mern-server"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "mern-server"
      }
    }

    template {
      metadata {
        labels = {
          app = "mern-server"
        }
      }

      spec {
        container {
          name  = "mern-server-container"
          image = "your-registry/mern-server-image:latest"  # Update to your actual registry
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

# Deployment for mern-client
resource "kubernetes_deployment" "mern_client" {
  metadata {
    name = "mern-client"
    labels = {
      app = "mern-client"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "mern-client"
      }
    }

    template {
      metadata {
        labels = {
          app = "mern-client"
        }
      }

      spec {
        container {
          name  = "mern-client-container"
          image = "your-registry/mern-client-image:latest"  # Update to your actual registry
          port {
            container_port = 3000  # Change this if your client listens on a different port
          }
        }
      }
    }
  }
}
