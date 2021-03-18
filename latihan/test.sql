-- DROP VIEW vw_nilai;
-- CREATE VIEW vw_nilai AS 

-- SELECT nama_nilai as "Nama",
-- 	   teori_nilai as "Nilai Teori",
-- 	   teori_nilai*0.3 as "Nilai teori 30%",
-- 	   praktek_nilai  as "Nilai Praktek",
-- 	   praktek_nilai*0.7 as "Nilai Praktek 70%",
-- 	   teori_nilai*0.3 + praktek_nilai*0.7 as Total,

-- 	   CASE
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 90
-- 	   			THEN "A"
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 80
-- 	   			THEN "B"
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 70
-- 	   			THEN "C"
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 60
-- 	   			THEN "D"
-- 	   		ELSE "E"
-- 	   END as Grade,

-- 	   CASE
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 80
-- 	   			THEN "K"
-- 	   		ELSE "BK"
-- 	   END as Kompetensi,

-- 	   CASE
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 90
-- 	   			THEN "Memuaskan"
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 80
-- 	   			THEN "Baik"
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 70
-- 	   			THEN "Cukup"
-- 	   		WHEN teori_nilai*0.3 + praktek_nilai*0.7 > 60
-- 	   			THEN "Kurang Kompeten"
-- 	   		ELSE "Kurang Kompeten"
-- 	   END as Keterangan

-- FROM nilai;
