CREATE OR REPLACE PROCEDURE public.daily_by_ssno(IN meterid integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    active_cons numeric(18,2);
    inductive_cons numeric(18,2);
    capacitive_cons numeric(18,2);
    inductive_ratio numeric(18,4);
    capacitive_ratio numeric(18,4);
BEGIN
    -- Create temporary table to hold query result
	DROP TABLE IF EXISTS temp_day;
    CREATE TEMP TABLE temp_day AS 
   SELECT 
        q.date, 
        q.active,
        q.inductive,
        q.capacitive,
        q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS active_cons,
        q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS inductive_cons,
        q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) AS capacitive_cons,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS inductive_ratio,
        CASE 
            WHEN q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0) = 0 THEN 0 
            ELSE ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / (q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0))) * 100 ::numeric(18,4) 
        END AS capacitive_ratio,
        CASE 
            WHEN ((q.inductive - COALESCE(LAG(q.inductive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 20 
                  OR ((q.capacitive - COALESCE(LAG(q.capacitive) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0)) / NULLIF(q.active - COALESCE(LAG(q.active) OVER (PARTITION BY q.ssno ORDER BY q.date ASC), 0), 0)) * 100 >= 15 
            THEN 1 
            ELSE 0 
        END AS penalized,
        q.ssno,
        q.userid
    FROM (
        SELECT 
            firm_list.userid AS userid,
            firm_list.ssno AS ssno,
            MAX(c.date) AS date,
            MAX(c.active) AS active,
            MAX(c.inductive) AS inductive,
            MAX(c.capacitive) AS capacitive
        FROM            
            consumptions c
        INNER JOIN
            firm_list ON c.ssno = firm_list.ssno
        WHERE 
            firm_list.ssno = meterid
            AND date_trunc('day', c.date) >= current_date - interval '30 days'
        GROUP BY 
            date_trunc('day', c.date),
            firm_list.ssno, 
            firm_list.userid
    ) AS q
    ORDER BY 
        q.date DESC;
END;
$procedure$
;
