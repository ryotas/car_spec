SET LINESIZE 200
SET PAGESIZE 0
SET SERVEROUTPUT OFF
SET SQLPROMPT OFF
SET FEEDBACK OFF
SET TERMOUT OFF
SET TRIMSPOOL ON

SPOOL car_spec.opv
SELECT
        vertex_id
||','|| key_name
||','|| value_type
||','|| value1
||','|| value2
||','|| value3
FROM opv;
SPOOL OFF

SPOOL car_spec.ope
SELECT
        edge_id
||','|| source_vertex_id
||','|| destination_vertex_id
||','|| edge_label
||','|| key_name
||','|| value_type
||','|| value1
||','|| value2
||','|| value3
FROM ope;
SPOOL OFF

EXIT
