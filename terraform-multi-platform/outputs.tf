locals {
  instance_ips_map = {
    aws    = aws_instance.ec2[*].public_ip
    azure  = azurerm_public_ip.pip[*].ip_address
    gcp    = google_compute_instance.vm[*].network_interface[0].access_config[0].nat_ip
    linode = linode_instance.instance[*].ip_address
    docker = ["localhost"]
  }

  instance_private_ips_map = {
    aws    = aws_instance.ec2[*].private_ip
    azure  = azurerm_network_interface.nic[*].private_ip_address
    gcp    = google_compute_instance.vm[*].network_interface[0].network_ip
    linode = linode_instance.instance[*].private_ip_address
    docker = ["localhost"]
  }

  instance_names_map = {
    aws    = aws_instance.ec2[*].id
    azure  = azurerm_linux_virtual_machine.vm[*].name
    gcp    = google_compute_instance.vm[*].name
    linode = linode_instance.instance[*].label
    docker = docker_container.container[*].name
  }

  instance_ips         = lookup(local.instance_ips_map, var.platform, [])
  instance_private_ips = lookup(local.instance_private_ips_map, var.platform, [])
  instance_names       = lookup(local.instance_names_map, var.platform, [])
}

output "instance_ips" {
  description = "Public IPs of the created instances"
  value       = local.instance_ips
}

output "instance_private_ips" {
  description = "Private IPs of the created instances"
  value       = local.instance_private_ips
}

output "instance_names" {
  description = "Names/IDs of the created instances"
  value       = local.instance_names
}

output "platform" {
  description = "The platform used for deployment"
  value       = var.platform
}
