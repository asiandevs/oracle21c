# oracle21c
Different database tasks with Ansible
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
---------------------- | ---------------------------------
dbsoftware21c_install |  **To Install Oracle SI database Software**
cdb_create_21c       |  **To deploy an empty Container Database (CDB)**
pdb21c_create        |  **To deploy pluggable database (PDB) to an existing CDB**
sbdb21c_create       |  **To create a physical Standby database and setup Data Guard Broker**
racgi21c_install     |  **To Install Oracle Grid Infrastructure Installation**
racdbsoft21c_install |  **To Install Oracle RAC software installation**
racdb21c_create      |  **To create Two Node RACDB ~21C**
racgi_ss_21c_install |  **Oracle Grid Infrastructure for a Standalone Server**

