SELECT *
FROM crime_scene_report
WHERE date=20180115 AND type='murder' and city='SQL City';
--Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

SELECT
*
FROM person
WHERE name LIKE '%Annabel%' AND address_street_name LIKE '%Franklin Ave%';
-- Annabel Miller 16371

SELECT *
FROM person
WHERE address_street_name LIKE '%Northwestern Dr%'
AND address_number =
(
SELECT MAX(address_number)
FROM person
WHERE address_street_name LIKE '%Northwestern Dr%'
)
-- Morty Schapiro 14887

SELECT
*
FROM interview
WHERE person_id IN (16371, 14887)

SELECT
t2.person_id,
t2.transcript
FROM 
(SELECT
*
FROM person
WHERE name LIKE '%Annabel%' AND address_street_name LIKE '%Franklin Ave%'
UNION ALL 
SELECT *
FROM person
WHERE address_street_name LIKE '%Northwestern Dr%'
AND address_number =
(
SELECT MAX(address_number)
FROM person
WHERE address_street_name LIKE '%Northwestern Dr%'
)) t1
INNER JOIN interview t2 ON t1.id = t2.person_id

-- I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

SELECT 
	t2.id,
	t2.name,
	t1.plate_number,
	t3.id AS GymId,
	t3.membership_status,
	t4.check_in_date,
    t5.transcript
FROM drivers_license t1
INNER JOIN person t2 ON t1.id = t2.license_id
INNER JOIN get_fit_now_member t3 ON t2.id = t3.person_id
INNER JOIN get_fit_now_check_in t4 ON t3.id = t4.membership_id
INNER JOIN interview t5 ON t2.id = t5.person_id
WHERE 
	t1.plate_number LIKE '%H42W%'
	AND t3.id LIKE '%48Z%'
	AND t4.check_in_date = 20180109
;
-- I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

SELECT
*
FROM drivers_license
WHERE car_model LIKE '%Model S%' 
--AND hair_color = 'red' and height BETWEEN 65 AND 67


SELECT person_id,
COUNT() AS NVeces
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert' 
AND date BETWEEN 20171201 AND 20171231
GROUP BY 1
HAVING COUNT() = 3;


SELECT t2.id,
t2.name,
t1.car_model,
t1.hair_color,
t1.height,
t3.NVeces
FROM (
SELECT
*
FROM drivers_license
WHERE car_model LIKE '%Model S%' 
--AND hair_color = 'red' and height BETWEEN 65 AND 67
) t1
INNER JOIN person t2 ON t1.id = t2.license_id
INNER JOIN (
SELECT person_id,
COUNT() AS NVeces
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert' 
AND date BETWEEN 20171201 AND 20171231
GROUP BY 1
HAVING COUNT() = 3) t3 ON t2.id = t3.person_id
-- 99716 Miranda Priestly



