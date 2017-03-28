# carspec

## Setup

This script is tested on Oracle Database 12.2.0.1 with Patch 25640325.

* Patch 25640325: MISSING PGQL FUNCTION IN ORACLE DATABASE RELEASE 12.2.0.1

Also, sys password and file location are set as follows.

* SYS user password: oracle
* Data file location: /u01/app/oracle/oradata/orcl/*.dbf

To create a tablespace and configure it as a RDF semantic network, run this script (first time only).

    $ sh scripts/setup_semnet.sql

## Test

To test the whole demo contents, run this script.

    $ sh test.sh

* Creating Property Graph Data
* Loading Data into Property Graph 
* Executing SQL Queries on Property Graph
* Loading Data into PGX and Executing PGQL Queries

The following steps are not yet included.

* Creating RDF View and Executing SPARQL Queries
* Creating (Materialized) Semantic Model
* Create Inference Rules and Obtain Entailments
* Creating Another RDF View and Execute Cross-Domain Queries

## Demo

For learning this demo, the commands of the above test script should be executed one by one.

Also, for the following steps, you can do the same operations with SQL Developer GUI.

* SQL Developer 4.2 Early Adopter 2 (Version 4.2.0.16.356.1154) [Download](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/sqldev-ea-42-3211401.html)

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
```

```
PREFIX   ex: <http://example.com/ns#>
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
