# ------------------------------
# INTERNAL-ONLY SECURITY GROUP
# Allows access ONLY from inside 10.10.10.0/24
# ------------------------------

terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.0"
    }
  }
}

resource "openstack_networking_secgroup_v2" "internal" {
  name        = "internal-only"
  description = "Allow only internal subnet access"
}

resource "openstack_networking_secgroup_rule_v2" "internal_all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "10.10.10.0/24"
  security_group_id = openstack_networking_secgroup_v2.internal.id
}

