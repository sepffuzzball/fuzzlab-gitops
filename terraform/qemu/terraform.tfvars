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
