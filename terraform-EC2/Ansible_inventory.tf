resource "null_resource" "after_aws_instance" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_instance.ubuntu]
  # Recreate the inventory file with a group header
  provisioner "local-exec" {
    command = "mkdir -p ansible && echo  \"[EC2_hosts]\" > ./ansible/hosts "
  }
  # Append instance names from the hosts_names output
  provisioner "local-exec" {
    command = "terraform output -raw hosts_names >> ./ansible/hosts"
    when    = create
  }
}