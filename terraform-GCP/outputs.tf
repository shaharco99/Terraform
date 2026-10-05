output "instance_ips" {
  description = "Public (NAT) IPs of the instances"
  value       = google_compute_instance.ubuntu_instance[*].network_interface[0].access_config[0].nat_ip
}
