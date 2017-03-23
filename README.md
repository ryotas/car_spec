# carspec

    sqlplus rdfuser/rdfuser @create_opx.sql 
    sqlplus rdfuser/rdfuser @export_csv.sql

-- Groovy Shell

    export JAVA_HOME=${ORACLE_HOME}/jdk/jre/
    export PATH=${JAVA_HOME}/bin:${PATH}

    sh $ORACLE_HOME/md/property_graph/dal/groovy/gremlin-opg-rdbms.sh

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

-- Property Graph

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

-- PGX

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
```

-- RDF View

* Open R2RML Editor of SQL Developer and import r2rml.nt.
* Commit this mapping to a RDF view "carspec_rdfview".
* Open SPARQL Editor and execute the following SPARQL queries.
