-- Write your SQL code here
CREATE VIEW AirportPerformance AS
SELECT 
    a.AirportCode,
    a.AirportName,
    AVG(TIMEDIFF(f.ActualArrivalTime, f.ScheduledArrivalTime)) AS AverageDelay,
    COUNT(*) AS TotalFlights,
    COUNT(CASE WHEN f.FlightStatus = 'On Time' THEN 1 ELSE NULL END) AS OnTimeFlights
FROM 
    Airports a
INNER JOIN Flights f ON a.AirportCode = f.DepartureAirportCode
GROUP BY 
    a.AirportCode, a.AirportName;


    CREATE VIEW HighRevenueFlights AS
SELECT 
    f.FlightNumber,
    SUM(b.Fare) AS TotalRevenue
FROM 
    Flights f
INNER JOIN Bookings b ON f.FlightNumber = b.FlightNumber
GROUP BY 
    f.FlightNumber
ORDER BY 
    TotalRevenue DESC
LIMIT 10;