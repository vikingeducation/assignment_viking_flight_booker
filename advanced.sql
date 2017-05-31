-- 1. Find the most popular travel destination for users who live in California.
SELECT 
     COUNT(*), 
     -- some destinations have no city name attached
     CASE WHEN cities.name IS NULL THEN 'N/A'
     ELSE cities.name END AS city_name
     FROM users
     JOIN itineraries
       ON itineraries.user_id = users.id
     JOIN tickets
       ON tickets.itinerary_id = itineraries.id
     JOIN flights
       ON flights.id = tickets.flight_id
LEFT JOIN cities
       ON flights.destination_id = cities.id
   WHERE users.id = ANY (
      -- selects all usersfrom california and filters query for only those users
      SELECT users.id
          FROM users
          JOIN states
            ON users.state_id = states.id
         WHERE states.name = 'California')
 GROUP BY cities.name
 ORDER BY COUNT(*) DESC
    LIMIT 1
;

-- 2. How many flights have round trips possible? In other words, we want the count of all airports 
--    where there exists a flight FROM that airport and a later flight TO that airport.
SELECT COUNT(*)
  FROM flights x JOIN flights y
    ON y.destination_id = x.origin_id
 WHERE y.departure_time > x.arrival_time
;

-- One of these two, I'm not sure
SELECT COUNT(*)
    FROM flights x
   WHERE x.origin_id = ANY (
      SELECT y.destination_id
      FROM flights y
      WHERE y.departure_time > x.arrival_time
   )
;

-- 3. Find the cheapest flight that was taken by a user who only had one itinerary.

SELECT flights.id AS flight_id, price
     FROM users
     JOIN itineraries
       ON itineraries.user_id = users.id
     JOIN tickets
       ON tickets.itinerary_id = itineraries.id
     JOIN flights
       ON flights.id = tickets.flight_id
    WHERE username = ANY (
      -- this selects users with only 1 itinerary
      SELECT username
            FROM users
            JOIN itineraries
              ON itineraries.user_id = users.id
        GROUP BY username
          HAVING COUNT(itineraries.id) = 1
    )
    ORDER BY price
    LIMIT 1
;

-- 4. Find the average cost of a flight itinerary for users in each state in 2012.
SELECT states.name, AVG(price)
    FROM users
    JOIN itineraries
      ON itineraries.user_id = users.id
    JOIN tickets
      ON tickets.itinerary_id = itineraries.id
    JOIN flights
      ON tickets.flight_id = flights.id
    JOIN states
      ON states.id = users.state_id
      -- this should give us rows for every user's tickets
      -- then separate the users out by state
      -- and give us average for each state
GROUP BY states.name
ORDER BY states.name;