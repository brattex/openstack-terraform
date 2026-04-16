# ------------------------------
# GENERIC ROLE
# Base security only
# ------------------------------

module "base" {
  source = "../../security/base"
}

module "compute" {
  source = "../../compute"

  name               = var.name
  flavor_name        = var.flavor_name
  image_id           = var.image_id
  key_name           = var.key_name
  network_id         = var.network_id
  subnet_id          = var.subnet_id
  security_group_ids = [module.base.id]
}
