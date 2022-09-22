provider "vsphere" {
  user                 = var.VSPHERE_USERNAME
  password             = var.VSPHERE_PASSWORD
  vsphere_server       = var.VSPHERE_SERVER
  allow_unverified_ssl = true
}