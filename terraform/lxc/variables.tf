variable "proxmox_nodes" {
    type = map(any)
    description = "List of Proxmox Nodes"
}

variable "lxcs" {
    type = map(any)
    description = "List of LXC containers to create"
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

locals {
    ssh_keys = tomap(
        {
            for k in yamldecode(data.sops_file.pm-sshkeys-secret.raw).keys :
            k.sshkey => k
        }
    )    
}

