# Oracle 21c - Container and Pluggable Database with Ansible
### create an empty Container database (CDB) using role "cdb_create_21c"
### create a pluggable database (PDB) using role "pdb21c_create"

![image](https://user-images.githubusercontent.com/37457408/134842588-8bc78ea4-5d7b-42b1-b7da-6517ee14e709.png)

This Ansinble playbook is for the deployment of Oracle 21c Container and Pluggable Database with Ansible on Oracle Linux 7 (OL7) 64-bit.

### Setup:
 * OS: OEL 7.5 
 * Ansible: ansible 2.7.6
 * Database Version: Oracle 21.3 Linux64

## Master Playbook:
cdb_pdb_create.yml

There are two roles with this playbook: 

roles                  | tasks
---------------------- | --------------------------------------------------------
1 cdb_create_21c       |  **To deploy Oracle Empty Container Database**
2 pdb21c_create        |  **To deploy pluggable database to an existing CDB**

### To deploy Oracle Empty Container Database:
> Enable role 1, disable role 2

```
[root@oel75 Oracle21c_CDBnPDB]# cat cdb_pdb_create.yml
- hosts: ora-x1
  user: root

  roles:
   - cdb_create_21c
#   - pdb21c_create

```

### To deploy pluggable database to an existing CDB:
> Enable role 2, disable role 1
```
[root@oel75 Oracle21c_CDBnPDB]# cat cdb_pdb_create.yml
- hosts: ora-x1
  user: root

  roles:
#   - cdb_create_21c
   - pdb21c_create

```
### To deploy both CDB and PDB:
> Enable both role 1 and role 2. Place them correctly first CDB and then PDB
```
[root@oel75 Oracle21c_CDBnPDB]# cat cdb_pdb_create.yml
- hosts: ora-x1
  user: root

  roles:
   - cdb_create_21c
   - pdb21c_create

```
## Summary commands: 

1. Clone this repository:
    git clone https://github.com/asiandevs/oracle21c.git
    
2. Make sure Oracle RDBMS software already installed

3. Configure an Ansible inventory file (example as below) 
```
[root@oel75 ansible]# cat ansible.cfg | grep inventory
inventory = ./inventory
[root@oel75 ansible]# cat inventory
[ora-x1]
192.168.56.102

[ora-x2]
192.168.56.103

[oel75]
192.168.56.101

[dbservers]
192.168.56.102
192.168.56.103
```
Note: Modify variables based on you setup or your requirements. 

4. Run the playbook role "cdb_pdb_create.yml"
```
ansible-playbook cdb_pdb_create.yml  
```
