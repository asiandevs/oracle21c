declare
lGrp     Number;
lDbRole  Varchar2(50);
begin
 
 for lDel in (select group# from v$standby_log)
 loop
   dbms_output.put_line ('Dropping standby redolog group '||lDel.group#);
   execute immediate 'alter database drop standby logfile group '||lDel.group#;
 end loop;
 
select max (group#)+1 into lGrp from v$log;
 for lRec in (select thread#, bytes, count (*) Cnt from v$log group by thread#, bytes order by 1)
 loop
   for lRedos in 1..lRec.Cnt + 1
    loop
     dbms_output.put_line ('Creating standby redolog for thread '||lRec.thread#||' group '||lGrp||' size '||lRec.bytes);
     execute immediate 'alter database add standby logfile thread '||lRec.thread#||' group '||lGrp||' size '||lRec.bytes;
     lGrp := lGrp + 1;
    end loop;
 end loop;
 
end;
/
exit;
