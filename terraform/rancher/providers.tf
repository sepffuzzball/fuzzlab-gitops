terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
    sops = {
      source = "carlpett/sops"
      version = "~> 0.5"
    }
  }
}

provider "sops" {}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = "https://10.0.2.31:8006/api2/json"
  pm_password = data.sops_file.pm-password-secret.data["password"]
  pm_user = "root@pam"
}