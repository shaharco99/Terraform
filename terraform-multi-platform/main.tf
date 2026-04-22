# AWS EC2 Instances
data "aws_ami" "ubuntu" {
  count       = var.platform == "aws" ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "ec2" {
  count         = var.platform == "aws" ? var.instance_count : 0
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.ubuntu[0].id
  instance_type = var.instance_type

  tags = merge(var.tags, {
    Name = "multi-platform-ec2-${count.index + 1}"
  })
}

# Azure VMs
resource "azurerm_resource_group" "rg" {
  count    = var.platform == "azure" ? 1 : 0
  name     = var.resource_group_name
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  count               = var.platform == "azure" ? 1 : 0
  name                = "multi-platform-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg[0].location
  resource_group_name = azurerm_resource_group.rg[0].name
}

resource "azurerm_subnet" "subnet" {
  count                = var.platform == "azure" ? 1 : 0
  name                 = "multi-platform-subnet"
  resource_group_name  = azurerm_resource_group.rg[0].name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  count               = var.platform == "azure" ? var.instance_count : 0
  name                = "multi-platform-nic-${count.index + 1}"
  location            = azurerm_resource_group.rg[0].location
  resource_group_name = azurerm_resource_group.rg[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_public_ip" "pip" {
  count               = var.platform == "azure" ? var.instance_count : 0
  name                = "multi-platform-pip-${count.index + 1}"
  location            = azurerm_resource_group.rg[0].location
  resource_group_name = azurerm_resource_group.rg[0].name
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.platform == "azure" ? var.instance_count : 0
  name                = "multi-platform-vm-${count.index + 1}"
  resource_group_name = azurerm_resource_group.rg[0].name
  location            = azurerm_resource_group.rg[0].location
  size                = var.instance_type
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.authorized_key != "" ? var.authorized_key : file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-compute"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}

# GCP Compute Instances
resource "google_compute_instance" "vm" {
  count        = var.platform == "gcp" ? var.instance_count : 0
  name         = "multi-platform-vm-${count.index + 1}"
  machine_type = var.instance_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/${var.image_name}"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = var.authorized_key != "" ? "ubuntu:${var.authorized_key}" : "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = values(var.tags)
}

# Linode Instances
resource "linode_instance" "instance" {
  count      = var.platform == "linode" ? var.instance_count : 0
  label      = "multi-platform-linode-${count.index + 1}"
  region     = var.region
  type       = var.instance_type
  image      = var.image_name
  authorized_keys = [var.authorized_key]
  root_pass  = var.root_pass

  tags = values(var.tags)
}

# Docker Container
resource "docker_image" "image" {
  count = var.platform == "docker" ? 1 : 0
  name  = var.docker_image
}

resource "docker_container" "container" {
  count = var.platform == "docker" ? var.instance_count : 0
  image = docker_image.image[0].image_id
  name  = "multi-platform-container-${count.index + 1}"

  ports {
    internal = 80
    external = 8080 + count.index
  }
}