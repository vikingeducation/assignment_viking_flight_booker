-- 1. Find the top 5 most expensive flights that end in California.
SELECT flights.id, flights.price
FROM flights JOIN airports
ON (flights.destination_id = airports.id)
JOIN states ON (airports.state_id = states.id)
WHERE states.name = 'California' ORDER BY flights.price DESC LIMIT 5;

-- 2. Find the shortest flight that username 'zora_johnson' took.
SELECT flights.id, flights.arrival_time - flights.departure_time as duration
FROM users JOIN itineraries ON (users.id = itineraries.user_id)
JOIN tickets ON (itineraries.id = tickets.itinerary_id)
JOIN flights ON (tickets.flight_id = flights.id)
WHERE users.id = (
    SELECT id FROM users
    WHERE users.first_name = SPLIT_PART('Kailee Little', ' ', 1)
    AND users.last_name = SPLIT_PART('Kailee Little', ' ', 2)
)
ORDER BY duration LIMIT 1;

-- 3. Find the average flight distance for every city in California
SELECT SUM(flights.arrival_time - flights.departure_time) / COUNT(*) as average
FROM flights JOIN airports
ON ((flights.origin_id = airports.id) OR (flights.destination_id = airports.id))
JOIN states ON (airports.state_id = states.id)
WHERE states.name = 'California';

-- 4. Find the 3 users who spent the most money on flights in 2013
SELECT users.first_name || ' ' || users.last_name as name,
SUM(flights.price) as total FROM users
JOIN itineraries ON (users.id = itineraries.user_id)
JOIN tickets ON (itineraries.id = tickets.itinerary_id)
JOIN flights ON (tickets.flight_id = flights.id)
WHERE flights.arrival_time BETWEEN '2013-01-01'::date AND '2013-12-12 23:59:59'::date
GROUP BY name ORDER BY total DESC LIMIT 3;
