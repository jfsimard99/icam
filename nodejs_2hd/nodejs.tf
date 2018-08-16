# This is a terraform generated template generated from final

## REFERENCE {"vsphere_network_reference":{"type": "vsphere_reference_network"}}

##############################################################
# Keys - CAMC (public/private) & optional User Key (public)
##############################################################
##############################################################
# Define the vsphere provider
##############################################################
##############################################################
# Define pattern variables
##############################################################
##############################################################
# Vsphere data for provider
##############################################################
data "vsphere_datacenter" "base_vm_datacenter" {
  name = "${var.base_vm_datacenter_name}"
}

data "vsphere_datastore" "base_vm_datastore" {
  name          = "${var.base_vm_datastore_name}"
  datacenter_id = "${data.vsphere_datacenter.base_vm_datacenter.id}"
}

data "vsphere_network" "network_to_base_vm" {
  name          = "${var.network_to_base_vm_network_name}"
  datacenter_id = "${data.vsphere_datacenter.base_vm_datacenter.id}"
}

data "vsphere_virtual_machine" "base_vm_template" {
  name          = "${var.base_vm_template_name}"
  datacenter_id = "${data.vsphere_datacenter.base_vm_datacenter.id}"
}

##### Image Parameters variables #####

#Variable : nodejs_vm_name
#########################################################
##### Resource : nodejs_vm
#########################################################
variable "nodejs_vm_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "nodejs_vm_root_disk_type" {
  type        = "string"
  description = "Type of template disk volume"
  default     = "eager_zeroed"
}

variable "nodejs_vm_root_disk_controller_type" {
  type        = "string"
  description = "Type of template disk controller"
  default     = "scsi"
}

variable "virtual_disk_directlvm_size" {
  type = "string"
  description = "Generated"
}

variable "virtual_disk_directlvm_vmdk_path" {
  type = "string"
  description = "Generated"
}

variable "virtual_disk_directlvm_datacenter_name" {
  type = "string"
  description = "The name of the datacenter in which to create the disk. Can be omitted when when ESXi or if there is only one datacenter in your infrastructure."
}

variable "virtual_disk_directlvm_datastore_name" {
  type = "string"
  description = "The name of the datastore in which to create the disk."
}

variable "virtual_disk_directlvm_disk_type" {
  type = "string"
  description = "The type of disk to create. Can be one of eagerZeroedThick, lazy, or thin. Default: eagerZeroedThick."
  default = "thin"
}

variable "virtual_disk_directlvm_disk_label" {
  type = "string"
  description = "Generated"
}

variable "virtual_disk_directlvm_unit_number" {
  type = "string"
  description = "The disk number on the SCSI bus. The maximum value for this setting is the value of scsi_controller_count times 15, minus 1 (so 14, 29, 44, and 59, for 1-4 controllers respectively). The default is 0, for which one disk must be set to. Duplicate unit numbers are not allowed."
}

variable "base_vm_name" {
  type = "string"
  description = "Virtual machine name for base_vm"
}

variable "base_vm_number_of_vcpu" {
  type = "string"
  description = "Number of virtual cpu's."
}

variable "base_vm_memory" {
  type = "string"
  description = "Memory allocation."
}

variable "base_vm_template_name" {
  type = "string"
  description = "Generated"
}

variable "base_vm_datacenter_name" {
  type = "string"
  description = "Generated"
}

variable "base_vm_datastore_name" {
  type = "string"
  description = "Generated"
}

variable "network_to_base_vm_network_name" {
  type = "string"
  description = "Generated"
}

variable "base_vm_connection_user" {
  type = "string"
  default = "root"
}

variable "base_vm_connection_password" {
  type = "string"
}

variable "base_vm_connection_host" {
  type = "string"
}

variable "base_vm_resource_pool" {
  type = "string"
  description = "Resource pool."
}

# vsphere vm
resource "vsphere_virtual_machine" "base_vm" {
  name          = "${var.base_vm_name}"
  datastore_id  = "${data.vsphere_datastore.base_vm_datastore.id}"
  num_cpus      = "${var.base_vm_number_of_vcpu}"
  memory        = "${var.base_vm_memory}"
  guest_id = "${data.vsphere_virtual_machine.base_vm_template.guest_id}"
  disk {
    attach = true
    label  = "${var.virtual_disk_directlvm_disk_label}"
    path   = "${vsphere_virtual_disk.virtual_disk_directlvm.vmdk_path}"
    unit_number = "${var.virtual_disk_directlvm_unit_number}"
  }
  network_interface {
    network_id = "${data.vsphere_network.network_to_base_vm.id}"
  }
  connection {
    type = "ssh"
    user = "${var.base_vm_connection_user}"
    password = "${var.base_vm_connection_password}"
    host = "${var.base_vm_connection_host}"
  }
  resource_pool_id = "${var.base_vm_resource_pool}"
  clone {
    template_uuid = "${data.vsphere_virtual_machine.base_vm_template.id}"
  }
}

resource "vsphere_virtual_disk" "virtual_disk_directlvm" {
  size          = "${var.virtual_disk_directlvm_size}"
  vmdk_path     = "${var.virtual_disk_directlvm_vmdk_path}"
  datacenter    = "${var.virtual_disk_directlvm_datacenter_name}"
  datastore     = "${var.virtual_disk_directlvm_datastore_name}"
  type          = "${var.virtual_disk_directlvm_disk_type}"
}

#########################################################
# Output
#########################################################
