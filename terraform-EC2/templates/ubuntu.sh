#! /bin/bash
sudo apt update
sudo apt update
sudo apt-get install docker-ce
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker ubuntu
sudo docker pull nginx:latest
sudo docker run --name mynginx1 -p 80:80 -d nginx