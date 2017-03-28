
# Setting Up Environments

sqlplus / as sysdba @scripts/setup.sql 

# Creating Property Graph Data

sqlplus rdfuser/rdfuser @scripts/create_opx.sql 
sqlplus rdfuser/rdfuser @scripts/export_csv.sql

# Loading Data into Property Graph

export JAVA_HOME=${ORACLE_HOME}/jdk/jre/
export PATH=${JAVA_HOME}/bin:${PATH}

cat scripts/load_to_pg.groovy |\
sh $ORACLE_HOME/md/property_graph/dal/groovy/gremlin-opg-rdbms.sh

# Executing SQL Queries on Property Graph

sqlplus opg_user/oracle @scripts/query_to_pg.sql

# Loading Data into PGX and Executing PGQL Queries

cat scripts/query_to_pgx.pgql |\
sh $ORACLE_HOME/md/property_graph/pgx/bin/pgx

# Creating RDF View and Executing SPARQL Queries

# Creating (Materialized) Semantic Model


