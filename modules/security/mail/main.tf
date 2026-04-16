# ------------------------------
# MAIL SECURITY GROUP
# Allows SMTP, Submission, IMAPS
# ------------------------------

resource "openstack_networking_secgroup_v2" "mail" {
  name        = "mail"
  description = "Mail server ports"
}

resource "openstack_networking_secgroup_rule_v2" "smtp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 25
  port_range_max    = 25
  security_group_id = openstack_networking_secgroup_v2.mail.id
}

resource "openstack_networking_secgroup_rule_v2" "submission" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 587
  port_range_max    = 587
  security_group_id = openstack_networking_secgroup_v2.mail.id
}

resource "openstack_networking_secgroup_rule_v2" "imap_ssl" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 993
  port_range_max    = 993
  security_group_id = openstack_networking_secgroup_v2.mail.id
}
