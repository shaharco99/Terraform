output "hosts_names" {
  description = "Labels of the Linode instances"
  value       = join("\n", linode_instance.ubuntu[*].label)
}

output "public_ips" {
  description = "Public IPv4 addresses of the Linode instances"
  value       = linode_instance.ubuntu[*].ip_address
}
