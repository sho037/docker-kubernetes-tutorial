resource "proxmox_vm_qemu" "k8s-master" {
  name        = "k8s-master"
  desc        = "## k8s-master (Ubuntu 20.04 Focal Fossa)"
  vmid        = var.master_id
  target_node = var.node

  agent = 1

  clone      = "ubuntu2004-cloud-init"
  full_clone = true
  cores      = var.cpu_core
  sockets    = 1
  memory     = var.memory

  cipassword = var.vmpw

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = var.storage
    type    = "scsi"
    size    = var.size
  }

  os_type   = "cloud-init"
  ipconfig0 = var.master_ip
  ciuser    = var.master_user
  sshkeys   = var.ssh_key
}

resource "proxmox_vm_qemu" "k8s-node1" {
  name        = "k8s-node1"
  desc        = "## k8s-node1 (Ubuntu 20.04 Focal Fossa)"
  vmid        = var.node1_id
  target_node = var.node

  agent = 1

  clone      = "ubuntu2004-cloud-init"
  full_clone = true
  cores      = var.cpu_core
  sockets    = 1
  memory     = var.memory

  cipassword = var.vmpw

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = var.storage
    type    = "scsi"
    size    = var.size
  }

  os_type   = "cloud-init"
  ipconfig0 = var.node1_ip
  ciuser    = var.node1_user
  sshkeys   = var.ssh_key
}

resource "proxmox_vm_qemu" "k8s-node2" {
  name        = "k8s-node2"
  desc        = "## k8s-node2 (Ubuntu 20.04 Focal Fossa)"
  vmid        = var.node2_id
  target_node = var.node

  agent = 1

  clone      = "ubuntu2004-cloud-init"
  full_clone = true
  cores      = var.cpu_core
  sockets    = 1
  memory     = var.memory

  cipassword = var.vmpw

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = var.storage
    type    = "scsi"
    size    = var.size
  }

  os_type   = "cloud-init"
  ipconfig0 = var.node2_ip
  ciuser    = var.node2_user
  sshkeys   = var.ssh_key
}
