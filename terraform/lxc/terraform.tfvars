lxcs = {
    adguard = {
        name        = "adguard"
        desc        = "Adguard Home LXC"
        vmip        = "10.0.2.101/22"
        vmid        = 101
        node        = "pvenode01"
        order       = 5
        cpus        = 2
        disk        = 32
        ram         = 2048
        mount       = []
        nesting     = true
        mounts      = {
            mount1  = {
                path = "/config"
                volume = "/mnt/pve/cephfs/adguard/config"
            },
            mount2  = {
                path = "/sync"
                volume = "/mnt/pve/cephfs/adguard/sync"
            },
            mount3  = {
                path = "/null"
                volume = "/mnt/pve/cephfs/adguard/null"
            },
        }
    },
    ansible = {
        name        = "ansible"
        desc        = "Ansible Semaphore"
        vmip        = "10.0.2.102/22"
        vmid        = 102
        node        = "pvenode01"
        order       = 5
        cpus        = 2
        disk        = 32
        ram         = 2048
        mount       = []
        nesting     = true
        mounts      = {
            mount1  = {
                path = "/config"
                volume = "/mnt/pve/cephfs/ansible/config"
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/ansible/db"
            },
            mount3  = {
                path = "/null"
                volume = "/mnt/pve/cephfs/ansible/null"
            },
        }
    },
    palworld01 = {
        name        = "palworld01"
        desc        = "Palworld dedicated server"
        vmip        = "10.0.2.103/22"
        vmid        = 103
        node        = "pvenode02"
        order       = 5
        cpus        = 6
        disk        = 32
        ram         = 32768
        nesting     = false
        mount       = []
        mounts      = {
            mount1  = {
                path = "/home/steam"
                volume = "/mnt/pve/cephfs/palworld/config"
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/palworld/db"
            },
            mount3  = {
                path = "/null"
                volume = "/mnt/pve/cephfs/palworld/null"
            },
        }
    },
    swag = {
        name        = "swag"
        desc        = "swag reverse proxy"
        vmip        = "10.0.2.111/22"
        vmid        = 111
        node        = "pvenode01"
        order       = 4
        cpus        = 2
        disk        = 32
        ram         = 4096
        nesting     = true
        mount       = ["cifs"]
        mounts      = {
            mount1  = {
                path = "/config"
                volume = "/mnt/pve/cephfs/swag/config"
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/swag/db"
            },
            mount3  = {
                path = "/null"
                volume = "/mnt/pve/cephfs/swag/null"
            },
        }
    },
    nextcloud = {
        name        = "nextcloud"
        desc        = "nextcloud fileserver"
        vmip        = "10.0.2.104/22"
        vmid        = 104
        node        = "pvenode02"
        order       = 4
        cpus        = 2
        disk        = 32
        ram         = 4096
        nesting     = true
        mount       = ["cifs"]
        mounts      = {
            mount1  = {
                path = "/config"
                volume = "/mnt/pve/cephfs/nextcloud/config"
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/nextcloud/db"
            },
            mount3  = {
                path = "/data"
                volume = "/mnt/containerdata/nextclouddata"
            },
        }
    },
    owncloud = {
        name        = "owncloud"
        desc        = "owncloud fileserver"
        vmip        = "10.0.2.105/22"
        vmid        = 105
        node        = "pvenode01"
        order       = 4
        cpus        = 4
        disk        = 32
        ram         = 8192
        nesting     = true
        mount       = ["cifs"]
        mounts      = {
            mount1  = {
                path = "/config"
                volume = "/mnt/pve/cephfs/owncloud/config"
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/owncloud/db"
            },
            mount3  = {
                path = "/data"
                volume = "/mnt/containerdata/owncloud/data"
            },
        }
    },
    frigate = {
        name        = "frigate"
        desc        = "frigate camera"
        vmip        = "10.0.2.106/22"
        vmid        = 106
        node        = "pvenode03"
        order       = 4
        cpus        = 4
        disk        = 32
        ram         = 8192
        nesting     = true
        mount       = ["cifs"]
        mounts      = {
            mount1  = {
                path = "/config"
                volume = "/mnt/pve/cephfs/frigate/config"
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/frigate/db"
            },
            mount3  = {
                path = "/data"
                volume = "/mnt/pve/cephfs/frigate/data"
            },
        }
    },
    samba = {
        name        = "samba"
        desc        = "cephfs share"
        vmip        = "10.0.2.110/22"
        vmid        = 110
        node        = "pvenode03"
        order       = 4
        cpus        = 2
        disk        = 32
        ram         = 4096
        nesting     = true
        mount       = ["cifs"]
        mounts      = {
            mount1  = {
                path = "/cephfs"
                volume = "/mnt/pve/cephfs"
            },
            mount2  = {
                path = "/k8s-cephfs"
                volume = "/mnt/pve/k8s-cephfs"
            },
            mount3  = {
                path = "/null"
                volume = "/mnt/pve/null"
            },
        }
    },
    foundry = {
        name        = "foundry"
        desc        = "foundryvtt"
        vmip        = "10.0.2.112/22"
        vmid        = 112
        node        = "pvenode03"
        order       = 4
        cpus        = 4
        disk        = 64
        ram         = 8192
        nesting     = true
        mount       = ["cifs"]
        mounts      = {
            mount1  = {
                path = "/config"
                volume = "/mnt/pve/cephfs/foundrydelvers/Config"
            },
            mount2  = {
                path = "/logs"
                volume = "/mnt/pve/cephfs/foundrydelvers/Logs"
            },
            mount3  = {
                path = "/data"
                volume = "/mnt/pve/cephfs/foundrydelvers/Data"
            },
        }
    }
}

proxmox_nodes = {
    pvenode01 = {
        name        = "pvenode01"
        desc        = ""
        ip          = "10.0.2.31/22"
    },
    pvenode02 = {
        name        = "pvenode02"
        desc        = ""
        ip          = "10.0.2.32/22"
    },
    pvenode03 = {
        name        = "pvenode03"
        desc        = ""
        ip          = "10.0.2.33/22"
    },
}

api_url             = "https://10.0.2.31:8006/"
dns                 = ["10.0.2.50", "10.0.2.10"]
domain              = "fzbl.xyz"
gateway             = "10.0.1.1"
