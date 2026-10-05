# terraform-ecs

Runs one container on ECS Fargate behind an Application Load Balancer.

- `vpc.tf`, `networking.tf` - VPC, internet gateway, public and private subnets per AZ, public route table
- `ecr.tf` - ECR repository; the service runs its `:latest` image
- `ecs.tf` - cluster, CloudWatch log group, task definition (256 CPU / 512 MB, port 8080), service in private subnets, ALB on port 80, security groups, target group (health check `GET /v1/status`)
- `iam.tf` - task execution role with `AmazonECSTaskExecutionRolePolicy`

Private subnets have no NAT gateway, so tasks cannot pull from ECR until one (or VPC endpoints) is added.

## Inputs

`aws_access_key`, `aws_secret_key` (sensitive), `aws_region`, `app_name`, `app_environment`, `public_subnets`, `private_subnets`, `availability_zones` (lists), `cidr` (default `10.10.0.0/16`), `aws_cloudwatch_retention_in_days` (default `1`).

Example `terraform.tfvars` (git-ignored):

```hcl
aws_region         = "eu-central-1"
app_name           = "demo"
app_environment    = "dev"
availability_zones = ["eu-central-1a", "eu-central-1b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]
```

## Run

```bash
terraform init
terraform apply
# then push an image to the ECR repository with tag :latest
```
