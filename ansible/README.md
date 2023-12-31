# Ansible

## Rancher

Setup scripts and such specifically for my environment

## k3s-ansible

Ansible scripts for setting up k3s modified from Techno Tim.

```sh
git clone https://github.com/techno-tim/k3s-ansible
```

## Send arbitrary commands

```sh
# paths assume running from git/ansible dir
cd ./ansible
ansible -i <path/to/inventory> -l <groupname> -m ansible.builtin.shell -a <shell command> --become
# e.g.
# > ansible -i ./inventory -l <groupname> -m ansible.builtin.shell -a "apt upgrade -y" --become
```

## Call arbitrary playbooks

```sh
# paths assume running from git/ansible dir
cd ./ansible
ansible-playbook -i <path/to/inventory> -l <groupname> <path/to/playbook> --become
# e.g.
# > ansible-playbook -i ./inventory -l ubuntu ./playbooks/cluster-reboot.yaml --become
```