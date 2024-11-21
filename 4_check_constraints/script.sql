-- Write your SQL code here
CREATE TABLE Flights (
    FlightNumber INT PRIMARY KEY,
    DepartureDateTime DATETIME NOT NULL,
    ArrivalDateTime DATETIME NOT NULL,
    DepartureAirportCode CHAR(3) NOT NULL,
    ArrivalAirportCode CHAR(3) NOT NULL,
    FOREIGN KEY (DepartureAirportCode) REFERENCES Airports(AirportCode),
    FOREIGN KEY (ArrivalAirportCode) REFERENCES Airports(AirportCode), 1 
    CHECK (ArrivalDateTime > DepartureDateTime) -- Ensure arrival time is after departure time
) ENGINE=InnoDB
INDEX(DepartureDateTime), INDEX(ArrivalDateTime);

CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 0) -- Ensure age is non-negative
) ENGINE=InnoDB;
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    FlightNumber INT,
    PassengerID INT,
    SeatNumber INT,
    BookingDate DATETIME,
    FOREIGN KEY (FlightNumber) REFERENCES Flights(FlightNumber),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    CHECK (SeatNumber BETWEEN 1 AND (SELECT Capacity FROM Aircraft WHERE AircraftID = (SELECT AircraftID FROM Flights WHERE FlightNumber = Bookings.FlightNumber))) -- Ensure seat number is within aircraft capacity
) ENGINE=InnoDB;

CREATE TABLE Airports (
    AirportCode CHAR(3) PRIMARY KEY,
    AirportName VARCHAR(100) NOT NULL,
    Country VARCHAR(50) NOT NULL
) ENGINE=InnoDB;