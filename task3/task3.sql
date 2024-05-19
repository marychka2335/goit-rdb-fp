SELECT 
	id,
    MAX(number_rabies) AS max_num, MIN(number_rabies) AS min_num,
    AVG(number_rabies) AS avg_num, SUM(number_rabies) AS sum_num
FROM infectious_cases_normalized
WHERE number_rabies IS NOT NULL AND number_rabies <> ' '
GROUP BY id
ORDER BY avg_num DESC
LIMIT 10;