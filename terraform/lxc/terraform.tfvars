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
                path = ""
                volume = ""
            },
        }
    },
    ansible = {
        name        = "ansible"
        desc        = "Ansible Semaphore"
        vmip        = "10.0.2.102/22"
        vmid        = 102
        node        = "pvenode02"
        order       = 5
        cpus        = 2
        disk        = 32
        ram         = 2048
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
                path = ""
                volume = ""
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