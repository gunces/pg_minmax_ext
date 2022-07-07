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