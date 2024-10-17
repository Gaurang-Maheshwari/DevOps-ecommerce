# Service for mern-server
resource "kubernetes_service" "mern_server_service" {
  metadata {
    name = "mern-server-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.mern_server.metadata[0].labels["app"]
    }
    
    type = "LoadBalancer"
    
    port {
      port        = 80          # Port to expose
      target_port = 5000          # Target port on the container
    }
  }
}

# Service for mern-client
resource "kubernetes_service" "mern_client_service" {
  metadata {
    name = "mern-client-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.mern_client.metadata[0].labels["app"]
    }
    
    type = "LoadBalancer"
    
    port {
      port        = 80          # Port to expose (change if needed)
      target_port = 3000        # Target port on the client container
    }
  }
}
