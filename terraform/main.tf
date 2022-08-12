terraform {
  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}

variable "proxmox_api_url" {
  type      = string
  sensitive = false
}

variable "proxmox_user" {
  type      = string
  sensitive = false
}

variable "proxmox_pass" {
  type      = string
  sensitive = false
}

variable "node" {
  type      = string
  sensitive = false
}

variable "vmpw" {
  type      = string
  sensitive = false
}

variable "ssh_key" {
  type      = string
  sensitive = false
}

variable "storage" {
  type      = string
  sensitive = false
}

variable "size" {
  type      = string
  sensitive = false
}

variable "cpu_core" {
  type      = number
  sensitive = false
}

variable "memory" {
  type      = number
  sensitive = false
}

variable "master_ip" {
  type      = string
  sensitive = false
}

variable "master_id" {
  type      = string
  sensitive = false
}

variable "master_user" {
  type      = string
  sensitive = false
}

variable "node1_ip" {
  type      = string
  sensitive = false
}

variable "node1_id" {
  type      = string
  sensitive = false
}

variable "node1_user" {
  type      = string
  sensitive = false
}

variable "node2_ip" {
  type      = string
  sensitive = false
}

variable "node2_id" {
  type      = string
  sensitive = false
}

variable "node2_user" {
  type      = string
  sensitive = false
}

provider "proxmox" {
  pm_api_url  = var.proxmox_api_url
  pm_user     = var.proxmox_user
  pm_password = var.proxmox_pass

  pm_tls_insecure = true
}
