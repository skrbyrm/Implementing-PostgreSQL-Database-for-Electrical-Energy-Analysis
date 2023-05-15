CREATE OR REPLACE PROCEDURE public.proc_data_by_dates()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE data_by_dates;
  
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL daily_by_ssno(meterid);
      INSERT INTO data_by_dates SELECT * FROM temp_day;
  END LOOP;
END;
$procedure$
;
