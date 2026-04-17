# ---------------------------------------------------------
# INPUT VARIABLES FOR GITLAB RUNNER ROLE MODULE
# ---------------------------------------------------------

variable "name" {
  type        = string
  description = "Name of the GitLab Runner VM."
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

variable "network_id" {
  type        = string
  description = "Network ID for the VM."
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the VM."
}

variable "base_sg_id" {
  type        = string
  description = "Base security group ID."
}

variable "gitlab_runner_sg_id" {
  type        = string
  description = "GitLab Runner security group ID."
}

variable "external_network_name" {
  type        = string
  description = "External network for floating IP allocation."
}

variable "enable_floating_ip" {
  type        = bool
  default     = true
  description = "Whether to allocate a floating IP."
}
