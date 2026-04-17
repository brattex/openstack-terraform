# ---------------------------------------------------------
# OUTPUTS FOR GITLAB RUNNER PROJECT
# ---------------------------------------------------------

output "instance_id" {
  description = "Instance ID of the GitLab Runner VM."
  value       = module.gitlab_runner.instance_id
}

output "floating_ip" {
  description = "Floating IP of the GitLab Runner VM."
  value       = module.gitlab_runner.floating_ip
}

