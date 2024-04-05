resource "proxmox_virtual_environment_pool" "lxc" {
    pool_id = "lxc"
    comment = "Pool for any direct lxc containers"
}

resource "proxmox_virtual_environment_download_file" "deb-pve00" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve00"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
}

resource "proxmox_virtual_environment_download_file" "deb-pve01" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve01"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
}

resource "proxmox_virtual_environment_download_file" "deb-pve02" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve02"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
}
resource "proxmox_virtual_environment_download_file" "deb-pve03" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve03"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
}
resource "proxmox_virtual_environment_download_file" "deb-pve04" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve04"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
}
resource "proxmox_virtual_environment_download_file" "deb-pve05" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve05"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"
}

resource "proxmox_virtual_environment_container" "adguard02" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve00.id
    type          = var.os
  }

  vm_id           = 2050
  node_name       = "pve00"

  description     = "Adguard Home LXC + Sync"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 32
  }

  memory {
    dedicated     = 2048
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "adguard02"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.50/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/adguard"
    volume        = "/mnt/pve/local/adguard"
    shared        = true
  }

  mount_point {
    path          = "/dockge"
    volume        = "/mnt/pve/local/dockge"
    shared        = true
  }

  network_interface {
      bridge      = "vmbr0"
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "adguard01" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve02.id
    type          = var.os
  }

  vm_id           = 2101
  node_name       = "pve02"

  description     = "Adguard Home LXC"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 32
  }

  memory {
    dedicated     = 2048
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "adguard01"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.101/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/adguard"
    volume        = "/mnt/pve/cephfs/adguard"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "ansible" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve03.id
    type          = var.os
  }

  vm_id           = 2102
  node_name       = "pve03"

  description     = "Ansible Semaphore"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 32
  }

  memory {
    dedicated     = 2048
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "ansible"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.102/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/config"
    volume        = "/mnt/pve/cephfs/ansible/config"
    shared        = true
  }

  mount_point {
    path          = "/db"
    volume        = "/mnt/pve/cephfs/ansible/db"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "swag" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve01.id
    type          = var.os
  }

  vm_id           = 2111
  node_name       = "pve01"

  description     = "Reverse Proxy"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 32
  }

  memory {
    dedicated     = 2048
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "swag"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.111/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/config"
    volume        = "/mnt/pve/cephfs/swag/config"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "nextcloud" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve03.id
    type          = var.os
  }

  vm_id           = 2104
  node_name       = "pve03"

  description     = "Nextcloud Fileserver"

  cpu {
    cores         = 8
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 128
  }

  memory {
    dedicated     = 8192
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "nextcloud"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.104/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/nextcloud"
    volume        = "/mnt/pve/cephfs/nextcloud"
    shared        = true
  }

  mount_point {
    path          = "/containers"
    volume        = "/mnt/dat/containers"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "deluge" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve02.id
    type          = var.os
  }

  vm_id           = 2105
  node_name       = "pve02"

  description     = "Deluge-VPN"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 32
  }

  memory {
    dedicated     = 4096
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "deluge"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.105/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/config"
    volume        = "/mnt/pve/cephfs/deluge/config"
    shared        = true
  }

  mount_point {
    path          = "/data"
    volume        = "/mnt/pve/cephfs/deluge/data"
    shared        = true
  }

  mount_point {
    path          = "/downloads"
    volume        = "/mnt/dat/downloads"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}


resource "proxmox_virtual_environment_container" "frigate" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve01.id
    type          = var.os
  }

  vm_id           = 2106
  node_name       = "pve01"

  description     = "Frigate Camera"

  cpu {
    cores         = 4
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 32
  }

  memory {
    dedicated     = 8192
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "frigate"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.106/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/config"
    volume        = "/mnt/pve/cephfs/frigate/config"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "samba" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve04.id
    type          = var.os
  }

  vm_id           = 2110
  node_name       = "pve04"

  description     = "Cephfs Shares"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 32
  }

  memory {
    dedicated     = 2048
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "samba"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.110/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/cephfs"
    volume        = "/mnt/pve/cephfs/"
    shared        = true
  }

  mount_point {
    path          = "/k8s-cephfs"
    volume        = "/mnt/pve/k8s-cephfs/"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "foundry" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve05.id
    type          = var.os
  }

  vm_id           = 2112
  node_name       = "pve05"

  description     = "Foundry VTT"

  cpu {
    cores         = 4
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 128
  }

  memory {
    dedicated     = 8192
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "foundry"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.112/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/config"
    volume        = "/mnt/pve/cephfs/foundry/config"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

resource "proxmox_virtual_environment_container" "macosx" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve04.id
    type          = var.os
  }

  vm_id           = 2113
  node_name       = "pve04"

  description     = "Mac OS"

  cpu {
    cores         = 4
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 128
  }

  memory {
    dedicated     = 8192
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "macosx"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.113/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/config"
    volume        = "/mnt/pve/cephfs/macosx/config"
    shared        = true
  }

  mount_point {
    path          = var.stackspath
    volume        = var.stacksvolume
    shared        = true
  }

  network_interface {
      bridge      = var.bridge
      name        = var.ethernet
  }

  pool_id = proxmox_virtual_environment_pool.lxc.pool_id
}

