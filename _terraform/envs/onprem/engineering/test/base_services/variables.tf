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
  default = "engesx01"
}
variable "VSPHERE_ESX_HOST"{
  type = string
  default = "engesx01.mydomain.net"
}
variable "VSPHERE_VM_NETWORK" {
  type = string
  default = "test"
}
variable "INSTANCE_START_INDEX" {
  type = number
  default = 0
}
variable "ELASTIC_INSTANCE_START_INDEX" {
  type = number
  default = 0
}
variable "REDIS_INSTANCE_START_INDEX" {
  type = number
  default = 0
}
variable "ELK_INSTANCE_DISK_SIZE" {
  type = number
  default = 30
}
variable "INSTANCE_DNS_DOMAIN_SUFFIX"{
  type = string
  default = "test.mydomain.net"
}
variable "ENVIRONMENT_TARGET" {
  type = string
  default = "test"
}
variable "DOMAIN_ADMIN_PASSWORD"{
  type = string
}
variable "DNS_SERVER_NAMES" {
  type = list(string)
  default = ["dns1.mydomain.com","dns2.mydomain.com"]
}
variable "DNS_SERVER_IPS" {
  type = list(string)
  default = ["10.1.1.2","10.1.1.3"]
}
variable "INSTANCE_IP_ADDRESS" {
  type = string
  default = "10.1.1.10"
}
variable "INSTANCE_IP_NETMASK" {
  type = string
  default = "24"
}
variable "INSTANCE_IP_GATEWAY" {
  type = string
  default = "10.1.1.1"
}