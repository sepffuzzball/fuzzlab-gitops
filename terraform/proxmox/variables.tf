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