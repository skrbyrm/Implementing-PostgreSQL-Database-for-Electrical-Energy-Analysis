# Implementing-PostgreSQL-Database-for-Electrical-Energy-Analysis
Designing and Implementing a PostgreSQL Database for Electrical Energy Analysis

This documentation provides an overview of the PostgreSQL database and explains the purpose and functionality of the tables, procedures, functions, triggers, and views used in the database.

## Scripts
```
├── Tables
│   ├── consumptions.sql
│   ├── data_by_dates.sql
│   ├── data_by_hours.sql
│   ├── data_by_months.sql
│   ├── data_by_weeks.sql
│   ├── firm_list.sql
│   ├── summary.sql
│   └── users.sql
├── Stored Procedures
│   ├── daily_by_ssno.sql
│   ├── hourly_by_ssno.sql
│   ├── monthly_by_ssno.sql
│   ├── proc_data_by_dates.sql
│   ├── proc_data_by_hours.sql
│   ├── proc_data_by_months.sql
│   ├── proc_data_by_weeks.sql
│   ├── proc_summary.sql
│   └── weekly_by_ssno.sql
├── Trıgger & Function
│   ├── function_cons_data.sql
│   └── trigger_data_insert.sql
└── Views
    ├── view_data_by_dates.sql
    ├── view_data_by_hours.sql
    ├── view_data_by_months.sql
    ├── view_data_by_weeks.sql
    └── view_summary.sql
```

## Tables
* `consumptions`
The consumptions table stores consumption data related to various attributes. It has the following columns:

  - `id` (serial4): Unique identifier for each consumption record.
  - `date` (timestamp): Date and time of the consumption.
  - `active` (float8): Active consumption value.
  - `inductive` (float8): Inductive consumption value.
  - `capacitive` (float8): Capacitive consumption value.
  - `hno` (int8): HNO attribute.
  - `ssno` (int8): SSNO attribute.
  - `facility_id` (int4): Facility ID attribute.
  - `createdat` (timestamp): Timestamp indicating when the record was created.
  - `updatedat` (timestamp): Timestamp indicating when the record was last updated.

## Procedures
  -  `monthly_by_ssno` 
  The monthly_by_ssno procedure calculates monthly consumption data based on a given `meterid (integer)`. It performs the following steps:

Creates a temporary table `temp_month` to hold the query result.
Calculates the difference in consumption values between consecutive months using the `LAG` function and stores the results in active_cons, inductive_cons, and capacitive_cons columns.
Calculates the ratios of inductive and capacitive consumption to active consumption and stores the results in inductive_ratio and capacitive_ratio columns.
Determines if a penalty is applicable based on certain conditions and sets the penalized column accordingly.
Retrieves additional attributes (ssno and userid) from the firm_list table.
Orders the results by date in descending order.

  -  `proc_data_by_months`
The proc_data_by_months procedure populates the data_by_months table with aggregated consumption data for each month. It performs the following steps:

Clears the data_by_months table by truncating its contents.
Iterates through each ssno in the firm_list table.
Calls the monthly_by_ssno procedure for each ssno to calculate monthly consumption data.
Inserts the results into the data_by_months table.

## Function
  - `trigger_cons_data`
The trigger_cons_data function is a trigger function that is executed after an INSERT operation on the consumptions table. It performs the following steps:

Checks if the trigger operation is an INSERT.
Calls the following procedures: proc_data_by_dates, proc_data_by_weeks, proc_data_by_months, proc_data_by_hours, and proc_summary.
# Trigger
  - `trigger_data_insert`
The trigger_data_insert trigger is associated with the consumptions table and fires after each INSERT operation. It executes the trigger_cons_data function, which triggers the data processing procedures.

## View 
  -  `view_data_by_months`
The view_data_by_months view combines data from the data_by_months and firm_list tables to provide a consolidated view of monthly consumption data. It includes the following columns:
