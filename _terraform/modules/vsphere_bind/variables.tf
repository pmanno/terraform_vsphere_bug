variable "VSPHERE_USERNAME"{
  type = string
}
variable "VSPHERE_PASSWORD"{
  type = string
}
variable "VSPHERE_SERVER"{
  type = string
}
variable "VSPHERE_DATACENTER"{
  type = string
}
variable "VSPHERE_CLUSTER"{
  type = string
}
variable "VSPHERE_ESX_DATASTORE"{
  type = string
}
variable "VSPHERE_ESX_HOST"{
  type = string
}
variable "VSPHERE_VM_NETWORK" {
  type = string
}
variable "INSTANCE_START_INDEX" {
  type = number
  default = 0
}
variable "INSTANCE_COUNT" {
  type = number
  default = 1
}
variable "INSTANCE_PREFIX"{
  type = string
  default = "bind"
}
variable "INSTANCE_DNS_DOMAIN_SUFFIX"{
  type = string
}
variable "ENVIRONMENT_TARGET" {
  type = string
}
variable "INSTANCE_DNS_SERVER_NAMES" {
  type = list(string)
}
variable "INSTANCE_DNS_SERVER_IPS" {
  type = list(string)
}
variable "INSTANCE_IP_ADDRESS" {
  type = string
}
variable "INSTANCE_IP_NETMASK" {
  type = string
}
variable "INSTANCE_IP_GATEWAY" {
  type = string
}