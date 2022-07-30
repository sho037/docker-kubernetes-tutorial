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
  type = string
}

variable "proxmox_user" {
  type      = string
  sensitive = true
}

variable "proxmox_pass" {
  type      = string
  sensitive = true
}

variable "master_pass" {
  type      = string
  sensitive = true
}

variable "node1_pass" {
  type      = string
  sensitive = true
}

variable "node2_pass" {
  type      = string
  sensitive = true
}

variable "ssh_key" {
  type      = string
  sensitive = true
}

provider "proxmox" {
  pm_api_url  = var.proxmox_api_url
  pm_user     = var.proxmox_user
  pm_password = var.proxmox_pass

  pm_tls_insecure = true
}
