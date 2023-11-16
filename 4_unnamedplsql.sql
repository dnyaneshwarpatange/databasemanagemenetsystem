CREATE TABLE Borrower (
    Roll_no INT,
    SName VARCHAR(90),
    Date_of_Issue DATE,
    BName VARCHAR(90),
    Status VARCHAR(10)
);

INSERT INTO Borrower VALUES(1, 'AAA', TO_DATE('14-November-2022', 'DD-Month-YYYY'), 'Wings of Fire', 'I');
INSERT INTO Borrower VALUES(2, 'BBB', TO_DATE('12-December-2022', 'DD-Month-YYYY'), 'The Magic Tree', 'I');
INSERT INTO Borrower VALUES(3, 'CCC', TO_DATE('01-January-2023', 'DD-Month-YYYY'), 'Wizard of Ice', 'I');
INSERT INTO Borrower VALUES(4, 'DDD', TO_DATE('05-May-2023', 'DD-Month-YYYY'), 'Weep of History', 'I');
INSERT INTO Borrower VALUES(5, 'EEE', TO_DATE('09-September-2023', 'DD-Month-YYYY'), 'Call of the Forest', 'I');

CREATE TABLE Fine (
    Roll_no INT,
    CDate DATE,
    Amt NUMBER(10,2)
);

DECLARE
    DOI Borrower.Date_of_Issue%TYPE;
    rn Borrower.Roll_no%TYPE := 5;
    name Borrower.BName%TYPE := 'Call of the Forest';
    date_diff INT;
    invalid_rn EXCEPTION;
    fine NUMBER(10,2);
BEGIN
    IF rn <= 0 THEN
        RAISE invalid_rn;
    END IF;

    SELECT Date_of_Issue INTO DOI FROM Borrower WHERE Roll_no = rn AND BName = name;
    date_diff := SYSDATE - DOI;

    IF date_diff > 15 AND date_diff < 30 THEN
        fine := ((date_diff - 15) * 5);
    END IF;

    IF date_diff > 30 THEN
        fine := (15 * 5) + ((date_diff - 30) * 50);
    END IF;

    IF fine > 0 THEN 
        INSERT INTO Fine VALUES (rn, SYSDATE, fine);
    END IF;

    UPDATE Borrower SET Status = 'R' WHERE Roll_no = rn AND BName = name; 
EXCEPTION
    WHEN invalid_rn THEN DBMS_OUTPUT.PUT_LINE('Invalid Roll Number');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No data Found');
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('Too Many Rows (Duplication)');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error');
END;
/
