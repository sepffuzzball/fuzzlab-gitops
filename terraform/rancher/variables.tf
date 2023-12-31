variable "proxmox_nodes" {
    type = list(string)
    default = ["pvenode01", "pvenode02", "pvenode03"]
}