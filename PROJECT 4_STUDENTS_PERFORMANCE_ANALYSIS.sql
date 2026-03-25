CREATE DATABASE STU;
USE STU;

CREATE TABLE stu_gp(
sex ENUM ('M', 'F'),
age INT NOT NULL,
address VARCHAR(50),
famsize VARCHAR(75),
pstatus VARCHAR (50),
medu INT CHECK (medu BETWEEN 0 AND 4),
fedu INT CHECK (fedu BETWEEN 0 AND 4),
mjob VARCHAR(50),
fjob VARCHAR(50),
reason VARCHAR(100),
guardian VARCHAR(50),
traveltime INT,
studytime INT,
failures INT,
schoolsup VARCHAR(75),
famsup VARCHAR (50),
paid VARCHAR (50),
activites VARCHAR(50),
nursery VARCHAR(50), 
higher VARCHAR(50),
internet VARCHAR(50),
famrel INT,
freetime INT,
goout INT,
dalc INT,
walc INT,
health INT,
absences INT,
G1 INT,
G2 INT,
G3 INT);



CREATE TABLE stu_ms(
sex ENUM ('M', 'F'),
age INT NOT NULL,
address VARCHAR(50),
famsize VARCHAR(75),
pstatus VARCHAR (50),
medu INT CHECK (medu BETWEEN 0 AND 4),
fedu INT CHECK (fedu BETWEEN 0 AND 4),
mjob VARCHAR(50),
fjob VARCHAR(50),
reason VARCHAR(100),
guardian VARCHAR(50),
traveltime INT,
studytime INT,
failures INT,
schoolsup VARCHAR(75),
famsup VARCHAR (50),
paid VARCHAR (50),
activites VARCHAR(50),
nursery VARCHAR(50), 
higher VARCHAR(50),
internet VARCHAR(50),
famrel INT,
freetime INT,
goout INT,
dalc INT,
walc INT,
health INT,
absences INT,
G1 INT,
G2 INT,
G3 INT);

SELECT * FROM stu_ms;

-- COMPARISION OF FINAL GRADES OF BOTH SCHOOLS
SELECT School, avg(G3) as average_grade_G3
FROM (
	SELECT G3, 'GP' AS School FROM stu_gp
    UNION ALL
    SELECT G3, 'MP' AS School FROM stu_ms
		) t
GROUP BY School;

-- COMPARISION BY ALCOHOL CONSUMPTION
SELECT alcohol_consumption, AVG(G3)
FROM (
		SELECT IF((DALC + WALC) >= 8, 'HIGH', IF((DALC + WALC) >= 5, 'MEDIUM', 'LOW')) AS alcohol_consumption, G3 FROM stu_gp
        UNION ALL
        SELECT IF((DALC + WALC) >= 8, 'HIGH', IF((DALC + WALC) >= 5, 'MEDIUM', 'LOW')) AS alcohol_consumption, G3 FROM stu_ms
        ) t
        GROUP BY alcohol_consumption;
        
-- COMPARISION OF GRADES ACROSS DIFFERENT STUDY TIME
SELECT studytime, avg(G1), avg(G2), avg(G3)
FROM (
		SELECT studytime, G1, G2, G3 FROM stu_gp
        UNION ALL
        SELECT studytime, G1, G2, G3 FROM stu_ms
        ) t
GROUP BY studytime
ORDER BY studytime ;

-- EFFECT OF FAMSUP ON FINAL GRADES
SELECT famsup, avg(G3)
FROM (
		SELECT famsup, G3 FROM stu_gp
        UNION ALL
        SELECT famsup, G3 FROM stu_ms
	) t
GROUP BY famsup;

-- COMPARISION OF ABSENCES AND FINAL GRADES
SELECT  school,avg(absences), avg(G3)
FROM (
		SELECT 'GP' as school,absences , G3 FROM stu_gp
        UNION ALL
        SELECT 'MS' AS school,absences  , G3 FROM stu_ms
        ) t
GROUP BY school;


-- COMPARISION OF STUDENT PERFORMANCE ON THE BASIS OF ADDRESS
SELECT school,address, avg(G3)
FROM (
		SELECT 'GP' AS school,address, G3 FROM stu_gp
        UNION ALL
        SELECT 'MS' AS school,address, G3 FROM stu_ms
        ) t
GROUP BY school,address;

-- COMPARISION OF STUDENT PERFORMANCE ON THE BASIS OF ACTIVITIES
SELECT school, activities, avg(G3)
FROM (
		SELECT 'GP' AS school, activities, G3 FROM stu_gp
        UNION ALL
        SELECT 'MS' AS school, activities, G3 FROM stu_ms
        ) t
GROUP BY school, activities;
