provider "vsphere" {
user = var.vcenter_username
password = var.vcenter_password
vsphere_server = var.vcenter_server
# If you have a self-signed cert
allow_unverified_ssl = var.vsphere-unverified-ssl
}
# Define VMware vSphere
data "vsphere_datacenter" "dc" {
name = var.vcenter_datacenter
}
data "vsphere_datastore" "datastore" {
name = var.vcenter_datastore
datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_compute_cluster" "cluster" {
name = var.vcenter_cluster
datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
name = var.vm-network
datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
name = "/${var.vcenter_datacenter}/vm/${var.template_folder}/${var.template_name}"
datacenter_id = data.vsphere_datacenter.dc.id
}