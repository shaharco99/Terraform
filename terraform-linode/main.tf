resource "linode_instance" "ubuntu" {
  count            = var.instance_count
  label            = "${var.label_prefix}-${count.index + 1}"
  image            = var.image
  region           = var.region
  type             = var.instance_type
  swap_size        = 1024
  authorized_keys  = [var.authorized_key]
  root_pass        = var.root_pass
  backups_enabled  = false
  booted           = true
  watchdog_enabled = true
  tags             = ["ubuntu"]
}

# One DigitalOcean DNS A record per instance: <label>.<dns_domain>
resource "digitalocean_record" "instance" {
  count  = var.instance_count
  domain = var.dns_domain
  type   = "A"
  name   = linode_instance.ubuntu[count.index].label
  ttl    = 1800
  value  = linode_instance.ubuntu[count.index].ip_address
}

resource "null_resource" "after_linode_instance" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [linode_instance.ubuntu]
  # Recreate the inventory file with a group header
  provisioner "local-exec" {
    command = "mkdir -p ansible && echo \"[linode_hosts]\" > ./ansible/hosts"
  }
  # Append instance labels from the hosts_names output
  provisioner "local-exec" {
    command = "terraform output -raw hosts_names >> ./ansible/hosts"
  }
}
