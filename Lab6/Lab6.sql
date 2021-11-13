select sum(value) from v$sga;

select component, current_size, min_size, max_size, granule_size from v$sga_dynamic_components ;

select component, granule_size from v$sga_dynamic_components 
where component like '%pool';

select * from v$sga_dynamic_free_memory;

select * from v$sga_dynamic_components;
select sum(current_size) as default_cache, sum(min_size) as min_size, sum(max_size) as max_size from v$sga_dynamic_components where component like 'DEFAULT%';
select sum(current_size) as keep_cache, sum(min_size) as min_size, sum(max_size) as max_size from v$sga_dynamic_components where component like 'KEEP%';
select sum(current_size) as recycle_cache, sum(min_size) as min_size, sum(max_size) as max_size from v$sga_dynamic_components where component like 'RECYCLE%';

alter system set db_keep_cache_size = 16 ;
--alter system set db_recycle_cache_size = 0;
show parameter db_keep_cache_size;


create table XXX(k int)  storage(buffer_pool keep);
insert into XXX values(5);
drop table XXX;
select count(*) from XXX;
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name = 'XXX';

create table CCC (c int) cache storage(buffer_pool default);
insert into CCC values(10);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name = 'CCC';


select * from v$sgastat where name = 'log_buffer';
show parameter log_buffer;

select * from( select * from v$sgastat where pool = 'shared pool' order by bytes desc) where rownum<=10;

select component, max_size, current_size, min_size ,max_size-current_size as free_size from v$sga_dynamic_components where component = 'large pool';
show parameter large_pool_size;

select username, service_name, server from v$session where username is not null;

select * from (select owner, loads, executions, name from v$db_object_cache order by loads desc) where rownum <=15;
select * from (select owner, loads, executions, name from v$db_object_cache order by executions desc) where rownum <=15;
select * from v$db_object_cache  order by executions;
