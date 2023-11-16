
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
