variable "proxmox_nodes" {
    type = map(any)
    description = "List of Proxmox Nodes"
}

variable "dns" {
    description = "DNS search providers"
}

variable "domain" {
    description = "Search domain"
}

variable "gateway" {
    description = "Internet gateway"
}

variable "api_url" {
    description = "Proxmox API URL"
}

variable "primary_datastore" {
    description = "Primary datastore"
}

variable "bridge" {
  description = "Network Bridge"
}

variable "ethernet" {
  description = "Network adapter"
}

variable "os" {
  description = "OS Type"
}

variable "stackspath" {
  description = "Stacks Mount Path"
}

variable "stacksvolume" {
  description = "Stacks Volume Path"
}

locals {
    ssh_keys = tomap(
        {
            for k in yamldecode(data.sops_file.pm-sshkeys-secret.raw).keys :
            k.sshkey => k
        }
    )
}

