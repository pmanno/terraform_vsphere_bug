output "consul_hostnames" {
  description = "Hostnames of consul instances."
  value       = vsphere_virtual_machine.vm.*.name
}
output "consul_ips" {
  description = "IPs of consul instances."
  value       = vsphere_virtual_machine.vm.*.default_ip_address
}