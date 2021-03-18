DROP DATABASE pns2;
CREATE DATABASE IF NOT EXISTS pns2;

USE pns2;

-- DROP TABLE pegawai2;
CREATE TABLE IF NOT EXISTS pegawai2(
	Nip varchar(18) PRIMARY KEY,
	Nama varchar(15)
);

DELIMITER ;;
CREATE PROCEDURE sp_ins_pegawai(
	m_nip_pegawai VARCHAR(18),
	nama_pgw VARCHAR(18)
)
BEGIN
	INSERT INTO pegawai2 VALUES
	(m_nip_pegawai,nama_pgw);
	SELECT m_nip_pegawai,nama_pgw
	FROM pegawai2;

END;;
DELIMITER ;

CALL sp_ins_pegawai("197209172005011002","M. Septiawan");
CALL sp_ins_pegawai("200901202015071004","M. N Dzakiy");
CALL sp_ins_pegawai("201507142019031002","M. N Dzaka");
CALL sp_ins_pegawai("201411142020102003","N. Tsalsa N");

ALTER TABLE pegawai2 ADD agama varchar(18); 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DROP PROCEDURE sp_ins_agama;
DELIMITER ;;
CREATE PROCEDURE sp_ins_agama(
	agama_sp VARCHAR(5),
	m_nip_agama VARCHAR(18)
)
BEGIN
	UPDATE pegawai2 SET agama = agama_sp WHERE Nip = m_nip_agama;
	SELECT Nip,Nama,agama
	FROM pegawai2;
END;;
DELIMITER ;

CALL sp_ins_agama("Islam","197209172005011002");
CALL sp_ins_agama("Islam","200901202015071004");
CALL sp_ins_agama("Islam","201507142019031002");
CALL sp_ins_agama("Islam","201411142020102003");

CREATE TABLE agama1 (
	kode_agama VARCHAR(1) PRIMARY KEY,
	nama_agama VARCHAR(11)
);

DELIMITER ;; 
CREATE PROCEDURE sp_ins_agamakuagama1(
	m_jml_agama TINYINT
)
BEGIN
	DECLARE ulang TINYINT;
	SET ulang = 1;
	WHILE ulang <= m_jml_agama DO
		INSERT INTO agama1 VALUES (CONVERT (ulang, CHAR),elt(ulang, 'Islam', 'Katholik', 'Protestan','Budha','Hindu','Kepercayaan'));
		SET ulang = ulang + 1;
	END WHILE;

	SELECT *
	FROM agama1;
END;;
DELIMITER ;

CALL sp_ins_agamakuagama1(6);

ALTER TABLE pegawai2 DROP agama;

ALTER TABLE pegawai2 ADD COLUMN kode_agama VARCHAR(1);

ALTER TABLE pegawai2 ADD CONSTRAINT fk_pegawai_2_agama FOREIGN KEY(kode_agama) REFERENCES agama1(kode_agama);


-- UPDATE pegawai2 SET kode_agama = '1' WHERE Nip = "197209172005011002";

DELIMITER ;;
CREATE PROCEDURE sp_ins_agama2(
	m_kode_agama VARCHAR(5),
	m_nip_agama VARCHAR(18)
)
BEGIN
	UPDATE pegawai2
	 	SET kode_agama = m_kode_agama 
	 	WHERE Nip = m_nip_agama;
	SELECT *
	FROM pegawai2;
END;;
DELIMITER ;

CALL sp_ins_agama2("1","197209172005011002");
CALL sp_ins_agama2("3","200901202015071004");
CALL sp_ins_agama2("2","201507142019031002");
CALL sp_ins_agama2("1","201411142020102003");

SELECT Nip,Nama,nama_agama FROM pegawai2, agama1 WHERE pegawai2.kode_agama = agama1.kode_agama;

CREATE VIEW vw_pgw AS
	SELECT Nip,
		   Nama,
		   nama_agama
	FROM pegawai2,agama1
	WHERE pegawai2.kode_agama = agama1.kode_agama and agama1.nama_agama = "Islam";

DELIMITER ;;
CREATE PROCEDURE sp_ins_agama_lain(
	m_nip_agama VARCHAR(18),
	m_nama_pgw VARCHAR(16),
	m_kode_agama VARCHAR(1)
)
BEGIN
	INSERT INTO pegawai2 VALUES
	(m_nip_agama,m_nama_pgw,m_kode_agama);
	SELECT *
	FROM agama1;
END;;
DELIMITER ;

CALL sp_ins_agama_lain('197209172005011004','Helena Simorangkir','2');
CALL sp_ins_agama_lain('197209172005011009','Joni Joni Yes papa','2');
CALL sp_ins_agama_lain('197209172005011008','Sonsss','2');

CREATE VIEW datapnsfinal AS
SELECT Nip,
	   Nama,
	   MID(Nip,7,2) AS tanggal_lahir,
	   DATE_FORMAT(CONCAT(SUBSTRING(Nip,1,4),"-",SUBSTRING(Nip,5,2),"-",SUBSTRING(Nip,7,2)),"%W,%e %M %Y") AS "Tanggal Lahir",
	   YEAR(CURDATE())-YEAR(LEFT(Nip,8)) AS Usia,
	   TIMESTAMPDIFF(YEAR,LEFT(Nip,8),CURDATE()) AS  Usia2,
	   DATE_FORMAT(CONCAT(SUBSTRING(Nip,9,4),"-",SUBSTRING(Nip,13,2),"-",SUBSTRING(Nip,7,2)),"%M %Y") AS "Tanggal Pengangkatan",
	   SUBSTRING(Nip,16,3) AS NoUrut,
	   IF(MID(Nip,15,1)="1","Pria","Wanita") AS Jenis_Kelamin,
 	   nama_agama
FROM pegawai2,agama1
WHERE pegawai2.kode_agama = agama1.kode_agama;
