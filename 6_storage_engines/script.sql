-- Write your SQL code here
CREATE FUNCTION get_passenger_info(passenger_id INT)
RETURNS VARCHAR(255)
BEGIN
  DECLARE first_name VARCHAR(50);
  DECLARE last_name VARCHAR(50);

  SELECT FirstName, LastName
  INTO first_name, last_name
  FROM Passengers
  WHERE PassengerID = passenger_id;

  RETURN CONCAT(first_name, ' ', last_name);
END;