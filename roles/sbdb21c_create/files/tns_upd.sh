#!/bin/bash
export TNSNAMES_FILE=tnsnames.ora
export ENTRY_NAME=$1 ##{{ oracle_sbsid }}
export HOST_ADDR=$2 ##{{ sbhost }}
export PORT_NUM=$3
export SRV_NAME=$4
export TNS_ADMIN_DIR=$5
export ORACLE_HOME=$6  ##{{ oracle_home }}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] || [ -z $5 ] || [ -z $6 ]; then

  echo "Missing one or more required parameters: [ENTRY_NAME] [HOST_ADDR] [PORT_NUM] [SERVICE_NAME] [TNS_ADMIN_DIR] [ORACLE_HOME]"
  exit;

fi

chk_entry=`cat $TNS_ADMIN_DIR/$TNSNAMES_FILE | grep "$ENTRY_NAME =" | wc -l`

if [ -n "$chk_entry" ] && [ "$chk_entry" = 0 ]; then

  echo "Creating the required entry..."
  echo ""

echo "
$ENTRY_NAME =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $HOST_ADDR)(PORT = $PORT_NUM))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = $SRV_NAME)
    )
  )
" >> $TNS_ADMIN_DIR/$TNSNAMES_FILE

   elif [ "$chk_entry" != 0 ]; then

   echo ""
  echo "This entry already exists: [$ENTRY_NAME]."
  echo "Nothing to do!"
  echo ""
   exit;
  
fi 
