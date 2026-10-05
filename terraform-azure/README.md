# terraform-azure

Learning lab. Creates a resource group, a VNet with one subnet, and `countVMs` Ubuntu 18.04 VMs (`azurerm_virtual_machine`, legacy resource) each with a dynamic public IP, an empty 1023 GB data disk and a second attached managed disk. Password SSH login is enabled. After apply, a `null_resource` writes the VM names to `ansible/hosts` under `[Azure_hosts]`.

## Inputs

| Variable | Default |
|---|---|
| `admin_password` | - (sensitive) |
| `admin_username` | `testadmin` |
| `countVMs` | `2` |
| `resource_group_name` | `RG_test` |
| `resource_group_location` | `Central US` |
| `vm_size` | `Standard_DS1` |

## Outputs

`public_ips`, `hosts_name` (newline-separated). Dynamic public IPs are only assigned once the VM is running, so `public_ips` can be empty right after the first apply; run `terraform refresh`.

## Run

```bash
az login
export TF_VAR_admin_password='...'
terraform init
terraform apply
```
