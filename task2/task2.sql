CREATE TABLE IF NOT EXISTS countries (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    country VARCHAR(64) NOT NULL UNIQUE,
    code VARCHAR(64) UNIQUE);
    
INSERT INTO
	countries (name, code)
SELECT
	Entity, Code
FROM infectious_cases
GROUP BY Entity, Code;

CREATE TABLE infectious_cases_normalized
AS SELECT * FROM infectious_cases;

ALTER TABLE infectious_cases_normalized
ADD id INT PRIMARY KEY AUTO_INCREMENT FIRST,
ADD country_id INT AFTER id,
ADD CONSTRAINT foreign_country_id FOREIGN KEY (country_id) REFERENCES countries(id);

UPDATE infectious_cases_normalized i, countries c 
SET i.country_id = c.id 
WHERE c.code = i.code;

ALTER TABLE infectious_cases_normalized
DROP COLUMN Entity,
DROP COLUMN Code;
