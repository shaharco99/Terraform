resource "null_resource" "after_aws_instance" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_instance.ubuntu]
  #create Ansible Inventory when destroy
  provisioner "local-exec" {
    command = "mkdir -p ansible && echo  \"[EC2_hosts]\" > ./ansible/hosts "
  }
  #add hosts name to Ansible Inventory
  provisioner "local-exec" {
    command = "terraform output -raw hosts_names >> ./ansible/hosts"
    when = create
  }
}