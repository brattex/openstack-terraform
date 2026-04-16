# ------------------------------
# FLOATING IP MODULE
# Creates a floating IP and attaches it to a port
# ------------------------------

variable "external_network_name" { type = string }
variable "port_id" { type = string }

resource "openstack_networking_floatingip_v2" "fip" {
  pool    = var.external_network_name
  port_id = var.port_id
}
