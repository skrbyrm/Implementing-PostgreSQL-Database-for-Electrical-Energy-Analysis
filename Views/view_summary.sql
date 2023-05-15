
CREATE OR REPLACE VIEW public.view_summary
AS SELECT firm_list.facility AS "Tesis",
    firm_list.district AS "İlçe",
    firm_list.service_point_number AS "Abone",
    summary.date AS "Tarih",
    summary.active_cons AS "Aktif Tüketim",
    summary.inductive_cons AS "Endüktif Tüketim",
    summary.capacitive_cons AS "Kapasitif Tüketim",
    summary.inductive_ratio AS "End. Oran",
    summary.capacitive_ratio AS "Kap. Oran",
    summary.penalized AS "Ceza Durumu"
   FROM summary
     JOIN firm_list ON summary.ssno = firm_list.ssno
  ORDER BY summary.penalized DESC;