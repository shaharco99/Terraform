# Multi-Platform Terraform Infrastructure

This Terraform project allows you to deploy infrastructure across multiple cloud platforms using a single configuration. Simply change the `platform` variable to switch between AWS, Azure, GCP, Linode, or Docker.

## Supported Platforms

- **AWS**: EC2 instances
- **Azure**: Linux Virtual Machines with networking
- **GCP**: Compute Engine instances
- **Linode**: Linode instances
- **Docker**: Docker containers (local)

## Usage

1. **Set your platform:**
   ```hcl
   platform = "aws"  # or "azure", "gcp", "linode", "docker"
   ```

2. **Configure provider credentials:**
   - For AWS: Set `aws_access_key` and `aws_secret_key`
   - For Azure: Set `azure_subscription_id`, `azure_client_id`, `azure_client_secret`, `azure_tenant_id`
   - For GCP: Set `gcp_credentials_file` to path of JSON credentials
   - For Linode: Set `linode_token`, `authorized_key`, `root_pass`
   - For Docker: No additional credentials needed

   **Note:** Terraform will attempt to configure all providers during planning. Only provide credentials for the platform you intend to use to avoid authentication errors.

3. **Customize deployment:**
   ```hcl
   instance_count = 2
   instance_type  = "t2.micro"  # or equivalent for your platform
   region         = "us-east-1"
   ```

4. **Deploy:**
   ```bash
   terraform init
   terraform plan -var="platform=aws"  # specify your platform
   terraform apply -var="platform=aws"
   ```

## Example Configuration Files

The project includes example `.tfvars.example` files for each platform that you can copy and customize:

- `aws.tfvars.example` - AWS EC2 deployment template
- `azure.tfvars.example` - Azure VM deployment template  
- `gcp.tfvars.example` - Google Cloud Compute Engine template
- `linode.tfvars.example` - Linode instance deployment template
- `docker.tfvars.example` - Docker container deployment template

To use these templates:
```bash
cp aws.tfvars.example aws.tfvars
# Edit aws.tfvars with your actual credentials and settings
```

## Outputs

- `instance_ips`: Public IP addresses
- `instance_private_ips`: Private IP addresses
- `instance_names`: Instance names/IDs
- `platform`: The platform used

## Examples

**Important:** Never commit `.tfvars` files containing real credentials to version control. Use the `.tfvars.example` files as templates.

### AWS Example
Create `aws.tfvars`:
```hcl
platform = "aws"
region = "us-east-1"
instance_count = 1
instance_type = "t2.micro"
# ami_id = ""  # Optional: specify AMI ID

# aws_access_key = "your-access-key"
# aws_secret_key = "your-secret-key"
```

Deploy:
```bash
cp aws.tfvars.example aws.tfvars
# Edit aws.tfvars with your credentials
terraform apply -var-file="aws.tfvars"
```

### Azure Example
Create `azure.tfvars`:
```hcl
platform = "azure"
region = "East US"
instance_count = 1
instance_type = "Standard_DS1_v2"
image_name = "22.04-LTS"
resource_group_name = "multi-platform-rg"

# azure_subscription_id = "your-subscription-id"
# azure_client_id = "your-client-id"
# azure_client_secret = "your-client-secret"
# azure_tenant_id = "your-tenant-id"
# authorized_key = "ssh-rsa AAAA..."
```

### GCP Example
Create `gcp.tfvars`:
```hcl
platform = "gcp"
region = "us-central1"
instance_count = 1
instance_type = "e2-micro"
image_name = "ubuntu-2204-lts"

# gcp_credentials_file = "/path/to/your/service-account.json"
# authorized_key = "ssh-rsa AAAA..."
```

### Linode Example
Create `linode.tfvars`:
```hcl
platform = "linode"
region = "us-east"
instance_count = 1
instance_type = "g6-nanode-1"
image_name = "linode/ubuntu22.04"

# linode_token = "your-linode-api-token"
# authorized_key = "ssh-rsa AAAA..."
# root_pass = "your-secure-root-password"
```

### Docker Example
Create `docker.tfvars`:
```hcl
platform = "docker"
instance_count = 1
docker_image = "nginx:latest"
```

## Security Notes

- **Never commit `.tfvars` files** containing real credentials to version control
- Use the provided `.tfvars.example` files as templates
- The `.gitignore` file is configured to exclude sensitive files
- Consider using environment variables or secret management tools for credentials in production