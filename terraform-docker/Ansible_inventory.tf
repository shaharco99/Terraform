resource "null_resource" "after_docker" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [docker_container.ubuntu]
  #create Ansible Inventory when destroy
  provisioner "local-exec" {
    command = "mkdir -p ansible && echo  \"[Docker_hosts]\" > ./ansible/hosts "
  }
  #add hosts name to Ansible Inventory
  provisioner "local-exec" {
    command = "terraform output -raw hostnames >> ./ansible/hosts"
    when = create
  }
}