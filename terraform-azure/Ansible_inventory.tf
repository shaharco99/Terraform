resource "null_resource" "Azure_virtual_machine" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [azurerm_virtual_machine.test]
  # Recreate the inventory file with a group header
  provisioner "local-exec" {
    command = "mkdir -p ansible && echo  \"[Azure_hosts]\" > ./ansible/hosts "
  }
  # Append VM names from the hosts_name output
  provisioner "local-exec" {
    command = "terraform output -raw hosts_name >> ./ansible/hosts"
    when    = create
  }
}