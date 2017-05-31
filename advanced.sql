-- Find the most popular travel destination for users who live in California.
SELECT destination.long_name AS most_popular_destination,
       COUNT(flights.destination_id) AS total
  FROM flights
  -- airports
  JOIN airports destination
    ON flights.destination_id = destination.id
  -- tickets
  JOIN tickets
    ON flights.id = tickets.flight_id
  -- itineraries
  JOIN itineraries
    ON itineraries.id = tickets.itinerary_id
  -- users
  JOIN users
    ON users.id = itineraries.user_id
  JOIN states users_state
    ON users.state_id = users_state.id

  WHERE users_state.name = 'California'
  GROUP BY 1
  ORDER BY 2;

-- How many flights have round trips possible? In other words, we want the
-- count of all airports where there exists a flight FROM that airport and
-- a later flight TO that airport.
-- Mine:
SELECT COUNT(origin.id) AS round_trips
  FROM flights f1
  -- airports
  JOIN airports origin
    ON f1.origin_id = origin.id

  WHERE origin.id IN (
    SELECT f2.destination_id
      FROM flights f2
      --WHERE f2.arrival_time > f1.departure_time
  );

-- VCS:
SELECT
  COUNT(*) AS num_round_trip_flights
  FROM flights one
  JOIN flights two ON one.origin_id = two.destination_id
  WHERE one.arrival_time < two.departure_time
;

-- Find the cheapest flight that was taken by a user who only had one itinerary.
-- Mine:
SELECT MIN(flights.price) AS cheapest_flight
  FROM flights
  -- airports
  JOIN airports destination
    ON flights.destination_id = destination.id
  -- tickets
  JOIN tickets
    ON flights.id = tickets.flight_id
  -- itineraries
  JOIN itineraries
    ON itineraries.id = tickets.itinerary_id
  WHERE itineraries.user_id IN (
    SELECT user_id FROM itineraries
      GROUP BY user_id
      HAVING COUNT(user_id) = 1
  );

 -- VCS:
 SELECT * FROM flights
  WHERE id = (
    SELECT flights.id FROM itineraries
      JOIN tickets ON itineraries.id = tickets.itinerary_id
      JOIN flights ON flights.id = tickets.flight_id
      GROUP BY flights.id
      HAVING COUNT(itineraries.user_id) = 1
      ORDER BY flights.price
      LIMIT 1
  )
;

-- Find the average cost of a flight itinerary for users in each state in 2012.
SELECT states.name AS state_name,
       AVG(price) AS avg_cost
  FROM flights
  JOIN airports
    ON flights.origin_id = airports.id
  JOIN states
    ON airports.state_id = states.id
  GROUP BY 1
  ORDER BY 1;

-- Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights
-- over the next six weeks that connect Oregon, Pennsylvania and Arkansas,
-- but do not take any flights over 400 miles in distance. Note: This can be
-- ~50 lines long but doesn't require any subqueries.
SELECT flights.*
  FROM flights
  -- airports
  JOIN airports origin
    ON flights.origin_id = origin.id
  JOIN airports destination
    ON flights.destination_id = destination.id
  -- states
  JOIN states origin_state
    ON origin.state_id = origin_state.id
  JOIN states destination_state
    ON destination.state_id = destination_state.id
  WHERE
    -- between May 6, 2013 and the next six weeks
    flights.departure_time BETWEEN timestamp '2013-05-06' AND
                                   timestamp '2013-05-06' + interval '42 days'
    -- do not take any flights over 400 miles in distance
    AND flights.distance <= 400
    -- that connect Oregon, Pennsylvania and Arkansas
    AND origin_state.name IN ('Oregon', 'Pennsylvania', 'Arkansas') OR
        destination_state.name IN ('Oregon', 'Pennsylvania', 'Arkansas')
  ORDER BY flights.price;
