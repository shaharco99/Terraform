output "private_ip" {
  description = "private ip"
  value       = join("\n", aws_instance.ubuntu.*.private_ip)
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = join("\n", aws_instance.ubuntu.*.public_ip)
}

output "hosts_names" {
  description = "Hosts name of the EC2 instance"
  value       = join("\n", aws_instance.ubuntu.*.tags.Name)
}
