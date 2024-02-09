terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.46.3"
    }
    sops = {
      source = "carlpett/sops"
      version = "~> 1.0"
    }
  }
}

provider "sops" {}

provider "proxmox" {
  endpoint = var.api_url
  insecure = true
  username = "root@pam"
  password = data.sops_file.pm-password-secret.data["password"]
  tmp_dir = "/var/tmp"
  ssh {
    username  = "rancher"
    password  = data.sops_file.pm-password-secret.data["password"]
  }
}