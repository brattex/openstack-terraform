# ---------------------------------------------------------
# INPUT VARIABLES FOR GITLAB RUNNER TEMPLATE
# ---------------------------------------------------------

variable "instance_name" {
  type        = string
  description = "Name of the GitLab Runner instance."
}

variable "external_network_name" {
  type        = string
  description = "External network for floating IP allocation."
}

variable "flavor_name" {
  type        = string
  description = "Flavor for the GitLab Runner VM."
}

variable "image_id" {
  type        = string
  description = "Image ID for the GitLab Runner VM."
}

variable "key_name" {
  type        = string
  description = "OpenStack keypair name."
}

variable "admin_cidr" {
  type        = string
  description = "CIDR allowed to SSH into the runner."
}

