-- Write your SQL code here
CREATE TRIGGER prevent_overbooking
BEFORE INSERT ON Bookings
FOR EACH ROW
BEGIN
  DECLARE v_available_seats INT;

  SELECT COUNT(*) INTO v_available_seats
  FROM Flights
  WHERE FlightNumber = NEW.FlightNumber;

  SELECT COUNT(*) INTO v_booked_seats
  FROM Bookings
  WHERE FlightNumber = NEW.FlightNumber;

  IF v_booked_seats >= v_available_seats THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Flight is fully booked.';
  END IF;
END;

CREATE TRIGGER log_flight_changes
AFTER UPDATE ON Flights
FOR EACH ROW
BEGIN
  IF OLD.FlightStatus <> NEW.FlightStatus THEN
    INSERT INTO FlightLogs (FlightNumber, OldStatus, NewStatus, Reason)
    VALUES (NEW.FlightNumber, OLD.FlightStatus, NEW.FlightStatus, NEW.DelayReason);
  END IF;
END;

CREATE TRIGGER update_passenger_status_on_cancellation
AFTER UPDATE ON Flights
FOR EACH ROW
BEGIN
  IF NEW.FlightStatus = 'Cancelled' THEN
    UPDATE Bookings
    SET BookingStatus = 'Cancelled'
    WHERE FlightNumber = NEW.FlightNumber;
  END IF;
END;

