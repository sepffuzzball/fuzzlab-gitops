data "sops_file" "pm-password-secret" {
  source_file = "./secrets/pm-password-secret.enc.yaml"
}

data "sops_file" "pm-sshkeys-secret" {  
  source_file = "./secrets/pm-sshkeys-secret.enc.yaml"
}