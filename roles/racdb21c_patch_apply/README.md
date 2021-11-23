# Grid Infrastructure 21c 

```diff
- NOTE
! Please do modify variables based on your own setup. This is purely based on my own lab setup. You can ask me any questions in relate to these playbooks - if you fork and modify to merge - let me know.
```
## GI Release Update and Database Release Update October'2021

This Ansinble playbook is for applying GI Release Update and Database Release Update| 21c October 2021| 64-bit on Oracle Linux 7 (OL7) 64-bit.
![img](https://miro.medium.com/max/1400/1*Dn-ENgHGeaJk8kpJXE_Sdw.png)

### software download page
Required Oracle Software: Download the Oracle software from OTN or MOS depending on your support status. Oracle binaries are staged from the "edelivery: Oracle Database 21c Software (64-bit)". They have to be manually downloaded and made available for this article to apply 
```
Patch 33250101 - GI Release Update 21.4.0.0.211019
Patch 33239276 - Database Release Update 21.4.0.0.211019
OPatch utility version 12.2.0.1.27 or later

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
racdb21c_patch_apply |  **To apply GI Release Update and Database Release Update ~21C October 2021**

```
[root@oel75 ansible]# cat oracleGInRAC21c.yml
- hosts: ora-x1, ora-x2
  user: root

  roles:
   #- racgi21c_install
   #- racdbsoft21c_install
   #- racdb21c_create
   - racdb21c_patch_apply
   #- rac21c_createacfs
   #- racgi_ss_21c_install

```
## Tree structure of this playbook
```
[root@oel75 ansible]# tree roles/racdb21c_patch_apply
roles/racdb21c_patch_apply
├── defaults
│   └── main.yml
├── files
│   ├── sqlpatch01.sql
│   ├── sqlpatchinfo.sql
│   └── sqlpatch.sql
├── tasks
│   ├── compile_inv_obj.yml
│   ├── create_dirs.yml
│   ├── datapatch_dbs.yml
│   ├── db_ru_frstnode.yml
│   ├── db_ru_nodes.yml
│   ├── dbrupatch_conflict_check.yml
│   ├── db_ru_secndnode.yml
│   ├── dbru_start_allinstances_firstnode.yml
│   ├── dbru_start_allinstances_secondnode.yml
│   ├── dbru_stop_allinstances_firstnode.yml
│   ├── dbru_stop_allinstances_secondnode.yml
│   ├── list_dbs.yml
│   ├── main.yml
│   ├── opatch_conflict_check.yml
│   ├── opatch_inventory_check.yml
│   ├── opatch_lspatches_beforeapply.yml
│   ├── opatch_systemspace_check.yml
│   ├── postpatch_apply.yml
│   ├── prepatch_apply.yml
│   ├── restsrt_cluster_frstnode.yml
│   ├── restsrt_cluster_secnode.yml
│   ├── ru_frstnode_gindb.yml
│   ├── ru_secnode_gindb.yml
│   ├── start_db_withcrs.yml
│   ├── start_db_withsqlplus.yml
│   ├── unzip_patch.yml
│   ├── update_opatch.yml
│   └── verify_patch_apply.yml
├── templates
│   ├── patch_list_dbhome.txt
│   ├── patch_list_dbhome.txt.j2
│   ├── patch_list_gihome.txt
│   └── patch_list_gihome.txt.j2
└── vars
    └── main.yml

5 directories, 37 files

```

## Summary commands: 

1. Clone this repository:
    git clone https://github.com/asiandevs/oracle21c.git
    
2. Stage the required patch software on the control machine

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
5. Sample logfile is attached.
