Move Ansible playbook from packer build
Change so that packer only creates a base template similar to an SOE

- Decouple Packer and Terraform stages

**Tempalte Build Phase**

- Packer
 - Only create SOE like template
 - Remove K8S components from build

- Ansible
  - Install cloud init
  - Install open-vm-tools-deploypkg

**K8S Deploy Phase**

- Terraform
  - Clone VM's

- Ansible
  - First Run (All nodes)
    - Install and configure VMs for K8S
  - Master VMs
    - Install Keepalive and HAProxy
    - push kubeadm init files
  - First Master
    - kubeadm first master
  - Remaining masters
    - kubeadm join to cluster
  - Nodes
    - join cluster

