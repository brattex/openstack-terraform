# Expose the network ID so other modules can attach ports
output "network_id" {
  value = openstack_networking_network_v2.localnet.id
}

# Expose the subnet ID so compute modules can assign IPs
output "subnet_id" {
  value = openstack_networking_subnet_v2.localnet_subnet.id
}

# Expose the external network ID (useful for floating IPs)
output "external_network_id" {
  value = data.openstack_networking_network_v2.external.id
}
