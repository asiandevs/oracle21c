connect sys/{{ password_sys }}@{{ prdbunq_name }} as sysdba
alter system set standby_file_management=auto scope=both;
alter system set dg_broker_config_file1='{{ db_createfile_path }}/{{ prdbunq_name }}/dr1.dat' scope=both;
alter system set dg_broker_config_file2='{{ db_recofile_dest }}/{{ prdbunq_name }}/dr2.dat' scope=both;
alter system set dg_broker_start=true scope=spfile;
shutdown immediate
startup
host sleep 30
host dgmgrl sys/{{ password_sys }}@{{ prdbunq_name }} "CREATE CONFIGURATION dgconfig AS PRIMARY DATABASE IS {{ prdbunq_name }} CONNECT IDENTIFIER IS {{ prdbunq_name }}";
host sleep 30
host dgmgrl sys/{{ password_sys }}@{{ prdbunq_name }} "ADD DATABASE {{ sbdbunq_name }} AS CONNECT IDENTIFIER IS {{ sbdbunq_name }}" ;
host dgmgrl sys/{{ password_sys }}@{{ prdbunq_name }} "ENABLE CONFIGURATION"
exit;
