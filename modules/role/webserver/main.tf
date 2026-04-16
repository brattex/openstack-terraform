# use base security
module "base" {
  source = "../../security/base"
}

# allow incoming SSH
module "public_ssh" {
  source = "../../security/public-ssh"
}

# enable standard web
module "web" {
  source = "../../security/web"
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
    module.web.id,
  ]
}
