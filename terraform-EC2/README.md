# terraform-EC2

Creates `amount_of_instance` Ubuntu 22.04 EC2 instances (latest Canonical AMI). User data (`templates/ubuntu.sh`) installs Docker and starts nginx on port 80. After apply, a `null_resource` writes the instance names to `ansible/hosts` under `[EC2_hosts]`.

State is stored in Terraform Cloud (organization `shaharco99`, workspace `Devops`).

## Inputs

| Variable | Default |
|---|---|
| `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` | - (sensitive) |
| `region` | - |
| `amount_of_instance` | `1` |
| `instance_type` | `t2.micro` |

## Outputs

`private_ip`, `public_ip`, `hosts_names` (newline-separated).

## Run

```bash
terraform login
terraform init
terraform apply
terraform destroy -target 'aws_instance.ubuntu[0]'   # remove one instance
```
