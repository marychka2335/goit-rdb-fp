DROP FUNCTION IF EXISTS fn_calc_dif;

DELIMITER //

CREATE FUNCTION fn_calc_dif(start_date DATE, end_date DATE)
RETURNS INT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result INT;
    SET result = TIMESTAMPDIFF(YEAR, start_date, end_date);
    RETURN result;
END //

DELIMITER ;

SELECT 
	fn_calc_dif(MAKEDATE(icn.Year, 1), CURDATE()) AS difference
FROM infectious_cases_normalized AS icn;