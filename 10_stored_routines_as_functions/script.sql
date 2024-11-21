-- Write your SQL code here
CREATE FUNCTION BookFlight(
    IN p_flight_number INT,
    IN p_passenger_id INT,
    IN p_seat_number INT
)
RETURNS BOOLEAN
BEGIN
  DECLARE available_seats INT;

  SELECT AvailableSeats INTO available_seats
  FROM Flights
  WHERE FlightNumber = p_flight_number;

  IF available_seats > 0 THEN
    INSERT INTO Bookings (FlightNumber, PassengerID, SeatNumber, BookingDate)
    VALUES (p_flight_number, p_passenger_id, p_seat_number, NOW());
    UPDATE Flights
    SET AvailableSeats = AvailableSeats - 1
    WHERE FlightNumber = p_flight_number;
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END;