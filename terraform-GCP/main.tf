provider "google" {
  credentials = file(var.credentials)
  project     = "devops-394908"
  region      = var.region
}

resource "google_compute_instance" "ubuntu_instance" {
  count        = var.amount_of_instance
  name         = "ubuntu-instance-${count.index}"
  machine_type = var.machine_type
  zone         = "asia-east1-a"
  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}

output "instance_ips" {
  value = google_compute_instance.ubuntu_instance[*].network_interface[0].access_config[0].nat_ip
}