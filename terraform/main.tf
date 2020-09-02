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
name = "/${var.vcenter_datacenter}/vm/${var.template_folder}/${var.vm_template_name}"
datacenter_id = data.vsphere_datacenter.dc.id
}


# Create VMs
resource "vsphere_virtual_machine" "vm" {
  enable_logging = "true"
count = var.vm-count
name = "${var.vm-name}-${count.index + 1}"
resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
datastore_id = data.vsphere_datastore.datastore.id
num_cpus = var.vm-cpu
memory = var.vm-ram
guest_id = var.vm-guest-id
network_interface {
  network_id = data.vsphere_network.network.id
}
disk {
  label = "${var.vm-name}-${count.index + 1}-disk"
  size  = 32
}
scsi_type = "pvscsi"
clone {
  template_uuid = data.vsphere_virtual_machine.template.id
  customize {
    timeout = 120
    
    linux_options {
      host_name = "node-${count.index + 1}"
      domain = var.vm-domain
    }
    
    network_interface {}
  }
 }
}