vms = {
    k3s201 = {
        name        = "k3s201"
        desc        = ""
        vmip        = "10.0.2.201/22"
        vmid        = 2201
        node        = "pve01"
        order       = 1
    },
    k3s202 = {
        name        = "k3s202"
        desc        = ""
        vmip        = "10.0.2.202/22"
        vmid        = 2202
        node        = "pve01"
        order       = 11
    },
    k3s203 = {
        name        = "k3s203"
        desc        = ""
        vmip        = "10.0.2.203/22"
        vmid        = 2203
        node        = "pve02"
        order       = 2
    },
    k3s204 = {
        name        = "k3s204"
        desc        = ""
        vmip        = "10.0.2.204/22"
        vmid        = 2204
        node        = "pve02"
        order       = 12
    },
    k3s205 = {
        name        = "k3s205"
        desc        = ""
        vmip        = "10.0.2.205/22"
        vmid        = 2205
        node        = "pve03"
        order       = 3
    },
    k3s206 = {
        name        = "k3s206"
        desc        = ""
        vmip        = "10.0.2.206/22"
        vmid        = 2206
        node        = "pve03"
        order       = 13
    },
    k3s207 = {
        name        = "k3s207"
        desc        = ""
        vmip        = "10.0.2.207/22"
        vmid        = 2207
        node        = "pve04"
        order       = 4
    },
    k3s208 = {
        name        = "k3s208"
        desc        = ""
        vmip        = "10.0.2.208/22"
        vmid        = 2208
        node        = "pve04"
        order       = 14
    },
    k3s209 = {
        name        = "k3s209"
        desc        = ""
        vmip        = "10.0.2.209/22"
        vmid        = 2209
        node        = "pve05"
        order       = 5
    },
    k3s210 = {
        name        = "k3s210"
        desc        = ""
        vmip        = "10.0.2.210/22"
        vmid        = 2210
        node        = "pve05"
        order       = 5
    },
}

dns                 = ["10.0.2.50", "10.0.2.10", "10.0.2.101"]
domain              = "fuzzball.enterprises"
gateway             = "10.0.1.1"
