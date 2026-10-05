resource "google_compute_instance" "ubuntu_instance" {
  count        = var.amount_of_instance
  name         = "ubuntu-instance-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Ephemeral public IP
    }
  }
}
