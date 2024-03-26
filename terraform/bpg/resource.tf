resource "proxmox_virtual_environment_download_file" "latest_ubuntu2204_qcow2_img" {
  node_name    = var.pve_node
  datastore_id = var.datastore_iso
  content_type = "iso"
  url          = var.isoimg_url
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  node_name    = var.pve_node
  datastore_id = var.datastore_snippets
  content_type = "snippets"

  source_raw {
    data = <<EOF
#cloud-config
timezone: Asia/Tokyo
packages:
  - qemu-guest-agent
  - net-tools
  - traceroute
package_update: true
package_upgrade: true
package_reboot_if_required: true
EOF

    file_name = "cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = { for vm in local.vm_map_list : vm.name => vm }

  name        = each.value.name
  description = "## ${each.value.name}"
  tags        = ["k8s"]

  node_name = var.pve_node
  vm_id     = format("%d", var.initial_vmid + count.index)

  agent {
    enabled = true
  }

  cpu {
    cores = var.cpu
    # type = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = var.datastore_vmdisk
    file_format  = var.file_format
    file_id      = proxmox_virtual_environment_file.latest_ubuntu2204_qcow2_img.id
    interface    = "scsi0"
    size         = var.disk_size
  }

  operating_system {
    type = "l26"
  }

  on_boot = true

  initialization {
    ip_config {
      ipv4 {
        address = each.value.ipv4
        gateway = each.value.ipv4_gw
      }
    }

    user_account {
      username = var.vm_username
      password = var.vm_password
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  serial_device {}
}
