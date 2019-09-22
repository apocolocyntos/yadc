# yadc
Yet Another Data-Center


## Requirements

- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [ec2.py](https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#inventory-script-example-aws-ec2) as dynamic inventory for ansible


## Create own RootCA

```
> mkdir ansible/private
> cd ansible/private
> openssl genrsa -aes256 -out rootca.key 4096
> openssl req -x509 -new -nodes -key rootca.key -days 1024 -out rootca.crt -sha512
```

For convenience and NOT for production the password is saved in a file (```ansible/private/rootca.pw```) for further use by ansible. This has to be solved in the future.


## Create Resources on AWS with Terraform

``` bash
> cd terraform
> terraform apply 
```

## Deploy Insfrastucure with Ansible

```bash
> cd ansible
> ansible-playbook playbook.yml -i /path/to/ec2.py
```

*Note: ec2.py has to be executable*