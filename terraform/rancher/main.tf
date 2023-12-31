resource "proxmox_pool" "rancher" {
    poolid = "Rancher"
    comment = "Pool for any rancher/k3s stuff"
}

resource "proxmox_lxc" "lxc-test" {
    count = 6
    
    vmid = "20${count.index+1}"
    hostname = "rancher20${count.index+1}"
    cores = 4
    memory = 8192
    swap = 0

    hastate = "started"
    ostemplate = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
    password = data.sops_file.pm-password-secret.data["password"]
    pool = proxmox_pool.rancher.poolid
    start = true
    target_node = element(var.proxmox_nodes, count.index)
    tags = "rancher"
    unprivileged = false

    network {
        name = "eth0"
        bridge = "vmbr0"
        ip = "10.0.2.20${count.index+1}/24"
        gw = "10.0.1.1"
    }
 
    rootfs {
        storage = "ceph-stor"
        size = "32G"
    }

    ssh_public_keys = data.sops_file.pm-sshkeys-secret.data["ssh"]
}
