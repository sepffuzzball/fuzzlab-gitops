terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.43.1"
    }
    #proxmox = {
    #  source = "MaartendeKruijf/proxmox"
    #  version = "0.0.1"
    #}
    sops = {
      source = "carlpett/sops"
      version = "~> 1.0"
    }
  }
}

provider "sops" {}

provider "proxmox" {
  endpoint = "https://10.0.2.31:8006/"
  insecure = true
  username = "root@pam"
  password = data.sops_file.pm-password-secret.data["password"]
  tmp_dir = "/var/tmp"
  ssh {
    username  = "rancher"
    password  = data.sops_file.pm-password-secret.data["password"]
  }
}

/* Used for old Telmate / MaartenKruijf providers
provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = "https://10.0.2.31:8006/api2/json"
  pm_password = data.sops_file.pm-password-secret.data["password"]
  pm_user = "root@pam"
}
*/