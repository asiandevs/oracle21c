# oracle21c
Different database tasks with Ansible. 

```diff
- NOTE
! Make sure any Licence requirements from your side. Please do modify based on your own setup. This is purely based on my own lab setup. You can ask me any questions in relate to these playbooks - if you fork and modify to merge - let me know.
```

# SI database
### i. create an empty Container database (CDB) using role "cdb_create_21c"
### ii. create a pluggable database (PDB) using role "pdb21c_create"

# Grid Infrastructure / RAC 21c 
### i. GI Software Install
### ii. RAC RDBMS Software Install
### iii. RAC Database Creation CDB & PDB
### iv. GI for a Standalone Server

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

## Roles

roles                  | tasks
---------------------- | ----------------------------------------------------------------------
dbsoftware21c_install |  **To Install Oracle SI database Software - multiple servers at a time https://github.com/asiandevs/oracle21c/tree/main/roles/dbsoftware21c_install**
cdb_create_21c       |  **To deploy an empty Container Database (CDB) https://github.com/asiandevs/oracle21c/tree/main/roles/cdb_create_21c**
pdb21c_create        |  **To deploy pluggable database (PDB) to an existing CDB https://github.com/asiandevs/oracle21c/tree/main/roles/pdb21c_create**
sbdb21c_create       |  **To create a physical Standby database and setup Data Guard Broker https://github.com/asiandevs/oracle21c/tree/main/roles/sbdb21c_create**
racgi21c_install     |  **To Install Oracle Grid Infrastructure Installation https://github.com/asiandevs/oracle21c/tree/main/roles/racgi21c_install**
racdbsoft21c_install |  **To Install Oracle RAC software installation https://github.com/asiandevs/oracle21c/tree/main/roles/racdbsoft21c_install**
racdb21c_create      |  **To create Two Node RACDB ~21C https://github.com/asiandevs/oracle21c/tree/main/roles/racdb21c_create**
racdb21c_patch_apply |  **To apply GI Release Update and Database Release Update ~21C October 2021 https://github.com/asiandevs/oracle21c/tree/main/roles/racdb21c_patch_apply**
racgi_ss_21c_install |  **Oracle Grid Infrastructure for a Standalone Server https://github.com/asiandevs/oracle21c/tree/main/roles/racgi_ss_21c_install**
oracleclient21c_install| **Deployment of Oracle Database 21c Client for Linux x86–64 https://github.com/asiandevs/oracle21c/tree/main/roles/oracleclient21c_install** 
RAC database upgrade / Downgrade [ using flashback] | **https://github.com/asiandevs/RAC18CUpgradeDowngrade**
Oracle Cloud File System [ACFS] setup | **https://github.com/asiandevs/racdb_createacfs**
Oracle Database Client Installation | **https://github.com/asiandevs/Oracle_Database_Client_Installation**
Linux setup for Oracle Software Installation | **https://github.com/asiandevs/oraclelinuxsetup**
Jenkins CI/CD - Deployment of Oracle RDBMS software Installation and Create Oracle Database | **https://github.com/asiandevs/oradbjenkins**
Docker image -- Oracle Database 19c (19.3) Enterprise Edition | **https://hub.docker.com/r/banglamon/oracle193db**

```diff
- NOTE
! Please do modify based on your own setup. This is purely based on my own lab setup.
```
