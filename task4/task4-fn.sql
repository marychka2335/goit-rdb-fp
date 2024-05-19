ALTER TABLE infectious_cases_normalized
ADD COLUMN init_date DATE NULL AFTER year,
ADD COLUMN tod_date DATE NULL AFTER init_date,
ADD COLUMN dif_year INT NULL AFTER tod_date;

DROP FUNCTION IF EXISTS fn_init_date;

DELIMITER //

CREATE FUNCTION fn_init_date(year INT)
RETURNS DATE
DETERMINISTIC
NO SQL
BEGIN 	
	DECLARE result Date;
    SET result = MAKEDATE(year, 1);
    RETURN result;
END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_tod_date;

DELIMITER //

CREATE FUNCTION fn_tod_date()
RETURNS DATE
DETERMINISTIC
NO SQL
BEGIN 
	DECLARE result DATE;
    SET result = CURDATE();
    RETURN result;
END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_dif_year;

DELIMITER //

CREATE FUNCTION fn_dif_year(tod_date DATE, init_date DATE)
RETURNS INT
DETERMINISTIC
NO SQL
BEGIN
	DECLARE result INT;
    SET result = YEAR(tod_date) - YEAR(init_date);
    RETURN result;
END //

DELIMITER ;

UPDATE infectious_cases_normalized
SET tod_date = fn_tod_date(),
init_date = fn_init_date(year),
dif_year = fn_dif_year(tod_date, init_date);