DROP DATABASE fungsi_sp;
CREATE DATABASE fungsi_sp;
USE fungsi_sp;

DELIMITER ;;
CREATE FUNCTION luastanah(
	panjang SMALLINT,
	hasil VARCHAR(6),
	lebar SMALLINT
) RETURNS SMALLINT DETERMINISTIC
BEGIN
	RETURN
	CASE hasil
		WHEN 'luas' THEN panjang * lebar
	END;
END;;

DELIMITER ;

SELECT luastanah(10,'luas',5) AS luastanah;