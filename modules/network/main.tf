variable "external_network_name" {
  type = string
}

resource "openstack_networking_network_v2" "localnet" {
  name           = "localnet"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "localnet_subnet" {
  name        = "localnet"
  network_id  = openstack_networking_network_v2.localnet.id
  cidr        = "10.10.10.0/24"
  ip_version  = 4
  gateway_ip  = "10.10.10.1"
  enable_dhcp = true

  dns_nameservers = ["1.1.1.1"]
}

data "openstack_networking_network_v2" "external" {
  name = var.external_network_name
}

resource "openstack_networking_router_v2" "router" {
  name             = "router"
  external_gateway = data.openstack_networking_network_v2.external.id
}

resource "openstack_networking_router_interface_v2" "router_localnet" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.localnet_subnet.id
}
