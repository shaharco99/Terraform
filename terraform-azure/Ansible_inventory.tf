resource "null_resource" "Azure_virtual_machine" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [azurerm_virtual_machine.test]
  #create Ansible Inventory when destroy
  provisioner "local-exec" {
    command = "mkdir -p ansible && echo  \"[Azure_hosts]\" > ./ansible/hosts "
  }
  #add hosts name to Ansible Inventory
  provisioner "local-exec" {
    command = "terraform output -raw hosts_name >> ./ansible/hosts"
    when = create
  }
}