# Terraform

Terraform configurations for AWS, Azure, GCP, Linode and local Docker, written while learning and practising infrastructure as code. Each folder is an independent root module with its own providers and state.

Every folder passes `terraform fmt -check` and `terraform validate`; a GitHub Actions workflow checks both on each pull request (no cloud credentials, no `apply`).

## Folders

| Folder | What it creates | Status |
|---|---|---|
| [`terraform-multi-platform`](terraform-multi-platform) | N Ubuntu VMs/containers on AWS, Azure, GCP, Linode or Docker, chosen by one `platform` variable | Working config |
| [`terraform-ecs`](terraform-ecs) | VPC, public/private subnets, ALB, ECR repo, ECS Fargate service, CloudWatch logs, IAM role | Working config, needs NAT for image pulls |
| [`terraform-EC2`](terraform-EC2) | N Ubuntu 22.04 EC2 instances running nginx in Docker; Terraform Cloud backend; Ansible inventory file | Working config |
| [`terraform-docker`](terraform-docker) | Jenkins container on the local Docker host | Working config (applied locally) |
| [`terraform-azure`](terraform-azure) | Resource group, VNet, N Ubuntu VMs with public IPs and data disks; Ansible inventory file | Learning lab |
| [`terraform-GCP`](terraform-GCP) | N Compute Engine instances with ephemeral public IPs | Learning lab |
| [`terraform-linode`](terraform-linode) | N Linode instances plus one DigitalOcean DNS A record each; Ansible inventory file | Learning lab |
| [`terraform-clinic`](terraform-clinic) | ECS cluster, S3 bucket, Route 53 zone/record, Network Load Balancer (placeholder VPC/subnet IDs) | Skeleton |

*Working config*: complete and parameterised, deployable with credentials. *Learning lab*: an exercise with test names or legacy resources. *Skeleton*: pieces not wired together yet.

## Prerequisites

- Terraform (CI uses 1.16.5)
- Credentials for the cloud you target (see each folder's README)
- Docker, for `terraform-docker` and the Docker mode of `terraform-multi-platform`

## Usage

```bash
cd terraform-<folder>
terraform init
terraform plan
terraform apply
terraform destroy
```

Validate everything without credentials, as CI does:

```bash
for d in terraform*/; do (cd "$d" && terraform init -backend=false -input=false >/dev/null && terraform validate); done
```

Secrets (`*.tfvars`, state, service account keys) are git-ignored; pass them as `TF_VAR_*` environment variables or an untracked `.tfvars` file.
