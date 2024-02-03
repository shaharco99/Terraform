#output "linode_provision_domain_id" {
#  value =  join("\n",linode_instance.ubuntu.*.ipv4)
#}

output "hosts_names" {
  description = "names of the linode instance created"
  value = join("\n",linode_instance.ubuntu.*.label)
}