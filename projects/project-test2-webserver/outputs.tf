# ---------------------------------------------------------
# OUTPUTS FOR THE WEBSERVER PROJECT
# These expose useful information after deployment.
# ---------------------------------------------------------

output "instance_id" {
  description = "Instance ID of the deployed webserver."
  value       = module.webserver.instance_id
}

output "floating_ip" {
  description = "Floating IP address of the webserver."
  value       = module.webserver.floating_ip
}
