DROP DATABASE laravel;
CREATE DATABASE laravel;
CREATE TABLE percobaan(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Nama VARCHAR(50)
);

-- INSERT INTO percobaan VALUES
-- 	('1','Febrisena'),
-- 	('2','Gushinta Nena'),
-- 	('3','Julisadewa'),
-- 	('4','rispo ananta');
CREATE VIEW vw_pns AS
	SELECT Nama
	FROM percobaan;