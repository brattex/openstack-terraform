# ------------------------------
# COMPUTE MODULE
# Creates:
#   - A port on the network
#   - A VM instance attached to that port
# ------------------------------

terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.0"
    }
  }
}

variable "name" { type = string }
variable "flavor_name" { type = string }
variable "image_id" { type = string }
variable "key_name" { type = string }
variable "network_id" { type = string }
variable "subnet_id" { type = string }
variable "security_group_ids" { type = list(string) }

# Create a port for the VM
resource "openstack_networking_port_v2" "port" {
  name       = "${var.name}-port"
  network_id = var.network_id

  fixed_ip {
    subnet_id  = var.subnet_id
    ip_address = "10.10.10.10"
  }

  security_group_ids = var.security_group_ids
}

# Create the VM instance
resource "openstack_compute_instance_v2" "instance" {
  name        = var.name
  flavor_name = var.flavor_name
  image_id    = var.image_id
  key_pair    = var.key_name

  network {
    port = openstack_networking_port_v2.port.id
  }
}


