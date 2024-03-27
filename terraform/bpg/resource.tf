resource "proxmox_virtual_environment_download_file" "latest_ubuntu2204_qcow2_img" {
  node_name    = var.pve_node
  datastore_id = var.datastore_iso
  content_type = "iso"
  url          = var.isoimg_url
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  for_each = { for vm in local.vm_map_list : vm.name => vm }

  node_name    = var.pve_node
  datastore_id = var.datastore_snippets
  content_type = "snippets"

  source_raw {
    data = <<EOF
#cloud-config
users:
  - name: ${var.vm_username}
    passwd: ${bcrypt(var.vm_password)}
    lock_passwd: false
    groups:
      - sudo
    ssh_import_id:
      - ${var.ssh_import_id}
    ssh_authorized_keys:
      - ${var.ssh_authorized_keys}
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
hostname: ${each.value.name}
timezone: Asia/Tokyo
packages:
  - qemu-guest-agent
  - net-tools
  - traceroute
package_upgrade: true
ssh_pwauth: true
power_state:
  mode: reboot
write_files:
  - path: /etc/netplan/90-config.yaml
    content: |
      network:
        ethernets:
          eth0:
            optional: true
    permissions: "0600"
EOF

    file_name = "cloud-config-${each.value.name}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = { for vm in local.vm_map_list : vm.name => vm }

  name        = each.value.name
  description = "# ${each.value.name}"
  tags        = ["k8s"]

  node_name = var.pve_node
  vm_id     = format("%d", var.initial_vmid + index(local.vm_map_list, each.value))

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
    file_id      = proxmox_virtual_environment_download_file.latest_ubuntu2204_qcow2_img.id
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
        address = "${cidrhost(var.ipv4_nwaddr, index(local.vm_map_list, each.value) + var.initial_ipv4)}/24"
        gateway = var.ipv4_gw
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config[each.key].id
  }

  serial_device {}
}
