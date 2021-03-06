--2

select substr(teacher_name ,1, regexp_instr(teacher_name, '\s', 1, 1) + 1)||'. '||
substr(regexp_substr(teacher_name,'\s\S',1, 2),2, 1)||'. ' as teachers, teacher as initials from teacher;

--3
DECLARE
CURSOR NUMBER_DAY IS SELECT FLOOR( MOD(EXTRACT(DAY FROM TEACHER.BIRTHDAY) 
        + EXTRACT(MONTH FROM TEACHER.BIRTHDAY) 
        + (6 + MOD(EXTRACT(YEAR FROM TEACHER.BIRTHDAY),100) + MOD(EXTRACT(YEAR FROM TEACHER.BIRTHDAY)/4,100) ),7) )RESULT, TEACHER.TEACHER_NAME FROM TEACHER ;
NUMBER_D NUMBER_DAY%ROWTYPE;
BEGIN
    FOR NUMBER_D IN NUMBER_DAY
    LOOP
        IF NUMBER_D.RESULT = 2
        THEN
            DBMS_OUTPUT.PUT_LINE('MONDAY: ' || NUMBER_D.TEACHER_NAME);
        END IF;
    END LOOP;
END;

SELECT * FROM TEACHER; 

--4
DROP VIEW NEXT_MONTH;
CREATE VIEW NEXT_MONTH 
AS SELECT * FROM TEACHER WHERE (EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE,2)) = EXTRACT(MONTH FROM TEACHER.BIRTHDAY)); 
SELECT * FROM NEXT_MONTH;

--5
DROP VIEW COUNT_PREP;
CREATE VIEW COUNT_PREP AS 
SELECT COUNT(*) COUNT FROM TEACHER WHERE EXTRACT(MONTH FROM TEACHER.BIRTHDAY) = 5;
SELECT * FROM COUNT_PREP;
 

--6
DECLARE 
CURSOR UBELIY IS SELECT TEACHER_NAME, BIRTHDAY FROM TEACHER WHERE MOD((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TEACHER.BIRTHDAY)),5)=0 
    OR MOD((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TEACHER.BIRTHDAY)),10)=0 ;
YEAR_ UBELIY%ROWTYPE;
BEGIN
    FOR YEAR_ IN UBELIY
    LOOP
        DBMS_OUTPUT.PUT_LINE(' ' || YEAR_.TEACHER_NAME || ' ' || YEAR_.BIRTHDAY);
    END LOOP;
END;

SELECT AVG(TEACHER.SALARY) FROM TEACHER;

--7
DECLARE 
    CURSOR AVARAGE(PULP TEACHER.PULPIT%TYPE) IS SELECT FLOOR(AVG(TEACHER.SALARY)) FROM TEACHER WHERE TEACHER.PUPLIT = PULP;
    ONE_SAL AVARAGE%TYPE;
BEGIN
FOR ONE_SAL IN AVARAGE('PAP')
LOOP
    DBMS_OUTPUT.PUT_LINE(ONE_SAL || ' ');
END LOOP;
END;

END;
SELECT * FROM TEACHER;
INSERT INTO TEACHER VALUES('MMM', 'MAG MOGOMED MAGOMEDOVICH', 'ISIT', '12.11.2021', 2500);
DELETE TEACHER WHERE TEACHER.TEACHER = 'MMM';
INSERT INTO TEACHER VALUES('MMM', 'MAG MOGOMED MAGOMEDOVICH', 'ISIT', '12.01.2021', 2500);
COMMIT;
--8
DECLARE
REC1 TEACHER%ROWTYPE;
TYPE ADDRESS IS RECORD(
    ADDRESS1 VARCHAR2(100),
    ADDRESS2 VARCHAR2(100),
    ADDRESS3 VARCHAR2(100)
);
TYPE PERSON IS RECORD(
    NAME_ TEACHER.TEACHER_NAME%TYPE,
    SALARY TEACHER.SALARY%TYPE,
    HOME_ADDRESS ADDRESS
);
REC2 PERSON;
BEGIN
    REC2.NAME_ := 'Smelov Vladimir Vladimirovich';
    REC2.SALARY := 2500;
    REC2.HOME_ADDRESS.ADDRESS1 := 'BELARUS';
    REC2.HOME_ADDRESS.ADDRESS2 := 'PINSK, BREST OBL';
    REC2.HOME_ADDRESS.ADDRESS3 := 'NABEREZNAY';
    DBMS_OUTPUT.PUT_LINE(REC2.NAME_ || ' ' || REC2.SALARY || ' ' || 
    REC2.HOME_ADDRESS.ADDRESS1 || ' ' || REC2.HOME_ADDRESS.ADDRESS2 || REC2.HOME_ADDRESS.ADDRESS3);
    EXCEPTION
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;