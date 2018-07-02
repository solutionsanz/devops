begin
  DBMS_CLOUD.create_credential (
    credential_name => OBJ_STORE_CRED',
    username => 'xxxx',
    password => 'xxxxxxx'
  ) ;
end;
/
