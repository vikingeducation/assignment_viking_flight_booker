Find the top 5 most expensive flights that end in California.

    SELECT price, origin_id AS "ORIGIN", states.name AS "Destination"
    FROM flights
    JOIN airports ON flights.destination_id=airports.id
    JOIN states ON airports.state_id=states.id
    WHERE states.name = 'California'
    ORDER BY price DESC
    LIMIT 5;


Find the shortest flight that username 'zora_johnson' took.

    SELECT flights.id as "Flight ID", distance, username
    FROM users
    JOIN itineraries ON users.id = itineraries.user_id
    JOIN tickets ON itineraries.id = tickets.itinerary_id
    JOIN flights ON tickets.flight_id = flights.id
    WHERE username = 'zora_johnson'
    ORDER BY distance
    LIMIT 1;

Find the average flight distance for every city in California

    SELECT AVG(distance) AS "Average flight distance"
    FROM flights
    JOIN airports ON flights.origin_id=airports.id
    JOIN states ON airports.state_id=states.id
    JOIN cities ON airports.city_id=cities.id
    WHERE states.name = 'California';


-- Find the 3 users who spent the most money on flights in 2013

    SELECT username, SUM(price) AS total_price
    FROM users
    JOIN itineraries ON users.id = itineraries.user_id
    JOIN tickets ON itineraries.id = tickets.itinerary_id
    JOIN flights ON tickets.flight_id = flights.id
    WHERE tickets.created_at > '2013-01-01' AND tickets.created_at < '2013-12-31'
    GROUP BY username
    ORDER BY total_price DESC
    LIMIT 3;

-- Count all flights to OR from the city of Smithshire that did not land in Delaware

    SELECT COUNT(*) AS "Smithshire flights ex-Delaware"
    FROM flights
    JOIN airports origin_airport ON flights.origin_id=origin_airport.id
    JOIN airports destination_airport ON flights.destination_id=destination_airport.id
    JOIN states origin_state ON origin_airport.state_id=origin_state.id
    JOIN states destination_state ON destination_airport.state_id=destination_state.id
    JOIN cities origin_city ON origin_airport.city_id=origin_city.id
    JOIN cities destination_city ON destination_airport.city_id=destination_city.id
    WHERE destination_state.name != 'Delaware' AND (origin_city.name = 'Smithshire' OR destination_city.name = 'Smithshire');

-- Return the range of lengths of flights in the system(the maximum, and the minimum).

    SELECT MAX(distance) AS "Max Distance", MIN(distance) AS "Minimum Distance"
    FROM flights;







