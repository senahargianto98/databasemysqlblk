CREATE DATABASE IF NOT EXISTS pns;

USE pns;

DROP TABLE pegawai;
CREATE TABLE IF NOT EXISTS pegawai(
	Nip varchar(18) PRIMARY KEY,
	Nama varchar(15)
);

INSERT INTO pegawai VALUES
	("197209172005011002","M. Septiawan"),
	("198201312010052001","Damayanti"),
	("200901202015071004","M. N Dzakiy"),
	("201507142019031002","M. N Dzaka"),
	("201411142020102003","N. Tsalsa N");

DROP VIEW vw_pns;
CREATE VIEW vw_pns AS
	SELECT Nip,
		   Nama,
		   DATE_FORMAT(CONCAT(SUBSTRING(Nip,1,4),"-",SUBSTRING(Nip,5,2),"-",SUBSTRING(Nip,7,2)),"%W,%e %M %Y") AS "Tanggal Lahir",
		   DATE_FORMAT(CONCAT(SUBSTRING(Nip,9,4),"-",SUBSTRING(Nip,13,2),"-",SUBSTRING(Nip,7,2)),"%M %Y") AS "Tanggal Pengangkatan",
		   SUBSTRING(Nip,16,3) AS NoUrut,
		   IF(MID(Nip,15,1)="1","Pria","Wanita") AS Jenis_Kelamin
	FROM pegawai;