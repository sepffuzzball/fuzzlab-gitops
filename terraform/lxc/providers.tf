terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.43.1"
    }
    sops = {
      source = "carlpett/sops"
      version = "~> 1.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
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

provider "docker" {
  host = "unix:///var/run/docker.sock"
}