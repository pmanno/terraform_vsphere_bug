output "bind_ips" {
  description = "Bind instance IPs."
  value       = vsphere_virtual_machine.vm.*.default_ip_address
}
output "bind_hostnames" {
  description = "Bind instance IPs."
  value       = vsphere_virtual_machine.vm.*.name
}