output "network_id" {
  value = openstack_networking_network_v2.localnet.id
}

output "subnet_id" {
  value = openstack_networking_subnet_v2.localnet_subnet.id
}

output "external_network_id" {
  value = data.openstack_networking_network_v2.external.id
}
