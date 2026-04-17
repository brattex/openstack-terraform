# ---------------------------------------------------------
# INPUT VARIABLES FOR THE WEBSERVER TEMPLATE
# These are the knobs you turn per project.
# ---------------------------------------------------------

variable "instance_name" {
  type        = string
  description = "Name of the webserver instance."
}

variable "external_network_name" {
  type        = string
  description = "Name of the external/public network for floating IPs."
}

variable "flavor_name" {
  type        = string
  description = "Flavor name for the webserver instance."
}

variable "image_id" {
  type        = string
  description = "Image ID to use for the webserver instance."
}

variable "key_name" {
  type        = string
  description = "OpenStack keypair name to inject into the instance."
}
