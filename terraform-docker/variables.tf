variable "jenkins_image" {
  description = "Jenkins image to run"
  type        = string
  default     = "jenkins/jenkins:lts"
}

variable "host_port" {
  description = "Host port mapped to the Jenkins web UI (container port 8080)"
  type        = number
  default     = 8000
}

variable "docker_host" {
  description = "Docker daemon socket"
  type        = string
  default     = "unix:///var/run/docker.sock"
}
