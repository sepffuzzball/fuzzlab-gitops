resource "proxmox_virtual_environment_pool" "qemu" {
    pool_id = "qemu"
    comment = "Pool for any direct qemu containers"
}


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
    type          = "debian"
  }

  pool_id = proxmox_virtual_environment_pool.qemu.pool_id
}

resource "proxmox_virtual_environment_download_file" "TrueNAS" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pvenode00"
  url          = "https://download.sys.truenas.net/TrueNAS-SCALE-Cobia/23.10.1.3/TrueNAS-SCALE-23.10.1.3.iso"
}
