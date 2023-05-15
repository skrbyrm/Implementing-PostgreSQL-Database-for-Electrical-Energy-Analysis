
CREATE OR REPLACE VIEW public.view_data_by_hours
AS SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    data_by_hours.date AS "Tarih",
    data_by_hours.active AS "Aktif",
    data_by_hours.inductive AS "Endüktif",
    data_by_hours.capacitive AS "Kapasitif",
    data_by_hours.active_cons AS "Aktif Tüketim",
    data_by_hours.inductive_cons AS "Endüktif Tüketim",
    data_by_hours.capacitive_cons AS "Kapasitif Tüketim"
   FROM data_by_hours
     JOIN firm_list ON data_by_hours.ssno = firm_list.ssno;