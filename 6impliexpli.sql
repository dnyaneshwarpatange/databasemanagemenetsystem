-- Create table rollcall
CREATE TABLE rollcall (
  rn INT,
  name VARCHAR(77),
  marks INT
);

-- Insert data into rollcall
INSERT INTO rollcall VALUES (5, 'P', 30);
INSERT INTO rollcall VALUES (1, 'A', 35);
INSERT INTO rollcall VALUES (4, 'D', 37);
INSERT INTO rollcall VALUES (3, 'C', 40);

-- Update marks in rollcall
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

-- Create table N_RollCall
CREATE TABLE N_RollCall (
  rn INT,
  name VARCHAR(77),
  marks INT
);

-- Insert data into N_RollCall
INSERT INTO N_RollCall VALUES (1, 'A', 30);
INSERT INTO N_RollCall VALUES (2, 'B', 35);
INSERT INTO N_RollCall VALUES (3, 'C', 37);

-- Copy data from rollcall to N_RollCall
DECLARE
  s_rec rollcall%ROWTYPE;
  CURSOR cur_o IS SELECT * FROM rollcall;
  CURSOR cur_n (rn_o INT) IS SELECT * FROM N_RollCall WHERE rn = rn_o;
BEGIN
  FOR s_rec IN cur_o
  LOOP
    OPEN cur_n(s_rec.rn);
    FETCH cur_n INTO s_rec;
    
    IF cur_n%NOTFOUND THEN
      INSERT INTO N_RollCall VALUES (s_rec.rn, s_rec.name, s_rec.marks);
    END IF;
    
    CLOSE cur_n;
  END LOOP;
END;
/
