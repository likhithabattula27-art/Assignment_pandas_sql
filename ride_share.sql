
DROP TABLE IF EXISTS drivers_audit;
DROP TABLE IF EXISTS trips_audit;
DROP TABLE IF EXISTS vehicles_audit;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS drivers;

-- DRIVERS

CREATE TABLE drivers (
    driver_id   INT PRIMARY KEY,
    driver_name VARCHAR(50),
    city        VARCHAR(50),
    rating      DECIMAL(3,2)
);

CREATE TABLE drivers_audit (
    audit_id    INT PRIMARY KEY,
    driver_id   INT,
    action      VARCHAR(10),
    action_date DATE
);

INSERT INTO drivers (driver_id, driver_name, city, rating) VALUES
(1, 'John Smith',      'Charlotte', 4.80),
(2, 'Emma Davis',      'Atlanta',   4.20),
(3, 'Michael Brown',   'Dallas',    4.60),
(4, 'Sarah Wilson',    'Charlotte', 4.90),
(5, 'James Taylor',    'Atlanta',   3.90),
(6, 'Linda Moore',     'Dallas',    4.70),
(7, 'Robert Anderson', 'Charlotte', 4.10),
(8, 'Jessica Thomas',  NULL,        4.50),
(9, 'William Jackson', 'Atlanta',   4.85),
(10,'Jennifer White',  'Dallas',    4.30);


-- TRIPS

