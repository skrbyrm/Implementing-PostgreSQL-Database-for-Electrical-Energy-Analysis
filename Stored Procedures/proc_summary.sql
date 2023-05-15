CREATE OR REPLACE PROCEDURE public.proc_summary()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE summary; 
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL monthly_by_ssno(meterid);
      INSERT INTO summary SELECT * FROM temp_month LIMIT 1;
  END LOOP;
END;
$procedure$
;
