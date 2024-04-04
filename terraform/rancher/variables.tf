variable "proxmox_nodes" {
    type = list(string)
    default = ["pve01", "pve02", "pve03", "pve04", "pve05"]
}

variable "vms" {
    type = map(any)
    description = "List of virtual machines to be deployed"
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

locals {
    ssh_keys = tomap(
        {
            for k in yamldecode(data.sops_file.pm-sshkeys-secret.raw).keys :
            k.sshkey => k
        }
    )


}

