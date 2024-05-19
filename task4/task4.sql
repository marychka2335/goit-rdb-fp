SELECT
		MAKEDATE(icn.YEAR, 1) AS initial_date,
		CURDATE() AS today_date,
    TIMESTAMPDIFF(YEAR, MAKEDATE(icn.YEAR, 1), CURDATE()) AS years_difference
FROM infectious_cases_normalized AS icn;