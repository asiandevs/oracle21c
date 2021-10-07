# Oracle 21c - Deployment of Oracle Database Client for Linux x86–64 with Ansible

This Ansinble playbook is for the deployment of the Oracle full client, not the instant client for Linux x86–64.

### Setup:
 * OS: OEL 7.5 
 * Ansible: ansible 2.7.6
 * Database Version: Oracle 21.3 Linux64

## Master Playbook:
oracleclient21c_install.yml

There are two roles with this playbook: 

roles                  | tasks
---------------------- | --------------------------------------------------------
oracleclient21c_install|  **To deploy Oracle Client**

```
[root@oel75 ansible]# cat oracleclient21c_install.yml
- hosts: ora-x1
  user: root

  roles:
   - oracleclient21c_install

```
## Tree structure of this playbook
```
[root@oel75 ansible]# tree roles/oracleclient21c_install
roles/oracleclient21c_install
├── files
│   └── tns_upd.sh
├── tasks
│   └── main.yml
├── templates
│   └── oracleclient.soft.rsp.j2
└── vars
    └── main.yml

4 directories, 4 files

```

## Summary commands: 

1. Clone this repository:
    git clone https://github.com/asiandevs/oracle21c.git

2. Configure an Ansible inventory file (example as below) 
```
[root@oel75 ansible]# cat ansible.cfg | grep inventory
inventory = ./inventory
[root@oel75 ansible]# cat inventory
[ora-x1]
192.168.56.102

[oel75]
192.168.56.101

```
Note: Modify variables based on you setup or your requirements. 

4. Run the playbook role "cdb_pdb_create.yml"
```
ansible-playbook oracleclient21c_install.yml
```
5. Sample output is attached.

```diff
- NOTE
! Please do modify based on your own setup. This is purely based on my own lab setup.
```
