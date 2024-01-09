resource "proxmox_virtual_environment_pool" "lxc" {
    pool_id = "lxc"
    comment = "Pool for any direct lxc containers"
}


resource "proxmox_virtual_environment_container" "name" {
  for_each        = var.lxcs
  
  vm_id           = each.value.vmid
  node_name       = each.value.node
  
  description     = each.value.desc

  cpu {
    cores         = each.value.cpus
  }

  disk {
    datastore_id  = "ceph-stor"
    size          = each.value.disk
  }

  memory {
    dedicated     = each.value.ram
  }

  initialization {
    hostname = each.value.name
    
    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = each.value.vmip
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }  

  mount_point {
    path          = each.value.mounts.mount1.path
    volume        = each.value.mounts.mount1.volume
  }

  mount_point {
    path          = each.value.mounts.mount2.path
    volume        = each.value.mounts.mount2.volume
  }

 

  network_interface {
      bridge      = "vmbr0"
      name        = "veth0"
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.debian.id
    type          = "debian"
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_download_file" "debian" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pvenode01"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
}
