# terraform-clinic

Skeleton. Declares an ECS cluster, an S3 bucket, a Route 53 hosted zone with an alias A record, and an internet-facing Network Load Balancer with a TCP target group (HTTP health check). Nothing runs in the cluster yet and the target group has no targets.

Defaults in `variables.tf` are placeholders (`vpc-12345678`, `subnet-...`, `sg-12345678`, `example.com.`); replace them before `plan`.

## Outputs

`nlb_arn`, `nlb_dns_name`, `s3_bucket_url`.

## Run

```bash
export TF_VAR_AWS_ACCESS_KEY_ID=... TF_VAR_AWS_SECRET_ACCESS_KEY=...
terraform init
terraform plan
```
