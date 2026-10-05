# Runs Jenkins in a local Docker container, published on http://localhost:8000.
# Initial admin password:
#   docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

resource "docker_image" "jenkins" {
  name         = var.jenkins_image
  keep_locally = false
}

resource "docker_container" "jenkins" {
  image    = docker_image.jenkins.image_id
  name     = "jenkins"
  attach   = false
  must_run = true

  ports {
    internal = 8080
    external = var.host_port
  }
}
