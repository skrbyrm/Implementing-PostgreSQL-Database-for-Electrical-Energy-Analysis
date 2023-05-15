CREATE OR REPLACE PROCEDURE public.proc_data_by_months()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
  meterid integer;
BEGIN
  -- Create temporary table to hold all the data
  TRUNCATE TABLE data_by_months;
  
  -- Loop through each ssno in the firm_list table and call the daily_by_ssno procedure
  FOR meterid IN (SELECT ssno FROM firm_list) LOOP
      CALL monthly_by_ssno(meterid);
      INSERT INTO data_by_months SELECT * FROM temp_month;
  END LOOP;
END;
$procedure$
;
