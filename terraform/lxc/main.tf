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
      bridge      = "vmbr1"
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

resource "proxmox_virtual_environment_container" "kasm" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve04.id
    type          = var.os
  }

  vm_id           = 2113
  node_name       = "pve04"

  description     = "KASM"

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
    hostname = "kasm"

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
    volume        = "/mnt/pve/cephfs/kasm/config"
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


resource "proxmox_virtual_environment_container" "notes" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve03.id
    type          = var.os
  }

  vm_id           = 2114
  node_name       = "pve03"

  description     = "Standard Notes"

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
    hostname = "notes"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.114/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/notes"
    volume        = "/mnt/pve/cephfs/notes/"
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

/* resource "proxmox_virtual_environment_container" "gitlab" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve03.id
    type          = var.os
  }

  vm_id           = 2200
  node_name       = "pve03"

  description     = "Gitlab"

  cpu {
    cores         = 8
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 256
  }

  memory {
    dedicated     = 16384
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "gitlab"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.200/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/gitlab"
    volume        = "/mnt/pve/cephfs/gitlab/"
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

resource "proxmox_virtual_environment_container" "gitlab-runner" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve02.id
    type          = var.os
  }

  vm_id           = 2199
  node_name       = "pve02"

  description     = "gitlab-runner"

  cpu {
    cores         = 4
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 128
  }

  memory {
    dedicated     = 4096
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "gitlab-runner"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.199/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/gitlab-runner"
    volume        = "/mnt/pve/cephfs/gitlab-runner/"
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
} */

resource "proxmox_virtual_environment_container" "matrix" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve03.id
    type          = var.os
  }

  vm_id           = 2175
  node_name       = "pve03"

  description     = "matrix"

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
    hostname = "matrix"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.175/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/matrix"
    volume        = "/mnt/pve/cephfs/matrix/"
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

resource "proxmox_virtual_environment_container" "dumbdrop" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve02.id
    type          = var.os
  }

  vm_id           = 2176
  node_name       = "pve02"

  description     = "dumbdrop"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 128
  }

  memory {
    dedicated     = 4096
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "dumbdrop"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.176/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/dumbdrop"
    volume        = "/mnt/pve/cephfs/dumbdrop/"
    shared        = true
  }

  mount_point {
    path          = "/files"
    volume        = "/mnt/dat/temp/"
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

resource "proxmox_virtual_environment_container" "kms" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve03.id
    type          = var.os
  }

  vm_id           = 2177
  node_name       = "pve03"

  description     = "dumbdrop"

  cpu {
    cores         = 2
  }

  disk {
    datastore_id  = var.primary_datastore
    size          = 64
  }

  memory {
    dedicated     = 2048
  }

  features {
    nesting       = true
    mount         = []
  }

  initialization {
    hostname = "kms"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.177/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/kms"
    volume        = "/mnt/pve/cephfs/kms/"
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

resource "proxmox_virtual_environment_container" "rustdesk" {
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.deb-pve00.id
    type          = var.os
  }

  vm_id           = 2051
  node_name       = "pve00"

  description     = "rustdesk"

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
    hostname = "rustdesk"

    dns {
      domain      = var.domain
      servers     = var.dns
    }

    ip_config {
      ipv4 {
        address   = "10.0.2.51/22"
        gateway   = var.gateway
      }
    }

    user_account {
        keys = keys(local.ssh_keys)
        password = data.sops_file.pm-password-secret.data["password"]
    }
  }

  mount_point {
    path          = "/rustdesk"
    volume        = "/mnt/pve/cephfs/rustdesk/"
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
