# -----------------------------------------
# VARIABLES FOR THE WEBSERVER ROLE MODULE
# These must match what the root module passes in.
# -----------------------------------------

variable "name" {
  type = string
}

variable "flavor_name" {
  type = string
}

variable "image_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "external_network_name" {
  type = string
}
