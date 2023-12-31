# SOPS

## Install

```sh
curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64
sudo mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops
sudo chmod +x /usr/local/bin/sops
```

## Create Key

```sh
sudo apt install age
age-keygen -o ~/.sops/key.txt
```

## Encrypt

```sh
# Sops in path, key in ~/.sops/key.txt, in ansible/inventory/host_vars
sops --encrypt --age $(cat ~/.sops/key.txt |grep -oP "public key: \K(.*)") ./decrypted/pvenode01.dec.yaml > ../pvenode01.sops.yaml
```

## Decrypt

```sh
# Sops in path, key in ~/.sops/key.txt, in terraform/rancher
sops --decrypt --age $(cat ~/.sops/key.txt |grep -oP "public key: \K(.*)") ./secrets/decrypted/pm-sshkeys-secret.enc.yaml > ./secrets/pm-sshkeys-secret.dec.yaml
```