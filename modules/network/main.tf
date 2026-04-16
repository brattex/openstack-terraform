# ------------------------------
# NETWORK MODULE
# Creates:
#   - A private network ("localnet")
#   - A subnet (10.10.10.0/24)
#   - A router connected to the external network
#   - A router interface attaching the subnet to the router
# ------------------------------


terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.0"
    }
  }
}


# Name of the external network (e.g., "Public Internet")
variable "external_network_name" {
  type = string
}

# Create the internal network "localnet"
resource "openstack_networking_network_v2" "localnet" {
  name           = "localnet"
  admin_state_up = true
}

# Create the subnet inside the network 
resource "openstack_networking_subnet_v2" "localnet_subnet" {
  name        = "localnet"
  network_id  = openstack_networking_network_v2.localnet.id
  cidr        = "10.10.10.0/24"
  ip_version  = 4
  gateway_ip  = "10.10.10.1"
  enable_dhcp = true

  dns_nameservers = ["1.1.1.1"]
}

# Look up the external network by name
data "openstack_networking_network_v2" "external" {
  name = var.external_network_name
}

# Create a router and attach it to the external network
resource "openstack_networking_router_v2" "router" {
  name             = "router"
  external_gateway = data.openstack_networking_network_v2.external.id
}

# Attach the subnet to the router
resource "openstack_networking_router_interface_v2" "router_localnet" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.localnet_subnet.id
}
