
output "public_ips" {
  description = "Public IP address of the Azure instance"
  value = join("\n",  azurerm_public_ip.test.*.ip_address)
}

output "hosts_name" {
  description = "hosts name of the Azure instance"
  value = join("\n",  azurerm_virtual_machine.test.*.name)
}
