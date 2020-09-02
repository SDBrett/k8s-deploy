# Create masters
resource "vsphere_virtual_machine" "masters" {
  enable_logging = "true"
count = var.vm-master-count
name = "${var.vm-master-name}-${count.index + 1}"
resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
datastore_id = data.vsphere_datastore.datastore.id
num_cpus = var.vm-master-cpu
memory = var.vm-master-ram
guest_id = var.vm-guest-id
network_interface {
  network_id = data.vsphere_network.network.id
}
disk {
  label = "${var.vm-master-name}-${count.index + 1}-disk"
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