SET SERVEROUTPUT ON SIZE UNLIMITED
ALTER SESSION SET NLS_LANGUAGE= 'AMERICAN';

--1
begin
 null;
end;

--2
begin
 dbms_output.put_line('output');
end;

--3

declare 
    x number(3) :=3;
    y number(3) :=0;
    z number (10,2);
begin
    dbms_output.put_line('x = ' ||x|| ', y = ' || y);
    z := x / y;
    dbms_output.put_line('z = ' ||z);
    exception
        when others
        then dbms_output.put_line('error = '||sqlcode|| ': '||sqlerrm);
end;

--4

declare 
    x number(3) :=3;
    y number(3) :=0;
    z number (10,2);
begin
    dbms_output.put_line('x = ' ||x|| ', y = ' || y);
    begin
        z:= x/y;
        exception
        when others
        then dbms_output.put_line('error = '||sqlerrm);
    end;
dbms_output.put_line('z = ' ||z);
end;

--5 COMPILERS LIKE SYS
alter system set plsql_warnings = 'ENABLE:INFORMATIONAL';
select name, value from v$parameter where name = 'plsql_warnings';


--6 
select keyword from v_$reserved_words where length = 1;

--7
select keyword from v_$reserved_words where length > 1 order by keyword;

--8 or show parameters    like sysdba
select name, value from v$parameter;

--9
declare
    x number(3) := 3;
    y number(3) := 2;
    z number (10,2);
begin
    dbms_output.put_line('----------------------------------');
    begin
        dbms_output.put_line('x = ' ||x|| ', y = ' || y);
        z := x+y;
        dbms_output.put_line('x + y = ' ||z);
        z := x-y;
        dbms_output.put_line('x - y = ' ||z);
        z := x*y;
        dbms_output.put_line('x * y = ' ||z);
        z := mod(x,y);
        dbms_output.put_line('mod(x,y) = ' ||z);
    end;
    dbms_output.put_line('--------------- variables ------------------');
    declare 
    m number (10,-2) := 12345678.95;
    binFloat binary_float := 123456789.123456789111;
    binDouble binary_double := 123456789.123456789111;
    Enumber number(38,10) := 12345678E10;
    bool boolean := true;
    bool2 boolean:= false;
    begin
        z:= 12345678.95;
        dbms_output.put_line('z = ' ||z);
        dbms_output.put_line('m = ' ||m);
        dbms_output.put_line('binary_float = ' ||binFloat);
        dbms_output.put_line('binary_double = ' ||binDouble);
        dbms_output.put_line('number with E = ' ||Enumber);
        
        if bool
        then dbms_output.put_line('boolean = ' || 'true');
        end if;
        if not bool
        then dbms_output.put_line('boolean = ' || 'false');
        end if;
        
        if bool2
        then dbms_output.put_line('boolean2 = ' || 'true');
        end if;
        
        if not bool2
        then dbms_output.put_line('boolean2 = ' || 'false');
        end if;
    end;
end;
--10
dbms_output.put_line('--------------- constants -----------------');

declare 
 vch_ constant  varchar2(20) := 'Hello world!!';
 ch_ constant char(10) := 'Hi';
 num_ constant number(3) := 15;
begin
    dbms_output.put_line('varchar2 = ' || vch_);
    begin
        vch_ := 'Hi from world';
        exception 
            when others
                then dbms_output.put_line('error = ' || vch_);
    end;
    dbms_output.put_line('varchar2 = ' || vch_);
    
    dbms_output.put_line('char = ' || ch_);
    begin
        ch_ := 'Hello';
        exception 
            when others
                then dbms_output.put_line('error = ' || ch_);
    end;
    dbms_output.put_line('char = ' || ch_);
    
    dbms_output.put_line('number = ' || num_);
    begin
        num_ := 15;
        exception 
            when others
                then dbms_output.put_line('error = ' || num_);
    end;
    dbms_output.put_line('number = ' || num_);
end;

--11 %TYPE - скалярная ссылка
--12 %ROWTYPE - определения структуры переменной
dbms_output.put_line('--------------- %type/%rowtype -----------------');

declare 
    subject     kdv.subject.subject%type;
    faculty_rec kdv.faculty%rowtype;
begin
    subject := N'PIC';
    faculty_rec.faculty := N'IDiP';
    faculty_rec.faculty_name := N'Faculty of poligraphy';
    dbms_output.put_line(subject);
    dbms_output.put_line(rtrim(faculty_rec.faculty) || ':' || faculty_rec.faculty_name);
    exception
        when others
            then dbms_output.put_line('error = ' ||sqlerrm);
end;

--13 IF
dbms_output.put_line('--------------- IF -----------------');
declare 
 x pls_integer := 17;
begin
 if 8 > x
    then
    dbms_output.put_line('8>' || x);
 end if;
 
 if 8 > x
    then
    dbms_output.put_line('8 > ' || x);
 else
     dbms_output.put_line('8 <= ' || x);
 end if;
 
 if 8 > x
    then
    dbms_output.put_line('8 > ' || x);
 elsif 8 = x
    then
    dbms_output.put_line('8 = ' || x);
 else
    dbms_output.put_line('8 < ' || x);
 end if;
end;

--14 CASE
dbms_output.put_line('--------------- CASE -----------------');

declare
 x pls_integer := 17;
begin
    case x
        when 1 then dbms_output.put_line('1');
        when 2 then dbms_output.put_line('2');
        when 3 then dbms_output.put_line('3');
        else dbms_output.put_line('else');
    end case;
    
    case 
        when 8 > x then dbms_output.put_line('8 > ' || x);
        when 8 = x then dbms_output.put_line('8 = ' || x);
        when x between 13 and 20 then dbms_output.put_line('13 <= ' ||x|| ' <=20');
        else dbms_output.put_line('else');
    end case;
end;

--15 LOOP - WHILE - FOR
dbms_output.put_line('--------------- CYCLES -----------------');
declare
    x pls_integer := 0;
begin
    loop 
        x := x+1;
        dbms_output.put_line('loop :' ||x);
        exit when x > 4;
    end loop;
    
    for k in 1..5
    loop
        dbms_output.put_line('for: ' || k);
    end loop;
    
    while (x > 0)
    loop
        x:= x - 1;
        dbms_output.put_line('while: ' || x);
    end loop;
end;
    
 
 