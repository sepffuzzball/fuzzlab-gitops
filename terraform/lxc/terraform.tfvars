lxcs = {
    adguard = {
        name        = "adguard"
        desc        = "Adguard Home LXC"
        vmip        = "10.0.2.101/22"
        vmid        = 1101
        node        = "pvenode04"
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
                shared = true
            },
            mount2  = {
                path = "/sync"
                volume = "/mnt/pve/cephfs/adguard/sync"
                shared = true
            },
            mount3  = {
                path = "/mnt/stacks"
                volume = "/mnt/pve/cephfs/stacks"
                shared = true
            },
        }
    },
    ansible = {
        name        = "ansible"
        desc        = "Ansible Semaphore"
        vmip        = "10.0.2.102/22"
        vmid        = 1102
        node        = "pve03"
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
                shared = true
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/ansible/db"
                shared = true
            },
            mount3  = {
                path = "/mnt/stacks"
                volume = "/mnt/pve/cephfs/stacks"
                shared = true
            },
        }
    },

    swag = {
        name        = "swag"
        desc        = "swag reverse proxy"
        vmip        = "10.0.2.111/22"
        vmid        = 111
        node        = "pve01"
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
                shared = true
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/swag/db"
                shared = true
            },
            mount3  = {
                path = "/mnt/stacks"
                volume = "/mnt/pve/cephfs/stacks"
                shared = true
            },
        }
    },
    nextcloud = {
        name        = "nextcloud"
        desc        = "nextcloud fileserver"
        vmip        = "10.0.2.104/22"
        vmid        = 1104
        node        = "pve03s"
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
                shared = true
            },
            mount2  = {
                path = "/db"
                volume = "/mnt/pve/cephfs/nextcloud/db"
                shared = true
            },
            mount3  = {
                path = "/data"
                volume = "/mnt/containers/nextclouddata"
                shared = true
            },
        }
    },
    frigate = {
        name        = "frigate"
        desc        = "frigate camera"
        vmip        = "10.0.2.106/22"
        vmid        = 1106
        node        = "pve01"
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
                shared = true
            },
            mount2  = {
                path = "/data"
                volume = "/mnt/pve/cephfs/frigate/data"
                shared = true
            },
            mount3  = {
                path = "/mnt/stacks"
                volume = "/mnt/pve/cephfs/stacks"
                shared = true
            },
        }
    },
    samba = {
        name        = "samba"
        desc        = "cephfs share"
        vmip        = "10.0.2.110/22"
        vmid        = 1110
        node        = "pve04"
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
                shared = true
            },
            mount2  = {
                path = "/k8s-cephfs"
                volume = "/mnt/pve/k8s-cephfs"
                shared = true
            },
            mount3  = {
                path = "/mnt/stacks"
                volume = "/mnt/pve/cephfs/stacks"
                shared = true
            },
        }
    },
    foundry = {
        name        = "foundry"
        desc        = "foundryvtt"
        vmip        = "10.0.2.112/22"
        vmid        = 1112
        node        = "pve05"
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
                shared = true
            },
            mount2  = {
                path = "/logs"
                volume = "/mnt/pve/cephfs/foundrydelvers/Logs"
                shared = true
            },
            mount3  = {
                path = "/mnt/stacks"
                volume = "/mnt/pve/cephfs/stacks"
                shared = true
            },
        }
    },
    macosx = {
        name        = "macosx"
        desc        = "macosx"
        vmip        = "10.0.2.113/22"
        vmid        = 113
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
                volume = "/mnt/pve/cephfs/macosx/Config"
            },
            mount2  = {
                path = "/logs"
                volume = "/mnt/pve/cephfs/macosx/Logs"
            },
            mount3  = {
                path = "/data"
                volume = "/mnt/pve/cephfs/macosx/Data"
            },
        }
    }
}

proxmox_nodes = {
    pve01 = {
        name        = "pve01"
        desc        = ""
        ip          = "10.0.1.31/22"
    },
    pve02 = {
        name        = "pve02"
        desc        = ""
        ip          = "10.0.1.32/22"
    },
    pve03 = {
        name        = "pve03"
        desc        = ""
        ip          = "10.0.1.33/22"
    },
    pve04 = {
        name        = "pve04"
        desc        = ""
        ip          = "10.0.1.34/22"
    },
    pve03 = {
        name        = "pve03"
        desc        = ""
        ip          = "10.0.1.34/22"
    },
}

api_url             = "https://10.0.1.31:8006/"
dns                 = ["10.0.2.50", "10.0.2.10", "10.0.2.101"]
domain              = "fuzzball.enterprises"
gateway             = "10.0.1.1"
