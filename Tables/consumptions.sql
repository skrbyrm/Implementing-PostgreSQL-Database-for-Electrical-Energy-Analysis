
CREATE TABLE public.consumptions (
	id serial4 NOT NULL,
	"date" timestamp NULL,
	active float8 NULL,
	inductive float8 NULL,
	capacitive float8 NULL,
	hno int8 NULL,
	ssno int8 NULL,
	facility_id int4 NULL,
	createdat timestamp NULL,
	updatedat timestamp NULL,
	CONSTRAINT consumptions_pkey PRIMARY KEY (id)
);
