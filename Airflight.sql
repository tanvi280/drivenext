CREATE DATABASE AIRFLIGHT;

USE AIRFLIGHT;

CREATE TABLE airflight (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    airline VARCHAR(100) NOT NULL,
    flight_number VARCHAR(20) NOT NULL UNIQUE,
    departure_airport VARCHAR(50) NOT NULL,
    arrival_airport VARCHAR(50) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    status ENUM('Scheduled', 'Delayed', 'Departed', 'Arrived', 'Cancelled') DEFAULT 'Scheduled',
    capacity INT NOT NULL,
    booked_seats INT DEFAULT 0
);

INSERT INTO airflight 
(airline, flight_number, departure_airport, arrival_airport, departure_time, arrival_time, status, capacity, booked_seats) 
VALUES 
('American Airlines', 'AA101', 'JFK', 'LAX', '2025-02-05 08:00:00', '2025-02-05 11:00:00', 'Scheduled', 180, 120),
('Delta Airlines', 'DL202', 'ATL', 'ORD', '2025-02-06 10:00:00', '2025-02-06 12:30:00', 'Scheduled', 200, 150),
('United Airlines', 'UA303', 'SFO', 'DEN', '2025-02-07 13:00:00', '2025-02-07 15:15:00', 'Scheduled', 220, 180),
('Southwest Airlines', 'SW404', 'LAX', 'LAS', '2025-02-08 07:30:00', '2025-02-08 08:45:00', 'Delayed', 150, 130),
('JetBlue', 'JB505', 'MIA', 'JFK', '2025-02-09 09:45:00', '2025-02-09 12:30:00', 'Scheduled', 190, 160),
('Alaska Airlines', 'AS606', 'SEA', 'SFO', '2025-02-10 14:15:00', '2025-02-10 16:30:00', 'Scheduled', 175, 140),
('Spirit Airlines', 'SP707', 'DFW', 'ATL', '2025-02-11 11:00:00', '2025-02-11 13:30:00', 'Cancelled', 160, 0),
('Hawaiian Airlines', 'HA808', 'HNL', 'LAX', '2025-02-12 15:30:00', '2025-02-12 23:45:00', 'Scheduled', 240, 200),
('Frontier Airlines', 'FR909', 'DEN', 'ORD', '2025-02-13 06:30:00', '2025-02-13 09:15:00', 'Scheduled', 180, 100),
('Qatar Airways', 'QR1010', 'DOH', 'JFK', '2025-02-14 20:00:00', '2025-02-15 07:30:00', 'Departed', 250, 240),
('British Airways', 'BA111', 'LHR', 'ORD', '2025-02-15 18:00:00', '2025-02-15 21:00:00', 'Scheduled', 220, 180),
('Emirates', 'EK222', 'DXB', 'SFO', '2025-02-16 02:45:00', '2025-02-16 11:00:00', 'Scheduled', 260, 250),
('Lufthansa', 'LH333', 'FRA', 'JFK', '2025-02-17 14:00:00', '2025-02-17 17:30:00', 'Delayed', 230, 200),
('Singapore Airlines', 'SQ444', 'SIN', 'LAX', '2025-02-18 23:55:00', '2025-02-19 10:20:00', 'Scheduled', 300, 290),
('Air Canada', 'AC555', 'YYZ', 'MIA', '2025-02-19 12:15:00', '2025-02-19 15:00:00', 'Scheduled', 210, 180);

# CHECKING DATAINFORMATION
SELECT * from airflight;

# Group by cluase and also with having condition
SELECT airline, COUNT(*) AS total_flights 
FROM airflight 
GROUP BY airline;

SELECT airline, COUNT(*) AS total_flights 
FROM airflight 
GROUP BY airline 
HAVING COUNT(*) <= 2;

# Total Flights from Each Departure Airport:
SELECT departure_airport, COUNT(*) AS total_flights
FROM airflight
GROUP BY departure_airport;

# Average Capacity of Flights per Airline:
SELECT airline, AVG(capacity) AS avg_capacity
FROM airflight
GROUP BY airline;

# Flights with More Than 200 Seats:
SELECT airline, AVG(capacity) AS avg_capacity
FROM airflight
GROUP BY airline
HAVING AVG(capacity) > 200;

# Total Booked Seats per Airline:
SELECT airline, SUM(booked_seats) AS total_booked
FROM airflight
GROUP BY airline;

# Airlines with at Least 3 Flights Scheduled :
SELECT airline, COUNT(*) AS total_flights
FROM airflight
WHERE status = 'Scheduled'
GROUP BY airline
HAVING COUNT(*) >= 1;

SELECT * From airflight;

# Operation Perform using Date Functions:
SELECT flight_number, departure_time, 
       YEAR(departure_time) AS flight_year, 
       MONTH(departure_time) AS flight_month, 
       DAY(departure_time) AS flight_day
FROM airflight;

# Solve same based on Arrival_time
SELECT flight_number, arrival_time, 
       YEAR(arrival_time) AS flight_year, 
       MONTH(arrival_time) AS flight_month, 
       DAY(arrival_time) AS flight_day
FROM airflight;

# Find Flights Departing Today
SELECT * FROM airflight 
WHERE DATE(departure_time) = CURDATE();

SELECT * FROM airflight 
WHERE DATE(departure_time) = CURTIME();

SELECT * FROM airflight 
WHERE DATE(departure_time) = NOW();

# Find Flights Departing in the Next 7 Days:
SELECT * FROM airflight 
WHERE departure_time BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 7 DAY);

# Calculate Flight Duration 
SELECT flight_number, 
departure_time, 
arrival_time, 
TIMESTAMPDIFF(HOUR, departure_time, arrival_time) 
AS duration_hours
FROM airflight;

# Flights Departing in the Morning:
SELECT * FROM airflight 
WHERE HOUR(departure_time) BETWEEN 6 AND 12;

# Which airlines have the most booked seats?
SELECT airline, SUM(booked_seats) AS total_booked_seats
FROM airflight
GROUP BY airline
ORDER BY total_booked_seats DESC;

# How many flights are scheduled for each departure date?
SELECT DATE(departure_time) AS departure_date, COUNT(*) AS total_flights
FROM airflight
GROUP BY departure_date
ORDER BY departure_date;

# What is the flight with the maximum delay?
SELECT flight_id, flight_number, TIMESTAMPDIFF(MINUTE, departure_time, arrival_time) AS flight_delay
FROM airflight
WHERE status = 'Delayed'
ORDER BY flight_delay DESC
LIMIT 10,1;

# How many flights depart from each airport in the next 30 days?
SELECT departure_airport, COUNT(*) AS total_flights
FROM airflight
WHERE departure_time BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 30 DAY)
GROUP BY departure_airport;
                                        