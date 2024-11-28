-- Write your SQL code here
CREATE DATABASE airport_system;
USE airport_system;

-- Create the tables
CREATE TABLE airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_name VARCHAR(50) NOT NULL,
    country VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE airports (
    airport_code CHAR(3) PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_id INT,
    flight_number INT,
    departure_airport CHAR(3),
    arrival_airport CHAR(3),
    departure_time DATETIME,
    arrival_time DATETIME,
    aircraft_id INT,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    FOREIGN KEY (departure_airport) REFERENCES airports(airport_code),
    FOREIGN KEY (arrival_airport) REFERENCES airports(airport_code)
) ENGINE=InnoDB
INDEX(departure_time), INDEX(arrival_time);

CREATE TABLE aircraft (
    aircraft_id INT PRIMARY KEY,
    aircraft_type VARCHAR(50),
    capacity INT
) ENGINE=InnoDB;

CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    passport_number VARCHAR(20) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT,
    flight_id INT,
    seat_number INT,
    booking_date DATETIME,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
) ENGINE=InnoDB;