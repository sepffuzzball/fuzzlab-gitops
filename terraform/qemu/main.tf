resource "proxmox_virtual_environment_pool" "qemu" {
    pool_id = "qemu"
    comment = "Pool for any direct qemu containers"
}

/*
resource "proxmox_virtual_environment_vm" "dat" {

  vm_id           = 1020
  node_name       = "dat"
  description     = "TrueNAS Scale Primary NAS"
  tags            = ["qemu", "nas"]

  agent {
    enabled = true
  }

  startup {
    order = "1"
  }

  bios            = "ovmf"

  efi_disk {
    datastore_id  = "local-lvm"
  }

  cpu {
    cores         = 8
  }

  disk {
    datastore_id  = "local-lvm"
    discard       = true
    interface     = "scsi0"
    size          = 32
    ssd           = true
  }

  memory {
    dedicated     = 98304
  }

  hostpci {
    device        = "hostpci0"
    id            = ""
    pcie          = true
  }


  network_device {
      bridge      = "vmbr0"
  }

  operating_system {
    type          = "l26"
  }

  pool_id = proxmox_virtual_environment_pool.qemu.pool_id
}

resource "proxmox_virtual_environment_download_file" "TrueNAS" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pvenode00"
  url          = "https://download.sys.truenas.net/TrueNAS-SCALE-Cobia/23.10.1.3/TrueNAS-SCALE-23.10.1.3.iso"
}
*/
resource "proxmox_virtual_environment_vm" "forge" {

    vm_id           = 2035
    node_name  = "pve01"
    name       = "forge"
    description     = "Git Forge and Postgres AIO"
    tags            = ["qemu", "git"]

    clone {
        datastore_id = "ceph-stor"
        node_name = "pve01"
        retries = 5
        vm_id = 2000
        full = true
    }

    cpu {
      cores = 2
      type = "x86-64-v2-AES"
    }

    memory {
      dedicated = 4096
    }

    agent {
        enabled = true
    }

    startup {
        order       = 10
        up_delay    = "60"
        down_delay  = "60"
    }

    disk {
        size        = 128
        datastore_id= "ceph-stor"
        interface   = "scsi0"
        discard = "on"
        ssd = true
    }

    initialization {

      datastore_id = "local-zfs"

      dns {
        servers = var.dns
        domain = var.domain
      }

      ip_config {
        ipv4 {
          address = "10.0.2.35/22"
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
      bridge = "vmbr1"
    }

    serial_device {}

    pool_id = proxmox_virtual_environment_pool.qemu.pool_id

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

resource "proxmox_virtual_environment_vm" "forge-runner" {

    vm_id           = 2031
    node_name  = "pve03"
    name       = "forge-runner"
    description     = "Git Forge and Postgres AIO"
    tags            = ["qemu", "git"]

    clone {
        datastore_id = "ceph-stor"
        node_name = "pve01"
        retries = 5
        vm_id = 2000
        full = true
    }

    cpu {
      cores = 2
      type = "x86-64-v2-AES"
    }

    memory {
      dedicated = 4096
    }

    agent {
        enabled = true
    }

    startup {
        order       = 15
        up_delay    = "60"
        down_delay  = "60"
    }

    disk {
        size        = 128
        datastore_id= "ceph-stor"
        interface   = "scsi0"
        discard = "on"
        ssd = true
    }

    initialization {

      datastore_id = "local-zfs"

      dns {
        servers = var.dns
        domain = var.domain
      }

      ip_config {
        ipv4 {
          address = "10.0.2.31/22"
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
      bridge = "vmbr1"
    }

    serial_device {}

    pool_id = proxmox_virtual_environment_pool.qemu.pool_id

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

resource "proxmox_virtual_environment_vm" "eva-01v" {

    vm_id           = 2033
    node_name  = "pve01"
    name       = "eva-01v"
    description     = "Windows 11 for Sepfy"
    tags            = ["qemu", "windows"]
    acpi = true
    bios = "ovmf"
    scsi_hardware = "virtio-scsi-pci"

    efi_disk {
      datastore_id = "local-zfs"
      type = "4m"
      pre_enrolled_keys = true
    }

    tpm_state {
      datastore_id = "local-zfs"
      version = "v2.0"
    }

    cpu {
      cores = 4
      type = "host"
    }

    memory {
      dedicated = 16384
    }

    agent {
        enabled = true
    }

    startup {
        order       = 20
        up_delay    = "60"
        down_delay  = "60"
    }

    disk {
        size        = 256
        datastore_id= "local-zfs"
        interface   = "scsi0"
        cache = "none"
        replicate = true
        discard = "on"
        ssd = true
    }

    initialization {

      datastore_id = "local-zfs"

      dns {
        servers = var.dns
        domain = var.domain
      }

      ip_config {
        ipv4 {
          address = "10.0.2.33/22"
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
      bridge = "vmbr1"
    }

    serial_device {}

    pool_id = proxmox_virtual_environment_pool.qemu.pool_id

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
