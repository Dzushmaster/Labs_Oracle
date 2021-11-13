--2
create sequence s1
increment by 10
start with 1000
nomaxvalue 
nominvalue 
nocycle
nocache
noorder;

select s1.nextval, s1.currval from dual;
select s1.currval from dual;
select s1.nextval from dual;

--3
create sequence s2
increment by 10
start with 10
maxvalue 100
nocycle;

select s2.currval from dual;
select s2.nextval from dual;

--4

create sequence s3
increment by -10
start with 10
maxvalue 10
minvalue -100
nocycle
order;

select s3.nextval from dual;
select s3.currval from dual;

--5

create sequence s4
increment by 1
start with 1
maxvalue 10
cycle
cache 5
noorder;


select s4.nextval from dual;
select s4.currval from dual;

select * from sys.user_sequences;
select * from sys.all_sequences where sequence_owner = 'KDV';
-- select * from sys.dba_sequences where SEQUENCE_OWNER = 'KDV'; --only like sys or system
drop sequence s1;
drop sequence s2;
drop sequence s3;
drop sequence s4;


--6

create table T1 (N1 number(20), N2 number(20), N3 number(20), N4 number(20))
storage (buffer_pool keep)
tablespace Labs
cache;

insert into T1(N1, N2, N3, N4)
values(s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into T1
values(s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into T1
values(s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into T1
values(s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into T1
values(s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into T1
values(s1.nextval, s2.nextval, s3.nextval, s4.nextval);
insert into T1
values(s1.nextval, s2.nextval, s3.nextval, s4.nextval);
select * from T1;

--8
create cluster ABC --with hash type(200) and 2 ploes X number(10) v varchar21(12)
(
    X number(10),
    V varchar2(12)
)
hashkeys 200
tablespace Labs;

drop table A;
drop table B;
drop table C;

--9
create table A (XA number(10), VA varchar2(12), DA varchar2(10)) cluster ABC(XA, VA);

--10
create table B (XB number(10), VB varchar2(12), DB varchar2(10)) cluster ABC(XB, VB);

--11
create table C (XC number(10), VC varchar2(12), DC varchar2(10)) cluster ABC(XC, VC);

--12
--select * from dba_tables where tablespace_name = 'LABS';

--select dba_clusters.owner ClusterOwner , dba_clusters.cluster_name ClusterName
--, dba_tables.owner TablesOwner, dba_tables.table_name TablesName, dba_tables.cluster_name TablesClusterName
--from dba_tables join dba_clusters on dba_tables.cluster_name = dba_clusters.cluster_name where dba_clusters.cluster_name = 'ABC';

--select * from dba_clusters where tablespace_name = 'LABS';


--13
create synonym kdvCTable for KDV.C;
select * from kdvCTable;


--14
create public synonym  kdvBTable for KDV.B;
select * from kdvBTable;

--15
drop table A;
drop table B;

create table A (XA number(10) primary key, YA number(10)) tablespace Labs;
create table B (XB number(10), YB number(10), 
constraint constr foreign key(XB) references A(XA)) tablespace Labs;

insert into A
values(10,12);
insert into A
values(11,14);
insert into A
values(12,15);

insert into B
values(10, 45);
insert into B
values(11, 75);
insert into B
values(12, 95);

create or replace view V1
as select A.XA , A.YA, B.YB from A join B on A.XA = B.XB;

select * from V1;

--16

drop materialized view MV; --как создать в указанном tablespace

create materialized view MV
build immediate 
refresh complete on demand next sysdate +  NUMTODSINTERVAL(2, 'MINUTE')
as select A.XA , A.YA, B.YB from A join B on A.XA = B.XB;
select * from MV;

insert into A
values(14, 90);
insert into B
values(14, 90);
commit;