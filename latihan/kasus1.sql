DROP DATABASE kasus1;
CREATE DATABASE kasus1;


CREATE TABLE pegawai(
	no_pegawai VARCHAR(30) PRIMARY KEY,
	nm_pegawai VARCHAR(20),
	jab_pegawai VARCHAR(20)
);

INSERT INTO pegawai VALUES
	('1','Agung','Senior Sales'),
	('2','Alfi','Junior Sales');

CREATE TABLE barang(
	kd_barang VARCHAR(30) PRIMARY KEY,
	stn_barang VARCHAR(20),
	nm_barang VARCHAR(20)
);

INSERT INTO barang VALUES
	('101','Unit','Kalkulator'),
	('102','Unit','Kursi Belajar'),
	('103','Unit','lampu Belajar'),
	('104','Unit','Meja Belajar');

CREATE TABLE pembeli(
	kd_pembeli VARCHAR(30) PRIMARY KEY,
	stn_pembeli VARCHAR(20),
	almt_pembeli VARCHAR(20)
);

INSERT INTO pembeli VALUES
	('10150','Toko Permata Indah','Jalan Mawar No.42, Yogyakarta'),
	('10251','Toko Buku Belajar Bersama','Jalan Ciganitri No.112, Lengkong, Bandung');