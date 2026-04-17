# ---------------------------------------------------------
# GitLab Runner Role Module
# ---------------------------------------------------------
# This module composes:
#   - compute module
#   - security groups
#   - optional floating IP
# ---------------------------------------------------------

module "compute" {
  # Use the compute module to create the VM
  source = "../../compute"

  name        = var.name
  flavor_name = var.flavor_name
  image_id    = var.image_id
  key_name    = var.key_name

  network_id = var.network_id
  subnet_id  = var.subnet_id

  security_group_ids = [
    var.base_sg_id,
    var.gitlab_runner_sg_id
  ]
}

module "floatingip" {
  # Allocate a floating IP if enabled
  source = "../../floatingip"
  count  = var.enable_floating_ip ? 1 : 0

  external_network_name = var.external_network_name
  port_id               = module.compute.port_id
}

