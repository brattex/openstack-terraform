# ------------------------------
# MAILSERVER ROLE
# Base + Public SSH + Mail + Floating IP
# ------------------------------

module "base" {
  source = "../../security/base"
}

module "public_ssh" {
  source = "../../security/public-ssh"
}

module "mail" {
  source = "../../security/mail"
}

module "compute" {
  source = "../../compute"

  name               = var.name
  flavor_name        = var.flavor_name
  image_id           = var.image_id
  key_name           = var.key_name
  network_id         = var.network_id
  subnet_id          = var.subnet_id

  security_group_ids = [
    module.base.id,
    module.public_ssh.id,
    module.mail.id,
  ]
}

module "floatingip" {
  source = "../../floatingip"

  external_network_name = var.external_network_name
  port_id               = module.compute.port_id
}
