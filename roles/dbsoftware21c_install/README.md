# Automate Oracle 21c RDBMS Installations SI (Single Instances) with Ansible

Oracle Database 21c                   | Ansible Automation
:-------------------------:|:-------------------------:
![image](https://user-images.githubusercontent.com/37457408/136187322-fcdf44f9-078b-4266-8f8f-7ffd5d29c5b2.png)  |  ![image](https://user-images.githubusercontent.com/37457408/136187412-c9582e15-3544-4a28-b691-b01874cd343d.png)


This article describes the installation of Oracle Database 21c 64-bit on Oracle Linux 7 (OL7) 64-bit.

## Database Installation Guide for Linux
https://docs.oracle.com/en/database/oracle/oracle-database/21/ladbi/index.html

### software download page
Required Oracle Software: Download the Oracle software from OTN or MOS depending on your support status. Oracle binaries are staged from the "edelivery: Oracle Database 21c Software (64-bit)". They have to be manually downloaded and made available for this article to apply 
```
http://www.oracle.com/technetwork/indexes/downloads/index.html
```

### Setup:
 * OS: OEL 7.5 
 * Ansible: ansible 2.7.6
 * Database Version: Oracle 21.3 Linux64

## Master Playbook:
oracle21c_rdbmssoftinstall.yml

```
[root@oel75 ansible]# cat oracle21c_rdbmssoftinstall.yml
- hosts: dbservers
  user: root

  roles:
   - dbsoftware21c_install
```

There are three roles with this playbook: 

roles                  | tasks
---------------------- | ---------------------------------
 dbsoftware21c_install | # **To Install Oracle SI software installation**

## Tree structure 
```
[root@oel75 ansible]# tree roles/dbsoftware21c_install
roles/dbsoftware21c_install
├── files
│   └── 21cEE_SoftOnly.rsp
├── tasks
│   └── main.yml
├── templates
│   ├── 21cEE_SoftOnly.rsp.j2
│   └── oracle-database-preinstall-21c-1.0-1.el7.x86_64.rpm
└── vars
    └── main.yml

4 directories, 5 files

```
## Summary commands: 

1. Clone this repository:
    git clone https://github.com/asiandevs/oracle21c.git
    
2. Stage the following Oracle Software on the control machine
Oracle Database 21c (21.3) for Linux x86-64 
     - LINUX.X64_213000_db_home.zip

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

4. Run the playbook role "oracle21c_rdbmssoftinstall.yml"
```
ansible-playbook oracle21c_rdbmssoftinstall.yml  
```

You can also use:
Mode         | Option for
------------ | -------------
--check      | Check mode is just a simulation
--diff       | reports the changes made
--step       | ansible to stop on each task, and ask if it should execute that task.
-v           | verbose mode (-vvv for more, -vvvv to enable connection debugging)

```diff
- NOTE
! Please do modify based on your own setup. This is purely based on my own lab setup.
```









