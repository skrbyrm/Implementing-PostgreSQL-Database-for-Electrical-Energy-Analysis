
CREATE TABLE public.data_by_months (
	"date" timestamp NULL,
	active_cons numeric(18, 2) NULL,
	inductive_cons numeric(18, 2) NULL,
	capacitive_cons numeric(18, 2) NULL,
	inductive_ratio numeric(18, 4) NULL,
	capacitive_ratio numeric(18, 4) NULL,
	penalized bool NULL,
	ssno int8 NULL,
	userid int4 NULL
);