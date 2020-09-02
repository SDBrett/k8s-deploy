variable "vcenter_username" {
type = string
description = "VMware vSphere user name"
}
variable "vcenter_password" {
type = string
description = "VMware vSphere password"
}
variable "vcenter_server" {
type = string
description = "VMWare vCenter server FQDN / IP"
}
variable "vsphere-unverified-ssl" {
type = string
description = "Is the VMware vCenter using a self signed certificate (true/false)"
}
variable "vcenter_datacenter" {
type = string
description = "VMWare vSphere datacenter"
default = "Datacenter"
}
variable "vcenter_cluster" {
type = string
description = "VMWare vSphere cluster"
default = "Cluster"
}
variable "template_folder" {
type = string
description = "Template folder"
default = "Templates"
}


variable "vm-node-count" {
type = string
description = "Number of nodes"
}
variable "vm-master-count" {
type = string
description = "Number of masters"
}
variable "vcenter_datastore" {
type = string
description = "Datastore used for the vSphere virtual machines"
}
variable "vm-network" {
type = string
description = "Network used for the vSphere virtual machines"
}
variable "vm-linked-clone" {
type = string
description = "Use linked clone to create the vSphere virtual machine from the template (true/false). If you would like to use the linked clone feature, your template need to have one and only one snapshot"
default = "false"
}
variable "vm-node-cpu" {
type = string
description = "Number of vCPU for each node"
}
variable "vm-node-ram" {
type = string
description = "Amount of RAM for each node"
}
variable "vm-node-name" {
type = string
description = "Node hostname prefix"
}
variable "vm-master-cpu" {
type = string
description = "Number of vCPU for each master"
}
variable "vm-master-ram" {
type = string
description = "Amount of RAM for each master"
}
variable "vm-master-name" {
type = string
description = "master hostname prefix"
}
variable "vm-guest-id" {
type = string
description = "The ID of virtual machines operating system"
}
variable "vm_template_name" {
type = string
description = "The template to clone to create the VM"
}
variable "vm-domain" {
type = string
description = "Linux virtual machine domain name for the machine. This, along with host_name, make up the FQDN of the virtual machine"
}