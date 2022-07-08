# pg_minmax_ext
minmax extension for Postgres

This extension shows minimum and maximum values in a column. 

Requirements:
```
yum install gcc -y
```

#### minmax--0.0.1.sql file 
```
CREATE OR REPLACE FUNCTION MINMAX(f_begin VARCHAR, f_end VARCHAR, f_btw VARCHAR)
   RETURNS VARCHAR 
   LANGUAGE plpgsql
  AS
$$
DECLARE 
f_min VARCHAR;
f_max VARCHAR;
f_result VARCHAR;
BEGIN
	SELECT MIN(val)::VARCHAR ,MAX(val)::VARCHAR into f_min, f_max 
	FROM (VALUES(5.2),(3.00013),(3.00012),(7),(9),(10),(7)) t(val);

	SELECT (f_begin || f_min || f_end || f_btw || f_begin || f_max || f_end) INTO f_result;
	RETURN f_result;
END;
$$
```

#### minmax.control file 
```
comment = 'PG minmax function'
default_version = '0.0.1'
relocatable = true
module_pathname = '$libdir/minmax'
````
#### Makefile
```
EXTENSION = minmax
DATA = minmax--0.0.1.sql

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
```

### Installation
```
cp minmax.control <pgshared_extension_location>
cp minmax--0.0.1.sql <pgshared_extension_location>
cd <Makefile location>
make -f Makefile 
make install
```

#### Create extension
```
postgres=# CREATE EXTENSION minmax;
CREATE EXTENSION
```

##### Examples
MINMAX function has 3 parameters; begin, end and between strings. It's configurable.

postgres=# SELECT MINMAX('(', ')', '->');
       MINMAX        
-----------------
 (3.00012)->(10)
(1 row)

postgres=# select MINMAX('<', '>', ' - ');
        MINMAX        
------------------
 <3.00012> - <10>
(1 row)
```


``` 
SELECT MINMAX('(', ')', '->');
SELECT MINMAX('<', '>', ' - ');
```
