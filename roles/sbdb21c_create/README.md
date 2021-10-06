# Oracle 21c - Create a SI Physical Standby database and setup Data Guard broker using Ansible playbook

This Ansinble playbook is for creating a physical standby using existing primary database.
![image](https://user-images.githubusercontent.com/37457408/136183041-e31358c7-c935-43cc-9529-cf302f20ad3d.png)

## Create a Physical Standby 21c Guide
https://docs.oracle.com/en/database/oracle/oracle-database/21/sbydb/creating-oracle-data-guard-physical-standby.html#GUID-B511FB6E-E3E7-436D-94B5-071C37550170

## Data Guard Broker 21c Guide
https://docs.oracle.com/en/database/oracle/oracle-database/21/dgbkr/

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
PhysicalSB_Broker21c.yml
```
[root@oel75 ansible]# cat PhysicalSB_Broker21c.yml
- hosts: ora-x1,ora-x2
  any_errors_fatal: true
  user: root

  roles:
   - sbdb21c_create

```

There is a single role with this playbook: 

roles                  | tasks
---------------------- | ----------------------------------------------------------
1 sbdb21c_create    | # **To Create a Physical Standby Database and Setup Broker**

## Tree structure 
```
[root@oel75 ansible]# tree roles/sbdb21c_create
roles/sbdb21c_create
├── defaults
│   └── main.yml
├── files
│   ├── add_staticlsnr.sh
│   ├── chkexistdg.sql
│   ├── dg_status.sql
│   ├── gensbredologs.sql
│   ├── postcrpr.sql
│   ├── postcrsb.sql
│   └── tns_upd.sh
├── tasks
│   ├── dg_brokersetup.yml
│   ├── dg_brokervalidate.yml
│   ├── dg_existchk.yml
│   ├── dg_prep_psb.yml
│   ├── dg_sbvalidate.yml
│   └── main.yml
├── templates
│   ├── dgrole_modify.sh.j2
│   ├── listener.rsp.21c.j2
│   ├── lsnr_upd.sh.j2
│   ├── oracledb
│   │   └── database_service.j2
│   ├── postcrpr.sh.j2
│   ├── postcrsb.sh.j2
│   ├── prdb_tns.sh.j2
│   ├── redologs.sh.j2
│   ├── sbdbcreate.sh.j2
│   └── silent-lsnr21c-config.rsp.j2
└── vars
    └── main.yml

6 directories, 25 files

```
## Summary commands: 

Assumption: 
i. Oracle RDBMS software is installed both on the Primary and Standby database servers.
ii. Primary database is setup with archive log enabled.

1. Clone this repository:
    git clone https://github.com/asiandevs/oracle21c.git
    
2. Configure an Ansible inventory file (example as below) 
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

4. Run the playbook role "PhysicalSB_Broker21c.yml"
```
ansible-playbook PhysicalSB_Broker21c.yml 
```


````diff
- Please do modify variables - based on your setup - this is purely based on my own lab setup 
