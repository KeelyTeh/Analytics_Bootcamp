select c.table_schema,
       c.table_name,
       c.column_name,
       case c.is_nullable
            when 'NO' then 'not nullable'
            when 'YES' then 'is nullable'
       end as nullable
from information_schema.columns c
join information_schema.tables t
     on c.table_schema = t.table_schema 
     and c.table_name = t.table_name
where c.table_schema not in ('pg_catalog', 'information_schema')
      and t.table_type = 'BASE TABLE' 
order by table_schema,
         table_name,
         column_name;
		 
SELECT * from store;		 