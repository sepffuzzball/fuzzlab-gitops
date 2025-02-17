proxmox_nodes = {
    pvenode01 = {
        name        = "pvenode01"
        desc        = ""
        ip          = "10.0.1.31/22"
    },
    pvenode02 = {
        name        = "pvenode02"
        desc        = ""
        ip          = "10.0.1.32/22"
    },
    pvenode03 = {
        name        = "pvenode03"
        desc        = ""
        ip          = "10.0.1.33/22"
    },
    pvenode04 = {
        name        = "pvenode04"
        desc        = ""
        ip          = "10.0.1.34/22"
    },
    pvenode05 = {
        name        = "pvenode05"
        desc        = ""
        ip          = "10.0.1.35/22"
    },
}

api_url             = "https://10.0.1.31:8006/"
dns                 = ["10.0.2.10", "10.0.2.50", "10.0.2.101"]
domain              = "fuzzball.enterprises"
gateway             = "10.0.1.1"
