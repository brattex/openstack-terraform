# ---------------------------------------------------------
# GitLab Runner Project Template (Root Module)
# ---------------------------------------------------------
# This root module:
#   - configures the OpenStack provider
#   - creates an isolated network stack
#   - creates security groups for the runner
#   - deploys a GitLab Runner VM using the gitlab-runner role
# ---------------------------------------------------------

terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54.0"
    }
  }
}

# Use OpenStack credentials from your sourced RC file
provider "openstack" {}

# ---------------------------------------------------------
# NETWORK STACK
# Creates:
#   - network
#   - subnet
#   - router
# ---------------------------------------------------------
module "network" {
  source = "../../modules/network"
  external_network_name = var.external_network_name
}

# ---------------------------------------------------------
# SECURITY GROUPS
# Base SG: outbound allowed, inbound denied
# GitLab Runner SG: SSH from admin CIDR
# ---------------------------------------------------------
module "base_sg" {
  source = "../../modules/security/base"
  name   = var.instance_name
}

module "gitlab_runner_sg" {
  source = "../../modules/security/gitlab-runner"
  name        = var.instance_name
  admin_cidr  = var.admin_cidr
}

# ---------------------------------------------------------
# GITLAB RUNNER ROLE
# Composes:
#   - compute
#   - security groups
#   - floating IP
# ---------------------------------------------------------
module "gitlab_runner" {
  source = "../../modules/role/gitlab-runner"

  name        = var.instance_name
  flavor_name = var.flavor_name
  image_id    = var.image_id
  key_name    = var.key_name

  network_id = module.network.network_id
  subnet_id  = module.network.subnet_id

  base_sg_id        = module.base_sg.id
  gitlab_runner_sg_id = module.gitlab_runner_sg.id

  external_network_name = var.external_network_name
  enable_floating_ip    = true
}

