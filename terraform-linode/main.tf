
resource "linode_instance" "ubuntu" {
  count = 0
  label = "kala-${count.index + 1}"
  image = "linode/ubuntu20.04lts" #change for newer version
  region = region
  type = "g6-nanode-1"
  swap_size = 1024
  authorized_keys = var.authorized_key
  root_pass = var.root_pass
  backups_enabled = false
  booted = true
  watchdog_enabled = true
  tags= ["ubuntu20.4"]
}

resource "null_resource" "after_linode_instance" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [linode_instance.ubuntu]
  #create Ansible Inventory when not excite
  provisioner "local-exec" {
    command = "mkdir -p ansible && echo  \"[linode_hosts]\" > ./ansible/Inventory "
  }
  #add hosts name to Ansible Inventory
  provisioner "local-exec" {
    command = "terraform output -raw hosts_names >> ./ansible/Inventory"
    when = create
  }
}
# Add an A record to the domain for www.example.com.
resource "digitalocean_record" "www" {
  domain = "kala-crm.co.il"
  type   = "A"
  name   = linode_instance.ubuntu.*.label
  ttl    =  1800
  value  = linode_instance.ubuntu.*.ipv4
}

#TODO maybe not needed if the label is not the customer name
resource "digitalocean_record" "nop" {
  domain = "kala-crm.co.il"
  type   = "A"
  name   = "kala-" + linode_instance.ubuntu.*.label
  ttl    =  1800
  value  = linode_instance.ubuntu.*.ipv4
}

resource "null_resource" "after_linode_instance" {
  depends_on = [linode_instance.ubuntu]
  #Create Masters Inventory
  provisioner "local-exec" {
    command =  "echo  \"[linode_hosts]\" > ./ansible/hosts"
  }
  #add hosts to Ansible Inventory file
  provisioner "local-exec" {
    command = "terraform output -json hosts_names >> ./ansible/hosts"
  }
}

variable "root_pass" {
  type = string
}

variable "region" {
  type = string
}
variable "authorized_key" {
  type = string
}