CREATE TABLE public.data_by_dates (
	"date" timestamp NULL,
	active numeric(18, 2) NULL,
	inductive numeric(18, 2) NULL,
	capacitive numeric(18, 2) NULL,
	active_cons numeric(18, 2) NULL,
	inductive_cons numeric(18, 2) NULL,
	capacitive_cons numeric(18, 2) NULL,
	inductive_ratio numeric(18, 4) NULL,
	capacitive_ratio numeric(18, 4) NULL,
	penalized int4 NULL,
	ssno int4 NULL,
	userid int4 NULL
);