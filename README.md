# car_spec

    sqlplus rdfuser/rdfuser @create_opx.sql 
    sqlplus rdfuser/rdfuser @export_csv.sql

-- Groovy Shell

    export JAVA_HOME=${ORACLE_HOME}/jdk/jre/
    export PATH=${JAVA_HOME}/bin:${PATH}

    sh $ORACLE_HOME/md/property_graph/dal/groovy/gremlin-opg-rdbms.sh

```
oracle = new Oracle("jdbc:oracle:thin:@127.0.0.1:1521:orcl","opg_user","oracle");
opg = OraclePropertyGraph.getInstance(oracle, "car_spec");
opg.countVertices();
opg.clearRepository();
opgdl = OraclePropertyGraphDataLoader.getInstance();
vfile = "car_spec.opv";
efile = "car_spec.ope";
opgdl.loadData(opg, vfile, efile, 4/*dop*/);
opg.countVertices();
opg.countEdges();
opg.commit();

:exit
```

-- Property Graph

    sqlplus opg_user/oracle

```
SELECT COUNT(DISTINCT vid) FROM car_specVT$;
SELECT COUNT(DISTINCT eid) FROM car_specGE$;

set lines 200
set pages 500
col k for a30
col v for a50
col el for a20

SELECT vid, k, t, v FROM car_specVT$ WHERE vid=101;
SELECT eid, svid, dvid, el, k, t FROM car_specGE$ WHERE svid=101;

EXIT
```

-- PGX

    sh $ORACLE_HOME/md/property_graph/pgx/bin/pgx

```
G = session.readGraphWithProperties("car_spec.json")

G.queryPgql(" \
  SELECT n.id(), n.MODEL WHERE (n) \
").print()

G.queryPgql(" \
  SELECT b1.MODEL, r1.label(), c.MODEL, r2.label(), b2.MODEL \
  WHERE (b1)-[r1]->(c)<-[r2]-(b2), \
  b1.MODEL='DAA-NHP10-AHXXB', b1!=b2 \
").print()
```

-- RDF View

