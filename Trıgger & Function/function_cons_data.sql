CREATE OR REPLACE FUNCTION public.trigger_cons_data()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        PERFORM proc_data_by_dates();
        PERFORM proc_data_by_weeks();
        PERFORM proc_data_by_months();
        PERFORM proc_data_by_hours();
        PERFORM proc_summary();
    END IF;
    RETURN NEW;
END;
$function$
;
