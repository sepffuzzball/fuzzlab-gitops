ansible-playbook -i ./inventory/hosts.yaml ./playbooks/apt-update.yaml
ansible-playbook -i ./inventory/hosts.yaml ./playbooks/install-sudo.yaml
ansible-playbook -i ./inventory/hosts.yaml ./playbooks/install-semaphore.yaml
