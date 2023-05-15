
CREATE OR REPLACE VIEW public.view_data_by_dates
AS SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    data_by_dates.date AS "Tarih",
    data_by_dates.active AS "Aktif",
    data_by_dates.inductive AS "Endüktif",
    data_by_dates.capacitive AS "Kapasitif",
    data_by_dates.active_cons AS "Aktif Tüketim",
    data_by_dates.inductive_cons AS "Endüktif Tüketim",
    data_by_dates.capacitive_cons AS "Kapasitif Tüketim"
   FROM data_by_dates
     JOIN firm_list ON data_by_dates.ssno = firm_list.ssno;