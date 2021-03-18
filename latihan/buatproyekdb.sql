-- Lalu Lintas
CREATE DATABASE IF NOT EXISTS book1;

USE book1;

CREATE TABLE IF NOT EXISTS sheet1(
	saklar_lampu VARCHAR(3)
);

-- DROP
ALTER TABLE sheet1 DROP PRIMARY KEY; 

-- Mengedit 
ALTER TABLE sheet1 ADD PRIMARY KEY(saklar_lampu); 

-- Delete Data
DELETE FROM sheet1;

-- Masukkan Data dua record Langsung
INSERT INTO sheet1 (saklar_lampu) VALUES
	('ON'),
	('OFF');

-- Cara lama
-- INSERT INTO sheet1 VALUES
-- 	('OFF');

-- Pilih Table
-- SELECT saklar_lampu as 'Nama Saklar Lampu'  Tidak disarankan , 
-- 	   COUNT(saklar_lampu) as 'Status Saklar Lampu' 
-- FROM sheet1
-- GROUP BY saklar_lampu
-- ORDER BY saklar_lampu ASC;

SELECT saklar_lampu as 'Saklar Lampu',
		IF(saklar_lampu="ON","Nyala","Mati") AS STATUS_LAMPU
FROM sheet1;

-- Lalu Lintas
CREATE TABLE IF NOT EXISTS sheet2(
	lampu_lalulintas varchar(6)
);

DELETE FROM sheet2;

-- Edit Table
-- ALTER TABLE sheet2 ADD PRIMARY KEY (lampu_lalulintas)

INSERT INTO sheet2 (lampu_lalulintas) VALUES
		("Merah"),
		("Kuning"),
		("Hijau");

-- INSERT INTO sheet2 (lampu_lalulintas) VALUES
-- 		("Merah"),
-- 		("Kuning"),
-- 		("Hijau");

SELECT lampu_lalulintas AS LAMPU,
		IF(lampu_lalulintas="Merah","Berhenti",
			IF(lampu_lalulintas="Kuning",
				"Berhati-hati",
				"Berjalan"
				)
			) AS STATUS
FROM sheet2;

--  Pernikahan
-- TABEL STATUS PERNIKAHAN
CREATE TABLE IF NOT EXISTS pernikahan(
	nama VARCHAR(6),
	jenis_kelamin VARCHAR(6),
	status VARCHAR(7)
	-- keterangan VARCHAR(7)
);

DELETE FROM pernikahan;

INSERT INTO pernikahan VALUES
("Amin", "pria", "sendiri"),
("Rahman", "pria", "kawin"),
("Luki", "pria", "cerai"),
("Dea", "wanita", "sendiri"),
("Yani", "wanita", "kawin"),
("Amin", "pria", "sendiri"),
("Endah", "wanita", "cerai");


SELECT *,
IF(jenis_kelamin="pria",
	IF(status="sendiri","perjaka",
		IF(status="kawin","MENIKAH","DUDA")),
			IF(status="sendiri","PERAWAN",
				IF(status="kawin","MENIKAH","JANDA"))) AS keterangan
FROM pernikahan;


-- Warga
DROP TABLE warga;
CREATE TABLE IF NOT EXISTS warga(
	nama_warga VARCHAR(6),/* Menambahkan primary key tanpa AlTER,di pakai ketika awal membuat database */
	jnskel_warga VARCHAR(6),
	status_warga VARCHAR(7),
	PRIMARY KEY (nama_warga,jnskel_warga,status_warga)
);

-- ALTER TABLE warga DROP PRIMARY KEY; 
-- ALTER TABLE warga ADD PRIMARY KEY (nama_warga);

-- DROP TABLE warga; Menghapus table warga

INSERT INTO warga VALUES
	("Amin","Pria","Sendiri"),
	("Rahman","Pria","Kawin"),
	("Luki","Pria","Cerai"),
	("Dea","Wanita","Sendiri"),
	("Dea","Pria","Kawin"),
	("Dea","Pria","Cerai"),
	("Yani","Wanita","Kawin"),
	("Endah","Wanita","Cerai");

-- view
DROP VIEW vw_seluruh_warga;

CREATE VIEW vw_seluruh_warga AS 

SELECT nama_warga,
	   jnskel_warga,
	   status_warga,
	   IF(jnskel_warga="pria",
	   IF(status_warga="sendiri","perjaka",
	   IF(status_warga="kawin","menikah","duda")),
				IF(status_warga="sendiri","perawan",
				IF(status_warga="kawin","menikah","janda"))) AS Keterangan_IF,

CASE WHEN jnskel_warga = "Pria"
	THEN
		CASE WHEN status_warga = "Sendiri"
		THEN "Perjaka"
		ELSE
			CASE WHEN status_warga = "Kawin"
				THEN "Menikah"
				ELSE "Duda"
			END
		END
	ELSE
		CASE WHEN status_warga = "Sendiri"
				THEN "Perawan"
				ELSE
					CASE WHEN status_warga = "Kawin"
						THEN "Menikah"
						ELSE "Janda"
					END
		END
	END AS Keterangan_Case,

