-- Write your SQL code here
CREATE TABLE Flights (
    FlightNumber INT PRIMARY KEY,
    DepartureDateTime DATETIME NOT NULL,
    ArrivalDateTime DATETIME NOT NULL,
    DepartureAirportCode CHAR(3) NOT NULL,
    FOREIGN KEY (DepartureAirportCode) REFERENCES Airports(AirportCode)
);

CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

CREATE TABLE Airports (
    AirportCode CHAR(3) PRIMARY KEY,
    AirportName VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

