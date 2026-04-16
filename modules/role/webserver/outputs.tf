# Expose the instance ID
output "instance_id" {
  value = module.compute.instance_id
}

# Expose the floating IP address
output "floating_ip" {
  value = module.floatingip.address
}
