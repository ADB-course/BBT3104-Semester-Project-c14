-- Write your SQL code here
CREATE EVENT update_flight_status
ON SCHEDULE EVERY 5 MINUTE
DO
BEGIN
  DECLARE cur_flight CURSOR FOR
    SELECT FlightNumber
    FROM Flights
    WHERE DepartureDateTime BETWEEN NOW() AND NOW() + INTERVAL 1 DAY;

  OPEN cur_flight;

  FETCH cur_flight INTO v_flight_number;

  WHILE ROW_COUNT() > 0 DO
    -- Fetch real-time flight status for v_flight_number
    SET v_flight_status = /* Fetch status from external source */;
    SET v_actual_departure_time = /* Fetch actual departure time */;
    SET v_actual_arrival_time = /* Fetch actual arrival time */;
    SET v_delay_reason = /* Fetch delay reason */;

    UPDATE Flights
    SET FlightStatus = v_flight_status,
        ActualDepartureTime = v_actual_departure_time,
        ActualArrivalTime = v_actual_arrival_time,
        DelayReason = v_delay_reason
    WHERE FlightNumber = v_flight_number;

    -- Send notifications to passengers and staff
    CALL send_flight_status_notifications(v_flight_number, v_flight_status, v_delay_reason);

    FETCH cur_flight INTO v_flight_number;
  END WHILE;

  CLOSE cur_flight;
END;

CREATE EVENT send_check_in_reminders
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
  DECLARE cur_booking CURSOR FOR
    SELECT PassengerID, Email, PhoneNumber, FlightNumber
    FROM Bookings
    WHERE DepartureDateTime BETWEEN NOW() + INTERVAL 1 DAY AND NOW() + INTERVAL 2 DAY;

  OPEN cur_booking;

  FETCH cur_booking INTO v_passenger_id, v_email, v_phone_number, v_flight_number;

  WHILE ROW_COUNT() > 0 DO
    CALL send_check_in_email(v_email, v_flight_number);
    CALL send_check_in_sms(v_phone_number, v_flight_number);

    FETCH cur_booking INTO v_passenger_id, v_email, v_phone_number, v_flight_number;
  END WHILE;

  CLOSE cur_booking;
END;