# terraform_vsphere_bug
If the depends_on block is removed from the consul module, the apply works without error but the resources are built in parallel.  I wish to have the bind server built fully first, then the consul nodes.  I tried various ways of linking these together without using a depends_on block but nothing has worked.  I exported vars from the bind module, and ref'd them in the consul module, still they would build in parallel.  Only when I added depends_on does this seem to want to work... but I am getting this error about an invalid reference to the template I'm cloning's disk size.

In the first run, in the consul module, I have a disc block defined as
```aidl
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
```
This builds the bind server without issue but when it begins to build the consul instances, it throws the error
```aidl
Error: disk.0: size for disk "disk0": required option not set
  with module.consul.vsphere_virtual_machine.vm[2],
  on ../../../../../modules/vsphere_consul/main.tf line 69, in resource "vsphere_virtual_machine" "vm":
  resource "vsphere_virtual_machine" "vm" ****
```
As can be found in the logs/first_run/disc_0_size_issue.txt


As another test, I then hardcoded the disk size to be that of the template and once I do that, the bind server build succeeds, but then throws yet another error indicating it's a bug in the vsphere provider that should be addressed by the provider developer.

Second run consul module disc block:
```aidl
  disk {
    label            = "disk0"
    size             = 20
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
```

Resulting error:
```aidl
Error: Provider produced inconsistent final plan

When expanding the plan for module.consul.vsphere_virtual_machine.vm[2] to
include new values learned so far during apply, provider
"registry.terraform.io/hashicorp/vsphere" produced an invalid new value for
disk[0].thin_provisioned: was cty.False, but now cty.True.

This is a bug in the provider, which should be reported in the provider's
own issue tracker.
```
