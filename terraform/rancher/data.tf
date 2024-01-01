data "sops_file" "pm-password-secret" {
  source_file = "./secrets/pm-password-secret.sops.yaml"
}

data "sops_file" "pm-sshkeys-secret" {  
  source_file = "./secrets/pm-sshkeys-secret.sops.yaml"
}

data "sops_file" "pm-sshprivate-secret" {  
  source_file = "./secrets/pm-sshprivate-secret.sops.yaml"
}