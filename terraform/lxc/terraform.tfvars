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
    pve05 = {
        name        = "pve05"
        desc        = ""
        ip          = "10.0.1.35/22"
    },
}

api_url             = "https://10.0.1.31:8006/"
dns                 = ["10.0.2.50", "10.0.2.10", "10.0.2.101"]
domain              = "fuzzball.enterprises"
gateway             = "10.0.1.1"
primary_datastore   = "ceph-stor"
bridge              = "vmbr1"
ethernet            = "veth0"
os                  = "debian"
stackspath          = "/dockge"
stacksvolume        = "/mnt/pve/cephfs/dockge"
