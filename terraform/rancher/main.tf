resource "proxmox_virtual_environment_pool" "rancher" {
    pool_id = "Rancher"
    comment = "Pool for any rancher/k3s stuff"
}

resource "proxmox_virtual_environment_vm" "k3scluster" {
    for_each        = var.vms

    vm_id           = each.value.vmid
    name            = each.value.name
    node_name       = each.value.node
    description     = each.value.desc
    
    clone {
        datastore_id = "ceph-stor"
        node_name = "pvenode01"
        retries = 5
        vm_id = 2000
        full = true
    }

    cpu {
      cores = 4
      type = "x86-64-v2-AES"
    }

    memory {
      dedicated = 8192
    }

    agent {
        enabled = true
    }
    
    startup {
        order       = each.value.order
        up_delay    = "60"
        down_delay  = "60"
    }
    
    disk {
        size        = 32 
        datastore_id= "ceph-stor"
        interface   = "scsi0"
        discard = "on"
        ssd = true
    }

    initialization {
      
      dns {
        servers = var.dns
        domain = var.domain
      }
      
      ip_config {
        ipv4 {
          address = each.value.vmip
          gateway = var.gateway
        }
      }

      user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
        username = "rancher"
      }
    }

    network_device {
      bridge = "vmbr0"
    }

    serial_device {}

    pool_id = proxmox_virtual_environment_pool.rancher.id

    /*
    usb {
        host        = ""
    }
    */
    
    connection {
        type     = "ssh"
        user     = "rancher"
        password = data.sops_file.pm-password-secret.data["password"]
        host     = "deb"
    }

    provisioner "remote-exec" {
        inline = [
        "ip a"
        ]
    }

    /*
    provisioner "local-exec" {
        command = ""
    }
    */
}








/* -- Sepfy - I'm tired of fighting LXCs for K3s
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
*/