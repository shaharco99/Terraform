output "private_ip" {
  description = "private ip"
  value = join("\n", aws_instance.ubuntu.*.private_ip)
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value = join("\n",aws_instance.ubuntu.*.public_ip)
}

output "hosts_names" {
  description = "Hosts name of the EC2 instance"
  value = join("\n",aws_instance.ubuntu.*.tags.Name)
}
#
#output "list_of_public_ips_and_hosts" {
#  description = "Public IP address and hosts name of the EC2 instance"
#  value = join("\n",concat(aws_instance.ubuntu.*.tags.Name, aws_instance.ubuntu.*.public_ip))
#}