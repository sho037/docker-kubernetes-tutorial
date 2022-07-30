resource "proxmox_vm_qemu" "k8s-master" {
  name        = "k8s-master"
  desc        = "k8s-master (Ubuntu 20.04 Focal Fossa)"
  vmid        = "1000"
  target_node = "pve1"

  agent = 1

  clone      = "ubuntu2004-cloud-init"
  full_clone = true
  cores      = 2
  sockets    = 1
  # cpu        = "kvm64"
  memory = 2048

  cipassword = var.master_pass

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local"
    type    = "scsi"
    size    = "20G"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=192.168.0.10/24,gw=192.168.0.1"
  # nameserver = "0.0.0.0"
  ciuser  = "k8s"
  sshkeys = var.ssh_key
}

resource "proxmox_vm_qemu" "k8s-node1" {
  name        = "k8s-node1"
  desc        = "k8s-node1 (Ubuntu 20.04 Focal Fossa)"
  vmid        = "1001"
  target_node = "pve1"

  agent = 1

  clone      = "ubuntu2004-cloud-init"
  full_clone = true
  cores      = 2
  sockets    = 1
  # cpu        = "kvm64"
  memory = 2048

  cipassword = var.node1_pass

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local"
    type    = "scsi"
    size    = "20G"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=192.168.0.11/24,gw=192.168.0.1"
  # nameserver = "0.0.0.0"
  ciuser  = "k8s"
  sshkeys = var.ssh_key
}

resource "proxmox_vm_qemu" "k8s-node2" {
  name        = "k8s-node2"
  desc        = "k8s-node2 (Ubuntu 20.04 Focal Fossa)"
  vmid        = "1002"
  target_node = "pve1"

  agent = 1

  clone      = "ubuntu2004-cloud-init"
  full_clone = true
  cores      = 2
  sockets    = 1
  # cpu        = "kvm64"
  memory = 2048

  cipassword = var.node2_pass

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local"
    type    = "scsi"
    size    = "20G"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=192.168.0.12/24,gw=192.168.0.1"
  # nameserver = "0.0.0.0"
  ciuser  = "k8s"
  sshkeys = var.ssh_key
}
