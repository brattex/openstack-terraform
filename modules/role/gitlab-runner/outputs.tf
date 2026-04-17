# ---------------------------------------------------------
# OUTPUTS FOR GITLAB RUNNER ROLE MODULE
# ---------------------------------------------------------

output "instance_id" {
  description = "Instance ID of the GitLab Runner VM."
  value       = module.compute.instance_id
}

output "floating_ip" {
  description = "Floating IP of the GitLab Runner VM."
  value       = var.enable_floating_ip ? module.floatingip[0].address : null
}
