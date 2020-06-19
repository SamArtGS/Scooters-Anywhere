create  or replace  trigger quieto_vaquero
before insert or update or delete
on mobile
for each row
declare
var1 number(4);  
begin
select id into var1 from location where l_name='Mexico';
    IF (:new.id = var1 and to_char(:new.purchase_date, 'fmMONTH') = 'DECEMBER') THEN 
        raise_application_error( -20001, 'THIS mobile CAN NOT BE PURCHASED NOW.');
    END IF; 
END;
SHOW ERRORS;