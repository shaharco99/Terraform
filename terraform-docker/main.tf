#sudo docker exec -it jenkins bash
#cat /var/jenkins_home/secrets/initialAdminPassword
terraform {
required_providers {
  docker = {
    source  = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "jenkins" {
    name         = "jenkins/jenkins:latest"
    keep_locally = false
}

#resource "docker_network" "private_network" {
#  name   = "MyNet"
#  driver = "bridge"
#  }

resource "docker_container" "jenkins" {
  image        = docker_image.jenkins.latest
  name         = "jenkins"
  attach       = false
  must_run     = true
  network_mode = "host"
  #uncomment to not delete container when destroy
 # rm = true
  ports {
    internal = 8080
    external = 8000
  }
  networks_advanced {
    name = "host"
    #ipv4_address = "192.168.144.2"
  }
}
