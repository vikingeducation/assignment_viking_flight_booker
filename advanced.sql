-- Queries 3: Advanced

-- Find the most popular travel destination for users who live in California.
SELECT dest.long_name, COUNT(flights.destination_id)
FROM flights
JOIN airports orig ON flights.origin_id = orig.id
JOIN airports dest ON flights.destination_id = dest.id
WHERE flights.id IN (
	SELECT tickets.flight_id
	FROM tickets 
	JOIN itineraries ON tickets.itinerary_id = itineraries.id
	JOIN users ON itineraries.user_id = users.id
	JOIN states ON users.state_id = states.id
	WHERE states.name = 'California'
	)
GROUP BY 1
ORDER BY 2 DESC;


-- How many flights have round trips possible? 
-- In other words, we want the count of all airports where there exists 
-- a flight FROM that airport and a later flight TO that airport.
SELECT DISTINCT COUNT(flight1.id) 
FROM flights flight1
JOIN flights flight2 ON flight1.origin_id = flight2.destination_id
WHERE flight1.arrival_time < flight2.departure_time;


-- Find the cheapest flight that was taken by a user who only had one itinerary.
SELECT flights.id, flights.price
FROM itineraries
JOIN tickets ON itineraries.id = tickets.itinerary_id
JOIN flights ON flights.id = tickets.flight_id
GROUP BY flights.id
HAVING COUNT(itineraries.user_id) = 1
ORDER BY flights.price
LIMIT 1;


-- Find the average cost of a flight itinerary for users in each state in 2012.
SELECT states.name, ROUND(AVG(price)::numeric, 2)
FROM flights
JOIN airports ON flights.origin_id = airports.id
JOIN states ON airports.state_id = states.id
WHERE flights.arrival_time >= '2012-01-01' AND flights.arrival_time < '2013-01-01'
	AND flights.departure_time >= '2012-01-01' AND flights.departure_time < '2013-01-01'
GROUP BY 1
ORDER BY 1;



-- Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect 
-- Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. 
-- Note: This can be ~50 lines long but doesn't require any subqueries.
SELECT DISTINCT flights.id, flights.price
FROM flights
JOIN airports orig ON flights.origin_id = orig.id
JOIN airports dest ON flights.destination_id = dest.id
JOIN states orig_state ON orig.state_id = orig_state.id
JOIN states dest_state ON dest.state_id = dest_state.id
WHERE flights.departure_time > '2013-05-06' AND flights.departure_time < '2013-06-17'
  AND flights.distance <= 400 
  AND orig_state.name IN ('Oregon', 'Pennsylvania', 'Arkansas') 
  OR dest_state.name IN ('Oregon', 'Pennsylvania', 'Arkansas')
ORDER BY flights.price;