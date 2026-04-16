output "instance_id" {
  value = openstack_compute_instance_v2.instance.id
}

output "port_id" {
  value = openstack_networking_port_v2.port.id
}
