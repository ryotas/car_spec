DROP USER carspec_rdfuser CASCADE;
CREATE USER carspec_rdfuser IDENTIFIED BY oracle
DEFAULT TABLESPACE rdftbs TEMPORARY TABLESPACE temp;
GRANT connect, resource, unlimited tablespace TO carspec_rdfuser;

DROP USER carspec_pguser CASCADE;
CREATE USER carspec_pguser IDENTIFIED BY oracle 
DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;
GRANT connect, resource, unlimited tablespace TO carspec_pguser;

EXIT
