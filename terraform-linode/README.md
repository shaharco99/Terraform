# terraform-linode

Learning lab. Creates `instance_count` Ubuntu Linode instances labelled `<label_prefix>-<n>`, and one DigitalOcean DNS A record per instance (`<label>.<dns_domain>`). After apply, a `null_resource` writes the labels to `ansible/hosts` under `[linode_hosts]`.

## Inputs

`token` (Linode), `tokendig` (DigitalOcean), `root_pass` - sensitive; `region`, `label_prefix`, `authorized_key`, `dns_domain`; `instance_count` (default `1`), `image` (default `linode/ubuntu20.04`), `instance_type` (default `g6-nanode-1`).

## Outputs

`hosts_names` (newline-separated), `public_ips`.

## Run

```bash
export TF_VAR_token=... TF_VAR_tokendig=... TF_VAR_root_pass=...
terraform init
terraform apply
```
