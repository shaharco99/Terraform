#!/bin/bash
# EC2 user data: install Docker and run nginx on port 80.
apt-get update
apt-get install -y docker.io
systemctl enable --now docker
usermod -aG docker ubuntu
docker run --name mynginx1 -p 80:80 -d nginx:latest
