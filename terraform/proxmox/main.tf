resource "proxmox_virtual_environment_dns" "pvecluster" {
    for_each        = var.proxmox_nodes

    node_name       = each.value.name

    domain          = var.domain
    servers         = var.dns

}