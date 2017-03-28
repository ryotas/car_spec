# carspec


## Creating Property Graph Data

    sqlplus rdfuser/rdfuser @create_opx.sql 
    sqlplus rdfuser/rdfuser @export_csv.sql

## Loading Data into Property Graph 

Open Groovy Shell.

    export JAVA_HOME=${ORACLE_HOME}/jdk/jre/
    export PATH=${JAVA_HOME}/bin:${PATH}

    sh $ORACLE_HOME/md/property_graph/dal/groovy/gremlin-opg-rdbms.sh

Load local files (.opv and .ope) into property graph on database.

```
oracle = new Oracle("jdbc:oracle:thin:@127.0.0.1:1521:orcl","opg_user","oracle");
opg = OraclePropertyGraph.getInstance(oracle, "carspec");
opg.countVertices();
opg.clearRepository();
opgdl = OraclePropertyGraphDataLoader.getInstance();
vfile = "data.opv";
efile = "data.ope";
opgdl.loadData(opg, vfile, efile, 4/*dop*/);
opg.countVertices();
opg.countEdges();
opg.commit();

:exit
```

## Executing SQL Queries on Property Graph

    sqlplus opg_user/oracle

```
SELECT COUNT(DISTINCT vid) FROM carspecVT$;
SELECT COUNT(DISTINCT eid) FROM carspecGE$;

set lines 200
set pages 500
col k for a30
col v for a50
col el for a20

SELECT vid, k, t, v FROM carspecVT$ WHERE vid=101;
SELECT eid, svid, dvid, el, k, t, v FROM carspecGE$ WHERE svid=101;

EXIT
```

## Loading Data into PGX and Executing PGQL Queries

    sh $ORACLE_HOME/md/property_graph/pgx/bin/pgx

```
G = session.readGraphWithProperties("load_to_pgx.json")

G.queryPgql(" \
  SELECT n.id(), n.TYPE, n.CATEGORY, n.MODEL, n.NAME \
  WHERE (n), n.TYPE='body' ORDER BY n.TYPE \
").print()

G.queryPgql(" \
  SELECT c1.MODEL, r1.label(), c2.MODEL, c2.TYPE \
  WHERE (c1)-[r1]->(c2), c1.MODEL='DAA-NHP10-AHXXB' \
").print()

G.queryPgql(" \
  SELECT c1.MODEL, r1.label(), c2.MODEL, r2.label(), r2.TYPE, c3.MODEL, r3.label(), r3.TYPE, c4.MODEL \
  WHERE (c1)-[r1]->(c2)-[r2]->(c3)-[r3]->(c4), c1.MODEL='DAA-NHP10-AHXXB' \
").print()

:exit
```

## Creating RDF View and Executing SPARQL Queries

* Open R2RML Editor of SQL Developer and import r2rml.nt.
* Commit this mapping to a RDF view "carspec_rdfview".
* Open SPARQL Editor and execute the following SPARQL queries.

```
PREFIX   ex: <http://example.com/ns#>

SELECT DISTINCT ?c2 ?c2_model ?c2_type
WHERE 
  { <http://data.example.com/body/DAA-NHP10-AHXXB> ex:hasPart ?c2 .
    ?c2 ex:model ?c2_model . ?c2 rdf:type ?c2_type . }
LIMIT 1000

SELECT DISTINCT ?c1_model ?c1_type ?c2_model ?c2_type ?c3_model ?c3_type ?c4_model ?c4_type
WHERE 
  { <http://data.example.com/body/DAA-NHP10-AHXXB> ex:hasPart ?c2 . ?c2 ex:hasPart ?c3 . ?c3 ex:hasPart ?c4 .
    ?c1 ex:model ?c1_model . ?c1 rdf:type ?c1_type .
    ?c2 ex:model ?c2_model . ?c2 rdf:type ?c2_type . 
    ?c3 ex:model ?c3_model . ?c3 rdf:type ?c3_type .
    ?c4 ex:model ?c4_model . ?c4 rdf:type ?c4_type }
LIMIT 1000
```

## Creating (Materialized) Semantic Model

Create a table to store triples.

    CREATE TABLE carspec_table ( triple SDO_RDF_TRIPLE_S );
    GRANT SELECT,INSERT on carspec_table to MDSYS;

Create a model.

Load ata from the staging table. (This operation should be done with SQL Dev GUI, but not working yet.)

    EXECUTE SEM_APIS.bulk_load_from_staging_table('carspec_model','RDFUSER','STAGING')


