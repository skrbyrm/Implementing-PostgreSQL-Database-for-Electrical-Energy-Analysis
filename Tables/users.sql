
CREATE TABLE public.users (
	id serial4 NOT NULL,
	uuid varchar(255) NULL,
	"name" varchar(255) NULL,
	email varchar(255) NULL,
	"password" varchar(255) NULL,
	"role" varchar(255) NULL,
	createdat timestamp NULL,
	updatedat timestamp NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id)
);