IF(jnskel_warga="Pria",
	CASE status_warga
		WHEN "Sendiri" THEN "Perjaka"
		WHEN "Kawin" THEN "Menikah"
		ELSE "Duda"
	END,

	CASE status_warga
		WHEN "Sendiri" THEN "Perawan"
		WHEN "Kawin" THEN "Menikah"
		ELSE "Janda"
	END
) AS Keterangan_IF_Case

FROM warga;
-- SELECT nama_warga
-- FROM vw_seluruh_warga;


DROP TABLE nilai;
CREATE TABLE nilai(
	nama_nilai varchar(12),
	teori_nilai TINYINT,
	praktek_nilai TINYINT,
	PRIMARY KEY (nama_nilai,teori_nilai,praktek_nilai)
);

INSERT INTO nilai VALUES
	("Amin","90","90"),
	("Rahman","80","80"),
	("Luki","70","70"),
	("Dea","50","50"),
	("Dea","50","49");

-- DROP VIEW vw_nilai_siswa_prosentase_TP;
CREATE VIEW vw_nilai_siswa_prosentase_TP AS
	SELECT nama_nilai,
		   teori_nilai,
		   teori_nilai*0.3 AS ProsenTeori,
		   praktek_nilai,
		   praktek_nilai*0.7 AS ProsenPraktek
	FROM nilai;

-- DROP VIEW vw_nilai_total;
CREATE VIEW vw_nilai_total AS
	SELECT nama_nilai,
		   teori_nilai,
		   ProsenTeori,
		   praktek_nilai,
		   ProsenPraktek,
		   ProsenTeori + ProsenPraktek AS vw_nilai_total
	FROM vw_nilai_siswa_prosentase_TP;

-- DROP VIEW vw_nilai_siswa_grade;
CREATE VIEW vw_nilai_siswa_grade AS
	SELECT nama_nilai,
		   teori_nilai,
		   ProsenTeori,
		   praktek_nilai,
		   ProsenPraktek,
		   vw_nilai_total,
	CASE
		WHEN vw_nilai_total > 90
			THEN  "A"
		WHEN vw_nilai_total > 80
			THEN "B"
		WHEN vw_nilai_total > 70
			THEN "C"
		WHEN vw_nilai_total > 60
			THEN "D"
		ELSE "E"
	END as Grade
	FROM vw_nilai_total;

-- DROP VIEW vw_nilai_siswa_keterangan;
CREATE VIEW vw_nilai_siswa_keterangan AS
	SELECT nama_nilai,
		   teori_nilai,
		   ProsenTeori,
		   praktek_nilai,
		   ProsenPraktek,
		   vw_nilai_total,
	CASE
		WHEN vw_nilai_total > 90
			THEN  "Kompeten"
		WHEN vw_nilai_total > 80
			THEN "Kompeten"
		WHEN vw_nilai_total > 70
			THEN "Kompeten"
		ELSE "Tidak Kompeten"
	END as Keterangan
	FROM vw_nilai_total;		

CREATE VIEW vw_nilai_siswa_ktrg AS
	SELECT nama_nilai,
		   teori_nilai,
		   ProsenTeori,
		   praktek_nilai,
		   ProsenPraktek,
		   vw_nilai_total,
	CASE
		WHEN vw_nilai_total > 90
			THEN  "Memuaskan"
		WHEN vw_nilai_total > 80
			THEN "Baik"
		WHEN vw_nilai_total > 70
			THEN "Cukup"
		WHEN vw_nilai_total >= 50
			THEN "Kurang"
		ELSE "Bloon"
	END as Ketrg
	FROM vw_nilai_total;	

CREATE VIEW vw_jumlah_grade AS
SELECT
	Grade AS NamaGrade,
	COUNT(Grade) AS JumlahSiswa
FROM vw_nilai_siswa_grade
-- WHERE Kompetensi = "K" and Keterangan = "Memuaskan"
GROUP BY Grade;


CREATE VIEW vw_jumlah_Komptensi AS
SELECT
	Keterangan AS NamaKompetensi,
	COUNT(Keterangan) AS JumlahSiswa
FROM vw_nilai_siswa_keterangan
-- WHERE Kompetensi = "K" and Keterangan = "Memuaskan"
GROUP BY Keterangan;


CREATE VIEW vw_jumlah_keterangan AS
SELECT
	Ketrg AS NamaKeterangan,
	COUNT(Ketrg) AS JumlahSiswa
FROM vw_nilai_siswa_ktrg
-- WHERE Kompetensi = "K" and Keterangan = "Memuaskan"
GROUP BY Ketrg;




