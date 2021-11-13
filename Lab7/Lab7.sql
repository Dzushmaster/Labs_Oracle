--1
select count(*) from v$bgprocess;
select * from v$bgprocess ;

--2
select * from v$bgprocess where paddr!=hextoraw('00') order by name;--что за тип raw

--3

select paddr, name, description from v$bgprocess where name = 'DBWn';
select * from v$bgprocess where paddr!=hextoraw('00') and name = 'DBWn' order by name;

--4-5(9)
select addr from v$process;
select v$process.addr, v$session.paddr, v$session.username from v$process inner join v$session on v$process.addr = v$session.paddr where v$session.username is not null;
select * from v$session where username is not null;
select username, sid, serial#, server, paddr, status from v$session where username is not null;

--6

select name, network_name, pdb from v$services;
--7

show parameter dispatcher;
alter system set max_dispatchers = 10;
alter system set shared_servers= 3;
select * from v$shared_server;

--8


--9
--10
--11
--12
