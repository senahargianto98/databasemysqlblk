DROP DATABASE fungsi_sp;
CREATE DATABASE fungsi_sp;
USE fungsi_sp;

DELIMITER ;;
CREATE FUNCTION sp_kalkulator(
	m_bil_A SMALLINT,
	m_operator VARCHAR(6),
	m_bil_B SMALLINT
) RETURNS SMALLINT DETERMINISTIC
BEGIN
	RETURN
	CASE m_operator
		WHEN 'tambah' THEN m_bil_A + m_bil_B
		WHEN 'kurang'THEN m_bil_A - m_bil_B
		WHEN 'kali' THEN m_bil_A * m_bil_B
		ELSE m_bil_A / m_bil_B
	END;
END;;
DELIMITER ;

SELECT sp_kalkulator(10,'tambah',5) AS Kalkulator;