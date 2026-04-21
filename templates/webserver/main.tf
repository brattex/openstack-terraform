# ---------------------------------------------------------
# WEBSERVER PROJECT TEMPLATE
# This is a ROOT MODULE.
#
# You copy this folder into:
#   projects/<project-name>/
#
# Then run Terraform from inside that project folder.
#
# This root module:
#   - configures the OpenStack provider
#   - creates a network stack (network + subnet + router)
#   - deploys a webserver VM using the webserver role
# ---------------------------------------------------------

/*
Assumes the layout in the repo:
openstack-terraform/
├── modules/
│   ├── network/
│   ├── compute/
│   ├── floatingip/
│   ├── security/
│   └── role/webserver/
└── templates/
    └── webserver/
*/


terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.0"
    }
  }
}

# ---------------------------------------------------------
# PROVIDER CONFIGURATION
# Authentication comes from your sourced OpenStack RC file.
# ---------------------------------------------------------
provider "openstack" {}

# ---------------------------------------------------------
# NETWORK STACK
# Creates:
#   - local network
#   - subnet
#   - router
#
# This ensures each project is fully isolated.
# ---------------------------------------------------------
module "network" {
  source = "../../modules/network"

  external_network_name = var.external_network_name
}

# ---------------------------------------------------------
# WEBSERVER ROLE
# This composes:
#   - compute module
#   - security groups (base + public-ssh + web)
#   - floating IP allocation
#
# This is the reusable VM TYPE.
# ---------------------------------------------------------
module "webserver" {
  #source = "../../modules/role/webserver"
  source = "role/webserver"	# Clean module reference (replaced ../../)

  # Instance identity
  name        = var.instance_name
  flavor_name = var.flavor_name
  image_id    = var.image_id
  key_name    = var.key_name

  # Network wiring
  network_id = module.network.network_id
  subnet_id  = module.network.subnet_id

  # Floating IP external network
  external_network_name = var.external_network_name
}
