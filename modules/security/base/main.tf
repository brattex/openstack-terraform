# base security group for all instances

resource "openstack_networking_secgroup_v2" "base" {
  name        = "base"
  description = "Base security group for all machines"
}

# Enable ICMP
resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.base.id
}
