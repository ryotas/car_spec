DROP USER carspec_rdfuser;
CREATE USER carspec_rdfuser IDENTIFIED BY oracle
DEFAULT TABLESPACE rdftbs TEMPORARY TABLESPACE temp;
GRANT connect, resource, unlimited tablespace TO carspec_rdfuser;

DROP USER carspec_pguser;
CREATE USER carspec_pguser IDENTIFIED BY oracle 
DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
GRANT connect, resource, unlimited tablespace TO carspec_pguser;

EXIT
