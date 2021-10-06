#!/bin/bash

####################### ADD STATIC SERVICE IN THE REQUIRED LISTENER #######################
### 
### add_staticlsnr.sh
### PARAMETERS ###
### $1 RECEIVE ORACLE_UNQNAME
### $2 RECEIVE ORACLE_SID
### $3 RECEIVE NAME OF THE LISTENER REQUIRED TO CREATE THE STATIC SERVICE
### $4 RECEIVE ORACLE_HOME OF THE REQUIRED LISTENER TO BE CREATED THE STATIC SERVICE
### $5 RECEIVE ORACLE_HOME
####################### ADD STATIC SERVICE IN THE REQUIRED LISTENER #######################

#export ORACLE_HOME=/u01/app/oracle/product/21.3.0/db300
export ORACLE_SUNQNAME=$1
export ORACLE_SID=$2    ##{{ oracle_sid }}
export LISTENER_NAME=$3 ##{{ lsnr_name }}
export LISTENER_HOME=$4   ## {{ tns_path }}
export ORACLE_HOME=$5  ##{{ oracle_home }}
export LISTENER_FILE=listener.ora ## {{ stlsnr_file }}

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] || [-z $5]; then
echo "Missing one or more required parameters: [GLOBAL_DBNAME] [SID_NAME] [LISTENER_NAME] [LISTENER_HOME] [ORACLE_HOME]"
exit;
fi


lnt1=`cat $LISTENER_HOME/$LISTENER_FILE | grep SID_NAME | awk '{print $3}' | sed  's/)//g' | wc -l`
lnt2=`cat $LISTENER_HOME/$LISTENER_FILE | grep GLOBAL_DBNAME | awk '{print $3}' | sed  's/)//g' | wc -l`
ln=0
sid_list_ora=`cat $LISTENER_HOME/$LISTENER_FILE | grep "SID_LIST_$3 ="`
cnt_fnd=0

while [ $ln -le $lnt1 ] || [ $ln -le $lnt2 ]; do

  sid_name_ora=`cat $LISTENER_HOME/$LISTENER_FILE | grep SID_NAME | awk '{print $3}' | sed  's/)//g' | awk -v line=$ln 'NR==line'`
 gb_name_ora=`cat $LISTENER_HOME/$LISTENER_FILE | grep GLOBAL_DBNAME | awk '{print $3}' | sed  's/)//g' | awk -v line=$ln 'NR==line'`
 

   if [ -n "$sid_list_ora" ] && [ "$sid_name_ora" != "$ORACLE_SID" ] || [ "$gb_name_ora" != "$ORACLE_UNQNAME" ] && [ $ln != 0 ]; then  
   cnt_fnd=1 
  else
   cnt_fnd=0   
  fi
 
  if [ -n "$sid_list_ora" ] && [ "$sid_name_ora" == "$ORACLE_SID" ] && [ "$gb_name_ora" == "$ORACLE_UNQNAME" ]; then
   echo ""
   echo " *** This entry already exists: $sid_name_ora for listener: $3 ***"
   echo ""
   exit;
    elif [ -z "$sid_list_ora" ] && [ $ln -lt 1 ]; then
     echo ""
     echo "*** Creating SID_LIST for: $3 and adding service: $1 ***"
     echo ""
echo "
SID_LIST_$3 = 
  (SID_LIST =
    (SID_DESC =
      (GLOBAL_DBNAME = $ORACLE_SUNQNAME)
      (ORACLE_HOME = $ORACLE_HOME)
      (SID_NAME = $ORACLE_SID)
    )
  )
" >> $LISTENER_HOME/$LISTENER_FILE
  fi
 ln=$(( ln+1 ))
done


if [ "$cnt_fnd" != 0 ]; then
 echo ""
 echo "*** Adding service entry: $ORACLE_UNQNAME for listener: $3 ***"
 echo ""
 sed -i '/SID_LIST =/a \ \ \ \ (SID_DESC = \n \ \ \ \ \ (GLOBAL_DBNAME = '$ORACLE_UNQNAME') \n \ \ \ \ \ (ORACLE_HOME = '$ORACLE_HOME') \n \ \ \ \ \ (SID_NAME = '$ORACLE_SID') \n \ \ \ )' $LISTENER_HOME/$LISTENER_FILE
fi

