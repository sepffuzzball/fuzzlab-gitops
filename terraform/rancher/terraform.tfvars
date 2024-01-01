vms = {
    k3s201 = {
        name        = "k3s201"
        desc        = ""
        vmip        = "10.0.2.201/22"
        vmid        = 201
        node        = "pvenode01"
        order       = 1
    },
    k3s202 = {
        name        = "k3s202"
        desc        = ""
        vmip        = "10.0.2.202/22"
        vmid        = 202
        node        = "pvenode01"
        order       = 11
    },
    k3s203 = {
        name        = "k3s203"
        desc        = ""
        vmip        = "10.0.2.203/22"
        vmid        = 203
        node        = "pvenode02"
        order       = 2
    },
    k3s204 = {
        name        = "k3s204"
        desc        = ""
        vmip        = "10.0.2.204/22"
        vmid        = 204
        node        = "pvenode02"
        order       = 12
    },
    k3s205 = {
        name        = "k3s205"
        desc        = ""
        vmip        = "10.0.2.205/22"
        vmid        = 205
        node        = "pvenode02"
        order       = 3
    },
    k3s206 = {
        name        = "k3s206"
        desc        = ""
        vmip        = "10.0.2.206/22"
        vmid        = 206
        node        = "pvenode02"
        order       = 13
    },
}

dns                 = ["10.0.2.50", "10.0.2.10"]
domain              = "fzbl.xyz"
gateway             = "10.0.1.1"