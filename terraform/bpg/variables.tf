variable "pve_node" {}
variable "datastore_iso" {}
variable "datastore_snippets" {}
variable "datastore_vmdisk" {}
variable "initial_vmid" {}

variable "cpu" {}
variable "memory" {}
variable "file_format" {}
variable "disk_size" {}
variable "isoimg_url" {}

locals {
  vm_map_list = [
    {
      name    = "k8s-cp",
      vm_id   = "1000",
      ipv4    = "192.168.0.1/24",
      ipv4_gw = "192.168.0.254",
    },
    {
      name    = "k8s-wn-1",
      vm_id   = "1001",
      ipv4    = "192.168.0.2/24",
      ipv4_gw = "192.168.0.254",
    },
    {
      name    = "k8s-wn-2",
      vm_id   = "1002",
      ipv4    = "192.168.0.3/24",
      ipv4_gw = "192.168.0.254",
    }
  ]
}
