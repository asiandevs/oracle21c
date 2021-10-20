# Grid Infrastructure 21c 
### GI Software Install
### RAC RDBMS Software Install
### RAC Database Creation CDB & PDB
### GI for a Standalone Server

This Ansinble playbook is for Oracle Grid Infrastructure Installation, Oracle RAC Installation and Create RAC database 21c 64-bit on Oracle Linux 7 (OL7) 64-bit.
![img](https://miro.medium.com/max/1400/1*Dn-ENgHGeaJk8kpJXE_Sdw.png)

## Grid Infrastructure Installation and Upgrade Guide for Linux
https://docs.oracle.com/en/database/oracle/oracle-database/21/install-and-upgrade.html

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
oracleGInRAC21c.yml

There are three roles with this playbook: 

roles                  | tasks
---------------------- | ---------------------------------
1 racgi21c_install     | # **To Install Oracle Grid Infrastructure Installation**
2 racdbsoft21c_install | # **To Install Oracle RAC software installation**
3 racdb21c_create      | # **To create Two Node RACDB ~21C**
4 racgi_ss_21c_install | # **Oracle Grid Infrastructure for a Standalone Server

### To Install Oracle Grid Infrastructure Installation:
> Enable role 1, disable role 2 and role3

```
[root@oel75 ansible]# cat oracleGInRAC21c.yml
- hosts: ora-x1,ora-x2
  user: root

  roles:
   #- racdb21c_create
   #- racdbsoft21c_install
   - racgi21c_install
   #- racgi_ss_21c_install
```

### To Install Oracle RAC software installation:
> Enable role 2, disable role 1 and role3 [ Pre-step: Role 1 should be completed ]
```
[root@oel75 ansible]# cat oracleGInRAC21c.yml
- hosts: ora-x1,ora-x2
  user: root

  roles:
   #- racdb21c_create
   - racdbsoft21c_install
   #- racgi21c_install
   #- racgi_ss_21c_install
```

### To create Two Node RACDB ~21C:
> Enable role 3, disable role 1 and role2 [ Pre-step: Role 1 and 2 should be completed ]
```
[root@oel75 ansible]# cat oracleGInRAC21c.yml
- hosts: ora-x1,ora-x2
  user: root

  roles:
   - racdb21c_create
   #- racdbsoft21c_install
   #- racgi21c_install
   #- racgi_ss_21c_install
```
For role 1, 2, 3 - you can execute one by one or all of them together. Only thing to make sure the sequence.
```
[root@oel75 ansible]# cat oracleGInRAC21c.yml
- hosts: ora-x1,ora-x2
  user: root

  roles:
   - racgi21c_install
   - racdbsoft21c_install
   - racdb21c_create
   #- racgi_ss_21c_install
```

[![Watch the video](https://imgur.com/gallery/g9zGd)](https://youtu.be/c3XGeZPkNRU)


### To Install Oracle Grid Infrastructure for a Standalone Server
> Enable only role 4 -- This is a separate individual task

```
[root@oel75 ansible]# cat oracleGInRAC21c.yml
- hosts: ora-x1,ora-x2
  user: root

  roles:
   #- racdb21c_create
   #- racdbsoft21c_install
   #- racgi21c_install
   - racgi_ss_21c_install
```

## Summary commands: 

1. Clone this repository:
    git clone https://github.com/asiandevs/oracle21c.git
    
2. Stage the following Oracle Software on the control machine

Oracle Database 21c Grid Infrastructure (21.3) for Linux x86-64
     - LINUX.X64_213000_grid_home.zip
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

4. Run the playbook role "oracleGInRAC21c.yml"
```
ansible-playbook oracleGInRAC21c.yml  
```
