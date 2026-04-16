# ------------------------------
# PUBLIC SSH SECURITY GROUP
# Allows SSH from anywhere.
# ------------------------------

resource "openstack_networking_secgroup_v2" "public_ssh" {
  name        = "public-ssh"
  description = "Allow SSH from anywhere"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = openstack_networking_secgroup_v2.public_ssh.id
}
