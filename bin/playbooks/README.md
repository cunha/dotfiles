# Configuration playbooks

## Install Ansible and deps

```{bash}
pip3 install ansible
ansible-galaxy install hurricanehrndz.rustup -p roles/
```

## Configure remote machines

1. Configure target host(s) in `hosts` in .ssh/config

2. Either one of:
    1. `ansible-playbook -i hosts --user root --ask-pass setup-base.yml`
    2. `ansible-playbook -i hosts --user cunha --become-method su --ask-su-pass setup-base.yml`
    3. `ansible-playbook -i hosts --user cunha --ask-pass --ask-su-pass --become-method=su setup-base.yml`

3. Enable `ForwardAgent` for hosts in `hosts` for GitHub access

4. `ansible-playbook -i hosts setup-cli.yml`
