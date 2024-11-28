-- Write your SQL code here
START TRANSACTION;

UPDATE Flights
SET FlightStatus = 'Cancelled'
WHERE FlightNumber = 123;

UPDATE Bookings
SET BookingStatus = 'Cancelled'
WHERE FlightNumber = 123;

COMMIT;


START TRANSACTION;

UPDATE Bookings
SET RefundStatus = 'Refunded'
WHERE BookingID = 123;

INSERT INTO Refunds (BookingID, RefundAmount, RefundDate)
VALUES (123, 500, NOW());

COMMIT;

START TRANSACTION;

INSERT INTO Bookings (FlightNumber, PassengerID, SeatNumber, BookingDate)
VALUES (123, 456, '10A', NOW());

UPDATE Flights
SET AvailableSeats = AvailableSeats - 1
WHERE FlightNumber = 123;

COMMIT;