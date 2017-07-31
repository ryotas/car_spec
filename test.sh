
# Setting Up Environments

echo -e "\n\n###################\n create_users.sql \n###################\n\n"
sqlplus / as sysdba @scripts/create_users.sql

# Importing Table Data

echo -e "\n\n###################\n import_tables.sql \n###################\n\n"
imp carspec_rdfuser/oracle tables=BODY,ENGINE,MOTOR,BATTERY file=data/data.dmp

# Creating Property Graph Data

echo -e "\n\n###################\n create_opx.sql \n###################\n\n"
sqlplus carspec_rdfuser/oracle @scripts/create_opx.sql 

echo -e "\n\n###################\n export_csv.sql \n###################\n\n"
sqlplus carspec_rdfuser/oracle @scripts/export_csv.sql

# Loading Data into Property Graph

export JAVA_HOME=${ORACLE_HOME}/jdk/jre/
export PATH=${JAVA_HOME}/bin:${PATH}

cat scripts/load_to_pg.groovy |\
sh $ORACLE_HOME/md/property_graph/dal/groovy/gremlin-opg-rdbms.sh

# Executing SQL Queries on Property Graph

sqlplus carspec_pguser/oracle @scripts/query_to_pg.sql

# Loading Data into PGX and Executing PGQL Queries

cat scripts/query_to_pgx.pgql |\
sh $ORACLE_HOME/md/property_graph/pgx/bin/pgx

# Creating RDF View and Executing SPARQL Queries

# Creating (Materialized) Semantic Model


