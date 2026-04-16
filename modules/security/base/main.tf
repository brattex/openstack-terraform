# ------------------------------
# BASE SECURITY GROUP
# Applies to ALL machines.
# Contains only ICMP (ping).
# ------------------------------

terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.0"
    }
  }
}

resource "openstack_networking_secgroup_v2" "base" {
  name        = "base"
  description = "Base security group for all machines"
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.base.id
}

