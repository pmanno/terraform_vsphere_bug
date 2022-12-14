###
### BASE SERVICES
###
module "bind" {
  source = "../../../../../modules/vsphere_bind"
  INSTANCE_COUNT = 1
  INSTANCE_DNS_DOMAIN_SUFFIX = var.INSTANCE_DNS_DOMAIN_SUFFIX
  VSPHERE_PASSWORD = var.VSPHERE_PASSWORD
  VSPHERE_SERVER = var.VSPHERE_SERVER
  VSPHERE_DATACENTER = var.VSPHERE_DATACENTER
  VSPHERE_CLUSTER = var.VSPHERE_CLUSTER
  VSPHERE_USERNAME = var.VSPHERE_USERNAME
  VSPHERE_VM_NETWORK = var.VSPHERE_VM_NETWORK
  VSPHERE_ESX_DATASTORE = var.VSPHERE_ESX_DATASTORE
  VSPHERE_ESX_HOST = var.VSPHERE_ESX_HOST
  ENVIRONMENT_TARGET = var.ENVIRONMENT_TARGET
  INSTANCE_DNS_SERVER_NAMES = var.DNS_SERVER_NAMES
  INSTANCE_DNS_SERVER_IPS = var.DNS_SERVER_IPS
  INSTANCE_IP_ADDRESS = var.INSTANCE_IP_ADDRESS
  INSTANCE_IP_NETMASK = var.INSTANCE_IP_NETMASK
  INSTANCE_IP_GATEWAY = var.INSTANCE_IP_GATEWAY
}
module "consul" {
  depends_on = [
    module.bind.bind_ips
  ]
  source = "../../../../../modules/vsphere_consul"
  INSTANCE_START_INDEX = var.INSTANCE_START_INDEX
  INSTANCE_DNS_DOMAIN_SUFFIX = var.INSTANCE_DNS_DOMAIN_SUFFIX
  VSPHERE_PASSWORD = var.VSPHERE_PASSWORD
  VSPHERE_SERVER = var.VSPHERE_SERVER
  VSPHERE_DATACENTER = var.VSPHERE_DATACENTER
  VSPHERE_CLUSTER = var.VSPHERE_CLUSTER
  VSPHERE_USERNAME = var.VSPHERE_USERNAME
  VSPHERE_VM_NETWORK = var.VSPHERE_VM_NETWORK
  VSPHERE_ESX_DATASTORE = var.VSPHERE_ESX_DATASTORE
  VSPHERE_ESX_HOST = var.VSPHERE_ESX_HOST
  ENVIRONMENT_TARGET = var.ENVIRONMENT_TARGET
}