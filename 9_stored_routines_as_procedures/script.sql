-- Write your SQL code here
CREATE PROCEDURE BookFlight(
    IN p_flight_number INT,
    IN p_passenger_id INT,
    IN p_seat_number INT
)
BEGIN
  DECLARE available_seats INT;

  SELECT AvailableSeats INTO available_seats
  FROM Flights
  WHERE FlightNumber = p_flight_number;

  IF available_seats > 0 THEN
    START TRANSACTION;
    INSERT INTO Bookings (FlightNumber, PassengerID, SeatNumber, BookingDate)
    VALUES (p_flight_number, p_passenger_id, p_seat_number, NOW());
    UPDATE Flights
    SET AvailableSeats = AvailableSeats - 1
    WHERE FlightNumber = p_flight_number;
    COMMIT;
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Flight is fully booked.';
  END IF;
END;