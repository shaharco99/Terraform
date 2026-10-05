# Launches var.amount_of_instance Ubuntu 22.04 EC2 instances that install
# Docker and run nginx on port 80 via user data (templates/ubuntu.sh).
#
#   terraform init && terraform plan && terraform apply
#   terraform destroy -target 'aws_instance.ubuntu[INDEX]'   # remove one instance

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ubuntu" {
  count         = var.amount_of_instance
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags = {
    Name = "ubuntu_22.04_${count.index + 1}"
  }
  lifecycle {
    # Tags and instance type may be changed outside Terraform.
    ignore_changes = [tags, instance_type]
  }
  user_data = file("${path.module}/templates/ubuntu.sh")
}
