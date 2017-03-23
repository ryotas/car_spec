DROP TABLE opv;
CREATE TABLE opv (
  vertex_id NUMBER
, key_name VARCHAR2(255)
, value_type NUMBER(1)
, value1 VARCHAR2(4000)
, value2 NUMBER
, value3 DATE
);

DROP TABLE ope;
CREATE TABLE ope (
  edge_id NUMBER
, source_vertex_id NUMBER
, destination_vertex_id NUMBER
, edge_label VARCHAR2(255)
, key_name VARCHAR2(255)
, value_type NUMBER(1)
, value1 VARCHAR2(4000)
, value2 NUMBER
, value3 DATE
);

-- BODY

INSERT INTO opv
  SELECT
    id AS vertex_id
  , key_name
  , 1 AS value_type
  , value1
  , null AS value2
  , null AS value3
  FROM body
  UNPIVOT EXCLUDE NULLS
  (value1 FOR key_name IN
    (model, type, name, name_en, grade, battery_type, steering, suspension_front, suspention_rear, brake_front, brake_rear, brake_system, drive_system, fuel_efficiency, fuel_efficiency, fuel_efficiency, fuel_efficiency, fuel_efficiency, fuel_efficiency, fuel_efficiency, fuel_efficiency))
UNION
  SELECT
    id AS vertex_id
  , key_name
  , 4 AS value_type
  , null AS value1
  , value2
  , null AS value3
  FROM body
  UNPIVOT EXCLUDE NULLS
  (value2 FOR key_name IN
    (weight, weight_total, min_turning_radius, fuel_consumption, fuel_capacity, length, width, height, wheel_base, tread_front, tread_rear, min_ground_clearance, interior_length, interior_width, interior_height, capacity, num_battery));

DROP SEQUENCE seq_ope;
CREATE SEQUENCE seq_ope;

INSERT INTO ope
  SELECT
    seq_ope.NEXTVAL AS edge_id
  , id AS source_vertex_id
  , destination_vertex_id
  , edge_label
  , null AS key_name
  , null AS value_type
  , null AS value1
  , null AS value2
  , null AS value3
  FROM body
  UNPIVOT EXCLUDE NULLS
  (destination_vertex_id FOR edge_label IN
    (engine_id, transmission_id, motor_id, motor_id2, battery_id));

-- ENGINE

INSERT INTO opv
  SELECT
    id AS vertex_id
  , key_name
  , 1 AS value_type
  , value1
  , null AS value2
  , null AS value3
  FROM engine
  UNPIVOT EXCLUDE NULLS
  (value1 FOR key_name IN
    (model, type, supercharger, fuel, max_output, max_output_net, max_torque, max_torque_net, fuel_supply_system))
UNION
  SELECT
    id AS vertex_id
  , key_name
  , 4 AS value_type
  , null AS value1
  , value2
  , null AS value3
  FROM engine
  UNPIVOT EXCLUDE NULLS
  (value2 FOR key_name IN
    (displacement, inner_diameter, stroke, compression_ratio));

COMMIT;

EXIT
