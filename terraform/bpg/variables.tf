variable "pve_node" {}
variable "datastore_iso" {}
variable "datastore_snippets" {}
variable "datastore_vmdisk" {}
variable "initial_vmid" {}

variable "vm_username" {}
variable "vm_password" {}
variable "ssh_import_id" {}
variable "ssh_authorized_keys" {}

variable "cpu" {}
variable "memory" {}
variable "file_format" {}
variable "disk_size" {}
variable "ipv4_nwaddr" {}
variable "initial_ipv4" {}
variable "ipv4_gw" {}
variable "isoimg_url" {}

locals {
  vm_map_list = [
    {
      name = "k8s-cp",
    },
    {
      name = "k8s-wn-1",
    },
    {
      name = "k8s-wn-2",
    }
  ]
}
