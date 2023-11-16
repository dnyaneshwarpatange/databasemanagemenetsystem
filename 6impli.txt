CREATE TABLE rollcall (
  rn INT,
  name VARCHAR(77),
  marks INT
);

CREATE TABLE N_RollCall (
  rn INT,
  name VARCHAR(77),
  marks INT
);

INSERT INTO rollcall VALUES (5, 'P', 30);
INSERT INTO rollcall VALUES (1, 'A', 35);
INSERT INTO rollcall VALUES (4, 'D', 37);
INSERT INTO rollcall VALUES (3, 'C', 40);

DECLARE
  v_updated_count INT;
BEGIN
  UPDATE rollcall
  SET marks = 40
  WHERE marks BETWEEN 35 AND 39;

  v_updated_count := SQL%ROWCOUNT;

  IF v_updated_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No records updated');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Records Updated: ' || v_updated_count);
  END IF;
END;
/

INSERT INTO N_RollCall VALUES (1, 'A', 30);
INSERT INTO N_RollCall VALUES (2, 'B', 35);
INSERT INTO N_RollCall VALUES (3, 'C', 37);
