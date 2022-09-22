data "vsphere_datacenter" "datacenter" {
  name = var.VSPHERE_DATACENTER
}
data "vsphere_datastore" "datastore" {
  name          = var.VSPHERE_ESX_DATASTORE
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_host" "host" {
  name          = var.VSPHERE_ESX_HOST
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.VSPHERE_CLUSTER
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "network" {
  name          = var.VSPHERE_VM_NETWORK
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_virtual_machine" "template" {
  name          = "LIN-DEB-78929"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

########################################################################################################################
### Terraform managed Custom Attributesƒ
###
### If we declare both resources and data, then when we destroy things, those resources could get destroyed
### So for the moment I'm just commenting out the resources assuming they have been precreated by some other means.
########################################################################################################################
#resource "vsphere_custom_attribute" "os_attribute" {
#  name                = "OS"
#  managed_object_type = "VirtualMachine"
#}
data "vsphere_custom_attribute" "os_attribute" {
#  depends_on = [
#    vsphere_custom_attribute.os_attribute
#  ]
  name = "OS"
}
########################################################################################################################
### Preexisting Attribute Resource - AnsibleGroup0
########################################################################################################################
#resource "vsphere_custom_attribute" "ansible_group_0_attribute" {
#  name                = "AnsibleGroup0"
#  managed_object_type = "VirtualMachine"
#}
data "vsphere_custom_attribute" "ansible_group_0_attribute" {
  #  depends_on = [
  #    vsphere_custom_attribute.ansible_group_0_attribute
  #  ]
  name = "AnsibleGroup0"
}

########################################################################################################################
### Preexisting Attribute Resource"- Environment
########################################################################################################################
#resource "vsphere_custom_attribute" "environment_attribute" {
#  name                = "Environment"
#  managed_object_type = "VirtualMachine"
#}
data "vsphere_custom_attribute" "environment_attribute" {
#  depends_on = [
#    vsphere_custom_attribute.environment_attribute
#  ]
  name = "Environment"
}

resource "vsphere_virtual_machine" "vm" {
  count            = var.INSTANCE_COUNT
  name             = format("%s%02d.%s", var.INSTANCE_PREFIX, (var.INSTANCE_START_INDEX + count.index), var.INSTANCE_DNS_DOMAIN_SUFFIX)
  annotation       = "Build by Terraform with template ${data.vsphere_virtual_machine.template.name} on ${timestamp()}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id
  memory_hot_add_enabled = true
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  num_cpus         = 2
  memory           = 8192
  custom_attributes = {
    "${data.vsphere_custom_attribute.os_attribute.id}" = "debian"
    "${data.vsphere_custom_attribute.ansible_group_0_attribute.id}" = "consul"
    "${data.vsphere_custom_attribute.environment_attribute.id}" = var.ENVIRONMENT_TARGET
  }
  network_interface {
    network_id   = data.vsphere_network.network.id
  }
  disk {
    label            = "disk0"
    size             = 20
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      network_interface {}
      linux_options {
        host_name = format("%s%02d", var.INSTANCE_PREFIX, (var.INSTANCE_START_INDEX + count.index))
        domain    = var.INSTANCE_DNS_DOMAIN_SUFFIX
      }
    }
  }
  lifecycle {
    create_before_destroy = false
        ignore_changes = [
      annotation,
      host_system_id,
      datastore_id
    ]
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tmpl",
    {
      hostnames      = vsphere_virtual_machine.vm.*.name
      ansible_hosts  = vsphere_virtual_machine.vm.*.default_ip_address
      environment_target = var.ENVIRONMENT_TARGET
    }
  )
  filename = "${path.module}/../../../_ansible/playbooks/inventory_consul_${var.ENVIRONMENT_TARGET}"

  provisioner "local-exec" {
    command = "cd ${path.module}/../../../_ansible/playbooks; ansible-playbook -i inventory_consul_${var.ENVIRONMENT_TARGET} consul.yml -e consul_datacenter_name=${var.ENVIRONMENT_TARGET} -e environment_target=${var.ENVIRONMENT_TARGET}"
  }
}