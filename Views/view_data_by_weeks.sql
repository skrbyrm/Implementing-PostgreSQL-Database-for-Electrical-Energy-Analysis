
CREATE OR REPLACE VIEW public.view_data_by_weeks
AS SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    data_by_weeks.date AS "Tarih",
    data_by_weeks.active_cons AS "Aktif Tüketim",
    data_by_weeks.inductive_cons AS "Endüktif Tüketim",
    data_by_weeks.capacitive_cons AS "Kapasitif Tüketim",
    data_by_weeks.inductive_ratio AS "End. Oran",
    data_by_weeks.capacitive_ratio AS "Kap. Oran",
    data_by_weeks.penalized AS "Ceza Durumu"
   FROM data_by_weeks
     JOIN firm_list ON data_by_weeks.ssno = firm_list.ssno
  ORDER BY data_by_weeks.penalized DESC;