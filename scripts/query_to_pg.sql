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
