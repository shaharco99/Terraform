# terraform-docker

Runs Jenkins (`jenkins/jenkins:lts`) in a container on the local Docker host and publishes its web UI on a host port (default 8000).

## Files

- `main.tf` - image and container
- `variables.tf` - image, host port, Docker socket
- `outputs.tf` - container and image IDs
- `ansible/Hashicorp.yml` - standalone playbook that installs Consul and Nomad; not called by Terraform

## Prerequisites

Docker running locally.

## Run

```bash
terraform init
terraform apply
# rootless Docker: terraform apply -var docker_host=unix:///run/user/$(id -u)/docker.sock
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Open http://localhost:8000.

## Example output

```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

container_id = "853642b93c8b..."
image_id = "sha256:82becee63645..."
```
