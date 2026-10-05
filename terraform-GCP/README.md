# terraform-GCP

Learning lab. Creates `amount_of_instance` Compute Engine instances on the `default` network, each with an ephemeral public IP.

## Inputs

| Variable | Default |
|---|---|
| `credentials` | - path to a service account JSON key, kept outside the repo |
| `project_id` | - |
| `region` | - |
| `zone` | `asia-east1-a` |
| `machine_type` | - e.g. `e2-micro` |
| `image_name` | - e.g. `ubuntu-os-cloud/ubuntu-2204-lts` |
| `amount_of_instance` | `1` |

## Outputs

`instance_ips` - list of public IPs.

## Run

```bash
terraform init
terraform apply -var credentials=$HOME/.config/gcloud/sa.json -var project_id=my-project \
  -var region=asia-east1 -var machine_type=e2-micro -var image_name=ubuntu-os-cloud/ubuntu-2204-lts
```
