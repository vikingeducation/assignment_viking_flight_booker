-- 1. Find the top 5 most expensive flights that end in California.
SELECT price
    FROM flights
    JOIN airports
      ON flights.destination_id = airports.id
    JOIN states
      ON airports.state_id = states.id
   WHERE states.name = 'California'
ORDER BY price DESC
   LIMIT 5
;

-- 2. Find the shortest flight that username 'zora_johnson' took.
SELECT distance
    FROM users
    JOIN itineraries
      ON itineraries.user_id = users.id
    JOIN tickets
      ON tickets.itinerary_id = itineraries.id
    JOIN flights
      ON flights.id = tickets.flight_id
   WHERE users.username = 'arnold'
ORDER BY distance
   LIMIT 1
;

-- 3. Find the average flight distance for every city in California
flights > airports > state_id > group by city
SELECT cities.name AS departure_city, 
       ROUND(AVG(distance), 2) AS average_distance
    FROM flights
    JOIN airports 
      ON airports.id = flights.origin_id
    JOIN states
      ON airports.state_id = states.id
    JOIN cities
      ON airports.city_id = cities.id
   WHERE states.name = 'California'
GROUP BY cities.name
;

-- 4. Find the 3 users who spent the most money on flights in 2013
SELECT username, SUM(price) as total_spent_on_flights
    FROM users
    JOIN itineraries
      ON itineraries.user_id = users.id
    JOIN tickets
      ON tickets.itinerary_id = itineraries.id
    JOIN flights
      ON flights.id = tickets.flight_id
   WHERE tickets.created_at BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY username
ORDER BY total_spent_on_flights DESC
LIMIT 3
;

-- 5. Count all flights to OR from the city of Smithhaven that did not land in Delaware
SELECT COUNT(*)
    FROM flights
    WHERE origin_id = (
      -- Match origin ID with smithhaven
      SELECT cities.id
        FROM cities 
        WHERE name = 'Smithhaven'
    )
    AND destination_id != ALL (
      -- Selects all airports that are in Delaware
      SELECT airports.id
          FROM airports
          JOIN states
            ON airports.state_id = states.id
         WHERE states.name = 'Delaware'
    ) 
      -- Match destination id with delaware airports
    OR destination_id = (
      -- Match origin ID with smithhaven
      SELECT cities.id
        FROM cities 
        WHERE name = 'Smithhaven'
    )
    AND origin_id != ALL (
      -- Selects all airports that are in Delaware
      SELECT airports.id
          FROM airports
          JOIN states
            ON airports.state_id = states.id
         WHERE states.name = 'Delaware'
    ) 
;

-- 6. Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(distance), MIN(distance)
  FROM flights;