CREATE TABLE trips (
    trip_id    INT PRIMARY KEY,
    driver_id  INT,
    fare       DECIMAL(10,2),
    trip_type  VARCHAR(20),
    trip_date  DATE,
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

CREATE TABLE trips_audit (
    audit_id    INT PRIMARY KEY,
    trip_id     INT,
    action      VARCHAR(10),
    action_date DATE
);

INSERT INTO trips (trip_id, driver_id, fare, trip_type, trip_date) VALUES
(1, 1, 45.50,  'Regular', '2024-01-05'),
(2, 2, 72.00,  'Premium', '2024-01-06'),
(3, 3, 15.25,  'Pool',    '2024-01-06'),
(4, 1, 88.75,  'XL',      '2024-01-07'),
(5, 4, 33.00,  'Regular', '2024-01-07'),
(6, 5, 60.50,  'Premium', '2024-01-08'),
(7, 6, 25.00,  'Pool',    '2024-01-08'),
(8, 7, 95.00,  'XL',      '2024-01-09'),
(9, 8, 40.00,  'Regular', '2024-01-09'),
(10,9, 55.25,  'Premium', '2024-01-10'),
(11,10,18.00,  'Pool',    '2024-01-10'),
(12,2, 110.00, 'XL',      '2024-01-11'),
(13,3, 48.50,  'Regular', '2024-01-11'),
(14,4, 67.00,  'Premium', '2024-01-12'),
(15,5, 22.00,  'Pool',    '2024-01-12'),
(16,6, 99.00,  'XL',      '2024-01-13'),
(17,7, 30.00,  'Regular', '2024-01-13'),
(18,8, 58.00,  'Premium', '2024-01-14'),
(19,9, 20.00,  'Pool',    '2024-01-14'),
(20,10,85.00,  'XL',      '2024-01-15'),
(21,1, 42.00,  'Regular', '2024-01-15'),
(22,2, 64.00,  'Premium', '2024-01-16'),
(23,3, 27.50,  'Pool',    '2024-01-16'),
(24,4, 120.00, 'XL',      '2024-01-17'),
(25,5, 50.00,  'Regular', '2024-01-17');


-- VEHICLES

CREATE TABLE vehicles (
    vehicle_id   INT PRIMARY KEY,
    driver_id    INT,
    vehicle_type VARCHAR(20),
    vehicle_year INT,
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

CREATE TABLE vehicles_audit (
    audit_id    INT PRIMARY KEY,
    vehicle_id  INT,
    action      VARCHAR(10),
    action_date DATE
);

INSERT INTO vehicles (vehicle_id, driver_id, vehicle_type, vehicle_year) VALUES
(1, 1, 'Sedan',      2020),
(2, 2, 'SUV',        2019),
(3, 3, 'Hatchback',  2021),
(4, 4, 'Sedan',      2022),
(5, 5, 'SUV',        2018),
(6, 6, 'Hatchback',  2020),
(7, 7, 'Sedan',      2021),
(8, 8, 'SUV',        2023),
(9, 9, 'Hatchback',  2019),
(10,10,'Sedan',      2022);


SELECT * FROM drivers;
SELECT * FROM trips;
SELECT * FROM vehicles;


-- Part 3 - Data Exploration (SQL version)

-- Q1 display all drivers
SELECT * FROM drivers;

-- Q2 driver name and city
SELECT driver_name, city FROM drivers;

-- Q3 all trips
SELECT * FROM trips;

-- Q4 all vehicles
SELECT * FROM vehicles;

-- Q5 unique cities
SELECT DISTINCT city FROM drivers;

-- Q6 drivers from Charlotte
SELECT * FROM drivers WHERE city = 'Charlotte';

-- Q7 drivers with rating above 4.5
SELECT * FROM drivers WHERE rating > 4.5;

-- Q8 trips with fare above 50
SELECT * FROM trips WHERE fare > 50;

-- Q9 drivers from Charlotte or Atlanta
SELECT * FROM drivers WHERE city IN ('Charlotte', 'Atlanta');

-- Q10 drivers from Charlotte and rating above 4.5
SELECT * FROM drivers WHERE city = 'Charlotte' AND rating > 4.5;

-- Q11 drivers from Charlotte, Atlanta and Dallas
SELECT * FROM drivers WHERE city IN ('Charlotte', 'Atlanta', 'Dallas');

-- Q12 trips with fare between 20 and 80
SELECT * FROM trips WHERE fare BETWEEN 20 AND 80;

-- Q13 drivers whose names start with J
SELECT * FROM drivers WHERE driver_name LIKE 'J%';

-- Q14 drivers whose city is null
SELECT * FROM drivers WHERE city IS NULL;

-- Q15 sort drivers by rating descending
SELECT * FROM drivers ORDER BY rating DESC;

-- Q16 sort trips by fare descending
SELECT * FROM trips ORDER BY fare DESC;

-- Q17 top 5 highest fare trips
SELECT * FROM trips ORDER BY fare DESC LIMIT 5;

-- Q18 count drivers
SELECT COUNT(*) AS driver_count FROM drivers;

-- Q19 count trips
SELECT COUNT(*) AS trip_count FROM trips;

-- Q20 total revenue
SELECT SUM(fare) AS total_revenue FROM trips;

-- Q21 average fare
SELECT AVG(fare) AS average_fare FROM trips;

-- Q22 highest fare
SELECT MAX(fare) AS highest_fare FROM trips;

-- Q23 lowest fare
SELECT MIN(fare) AS lowest_fare FROM trips;

-- Q24 driver count by city
SELECT city, COUNT(*) AS driver_count
FROM drivers
GROUP BY city;

-- Q25 trip count by trip type
SELECT trip_type, COUNT(*) AS trip_count
FROM trips
GROUP BY trip_type;

-- Q26 total revenue by driver
SELECT driver_id, SUM(fare) AS total_revenue
FROM trips
GROUP BY driver_id;

-- Q27 average fare by trip type
SELECT trip_type, AVG(fare) AS avg_fare
FROM trips
GROUP BY trip_type;

-- Q28 maximum fare by trip type
SELECT trip_type, MAX(fare) AS max_fare
FROM trips
GROUP BY trip_type;

-- Q29 minimum fare by trip type
SELECT trip_type, MIN(fare) AS min_fare
FROM trips
GROUP BY trip_type;

-- Q30 drivers earning more than 200 revenue
SELECT driver_id, SUM(fare) AS total_revenue
FROM trips
GROUP BY driver_id
HAVING SUM(fare) > 200;

-- Q31 trip types with average fare above 40
SELECT trip_type, AVG(fare) AS avg_fare
FROM trips
GROUP BY trip_type
HAVING AVG(fare) > 40;

-- Q32 driver name and fare
SELECT d.driver_name, t.fare
FROM trips t
JOIN drivers d ON t.driver_id = d.driver_id;

-- Q33 driver name and trip type
SELECT d.driver_name, t.trip_type
FROM trips t
JOIN drivers d ON t.driver_id = d.driver_id;

-- Q34 driver name and vehicle type
SELECT d.driver_name, v.vehicle_type
FROM drivers d
JOIN vehicles v ON d.driver_id = v.driver_id;

-- Q35 driver name and vehicle year
SELECT d.driver_name, v.vehicle_year
FROM drivers d
JOIN vehicles v ON d.driver_id = v.driver_id;

-- Q36 driver name, vehicle type and fare
SELECT d.driver_name, v.vehicle_type, t.fare
FROM trips t
JOIN drivers d ON t.driver_id = d.driver_id
JOIN vehicles v ON d.driver_id = v.driver_id;

-- Q37 rating_bonus column
SELECT driver_name, rating, rating * 100 AS rating_bonus
FROM drivers;

-- Q38 platform_fee column = 10% of fare
SELECT trip_id, fare, fare * 0.10 AS platform_fee
FROM trips;

-- Q39 driver names uppercase
SELECT UPPER(driver_name) AS name_upper FROM drivers;

-- Q40 driver names lowercase
SELECT LOWER(driver_name) AS name_lower FROM drivers;

-- Q41 drivers whose names contain 'a'
SELECT * FROM drivers WHERE driver_name LIKE '%a%';

-- Q42 count null values in every column
SELECT
    SUM(CASE WHEN driver_name IS NULL THEN 1 ELSE 0 END) AS null_driver_name,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS null_rating
FROM drivers;

-- Q43 replace null cities with 'Unknown'
UPDATE drivers SET city = 'Unknown' WHERE city IS NULL;
SELECT * FROM drivers;

-- Q44 remove rows containing null values
DELETE FROM drivers WHERE city IS NULL OR driver_name IS NULL OR rating IS NULL;

-- Q45 rename driver_name to name
 ALTER TABLE drivers RENAME COLUMN driver_name TO name;

-- Q46 display 5 random drivers
SELECT * FROM drivers ORDER BY RANDOM() LIMIT 5;
