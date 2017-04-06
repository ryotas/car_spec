# CARSPEC - Car Specification Example

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
* Visualize Property Graph with Cytoscape
* Visualize Semantic Graph with Cytoscape

## Demo

For learning this demo, the commands of the above test script should be executed one by one.

Also, for the following steps, you can do the same operations with SQL Developer GUI.

* SQL Developer 4.2 Early Adopter 2 (Version 4.2.0.16.356.1154) [Download](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/sqldev-ea-42-3211401.html)
