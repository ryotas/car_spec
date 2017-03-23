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

DROP SEQUENCE seq_ope;
CREATE SEQUENCE seq_ope;

-- BODY

INSERT INTO opv
  SELECT DISTINCT
    id AS vertex_id
  , 'TYPE' AS key_name
  , 1 AS value_type
  , 'body' AS value1
  , null AS value2
  , null AS value3
  FROM body;

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
    (model, category, name, battery_type, steering, suspension_front, suspention_rear, brake_front, brake_rear, brake_system, drive_system))
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

INSERT INTO ope
  SELECT
    seq_ope.NEXTVAL AS edge_id
  , id AS source_vertex_id
  , destination_vertex_id
  , 'hasPart' AS edge_label
  , 'TYPE' AS key_name
  , 1 AS value_type
  , value1
  , null AS value2
  , null AS value3
  FROM body
  UNPIVOT EXCLUDE NULLS
  (destination_vertex_id FOR value1 IN
    (engine_id, transmission_id, motor_id, motor_id2, battery_id));

COMMIT;

-- ENGINE

INSERT INTO opv
  SELECT DISTINCT
    id AS vertex_id
  , 'TYPE' AS key_name
  , 1 AS value_type
  , 'engine' AS value1
  , null AS value2
  , null AS value3
  FROM engine;

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
    (model, category, supercharger, fuel, max_output, max_output_net, max_torque, max_torque_net, fuel_supply_system))
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

INSERT INTO opv
  SELECT
    ORA_HASH(value1) AS vertex_id
  , 'MODEL' AS key_name
  , 1 AS value_type
  , value1
  , null AS value2
  , null AS value3
  FROM (
        SELECT DISTINCT cylinder_block AS value1 FROM engine
  UNION SELECT DISTINCT cylinder AS value1 FROM engine
  UNION SELECT DISTINCT cylinder_head AS value1 FROM engine
  UNION SELECT DISTINCT distributor AS value1 FROM engine
  UNION SELECT DISTINCT distributor_cap AS value1 FROM engine
  UNION SELECT DISTINCT distributor_oring AS value1 FROM engine
  );

INSERT INTO ope
  SELECT
    seq_ope.NEXTVAL AS edge_id
  , sid AS source_vertex_id
  , did AS destination_vertex_id
  , 'hasPart' AS edge_label
  , 'TYPE' AS key_name
  , 1 AS value_type
  , value1
  , null AS value2
  , null AS value3
  FROM (
        SELECT DISTINCT id AS sid, ORA_HASH(cylinder_block) AS did, 'cylinder_block_id' AS value1 FROM engine
  UNION SELECT DISTINCT id AS sid, ORA_HASH(distributor) AS did, 'distributor_id' AS value1 FROM engine
  UNION SELECT DISTINCT ORA_HASH(cylinder_block) AS sid, ORA_HASH(cylinder_head) AS did, 'cylinder_head_id' AS value1 FROM engine
  UNION SELECT DISTINCT ORA_HASH(cylinder_block) AS sid, ORA_HASH(cylinder) AS did, 'cylinder_id' AS value1 FROM engine
  UNION SELECT DISTINCT ORA_HASH(distributor) AS sid, ORA_HASH(distributor_cap) AS did, 'distributor_cap_id' AS value1 FROM engine
  UNION SELECT DISTINCT ORA_HASH(distributor) AS sid, ORA_HASH(distributor_oring) AS did, 'distributor_oring_id' AS value1 FROM engine
  );

COMMIT;

-- MOTOR

INSERT INTO opv
  SELECT DISTINCT
    id AS vertex_id
  , 'TYPE' AS key_name
  , 1 AS value_type
  , 'motor' AS value1
  , null AS value2
  , null AS value3
  FROM motor;

INSERT INTO opv
  SELECT
    id AS vertex_id
  , key_name
  , 1 AS value_type
  , value1
  , null AS value2
  , null AS value3
  FROM motor
  UNPIVOT EXCLUDE NULLS
  (value1 FOR key_name IN
    (model, category))
UNION
  SELECT
    id AS vertex_id
  , key_name
  , 4 AS value_type
  , null AS value1
  , value2
  , null AS value
  FROM motor
  UNPIVOT EXCLUDE NULLS
  (value2 FOR key_name IN
    (power, max_power, max_power_net, max_torque, max_torque_net));

COMMIT;

-- BATTERY

INSERT INTO opv
  SELECT DISTINCT
    id AS vertex_id
  , 'TYPE' AS key_name
  , 1 AS value_type
  , 'battery' AS value1
  , null AS value2
  , null AS value3
  FROM battery;

INSERT INTO opv
  SELECT
    id AS vertex_id
  , key_name
  , 1 AS value_type
  , value1
  , null AS value2
  , null AS value3
  FROM battery
  UNPIVOT EXCLUDE NULLS
  (value1 FOR key_name IN
    (model, category))
UNION
  SELECT
    id AS vertex_id
  , key_name
  , 4 AS value_type
  , null AS value1
  , value2
  , null AS value
  FROM battery
  UNPIVOT EXCLUDE NULLS
  (value2 FOR key_name IN
    (capacity, voltage, total_voltage, total_energy));

COMMIT;

EXIT
