

-- Find the most popular travel destination for users who live in California.
SELECT count(users.id) as travelers, citiesDest.name as destination_city, statesDest.name as destination_state
FROM users
JOIN states userState
ON users.state_id = userState.id
JOIN itineraries
ON users.id = itineraries.user_id
JOIN tickets
ON tickets.itinerary_id = itineraries.id
JOIN flights
ON flights.id = tickets.flight_id
JOIN airports
ON flights.destination_id = airports.id
JOIN cities citiesDest
ON airports.city_id = citiesDest.id
JOIN states statesDest
ON airports.state_id = statesDest.id
WHERE userState.name = 'California'
GROUP BY destination_state, destination_city
ORDER BY travelers DESC;

-- How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.
SELECT COUNT(origin_id)
FROM (
  SELECT flights.origin_id as origin
  FROM flights
) AS origin_ids
JOIN flights
ON origin_ids.origin = flights.destination_id;

-- Find the cheapest flight that was taken by a user who only had one itinerary.
SELECT MIN(flights.price)
  FROM ( SELECT users.id
    FROM users
    JOIN itineraries
    ON itineraries.user_id = users.id
    GROUP BY users.id
    HAVING (count(itineraries) = 1)
  ) as single_itinerary_users
JOIN itineraries
ON single_itinerary_users.id = itineraries.user_id
JOIN tickets
ON tickets.itinerary_id = itineraries.id
JOIN flights
ON flights.id = tickets.flight_id;

-- Find the average cost of a flight itinerary for users in each state in 2012.
SELECT states.name, ROUND(AVG(flights.price)::numeric, 2) as average_flight
FROM users
JOIN states
ON users.state_id = states.id
JOIN itineraries
ON users.id = itineraries.user_id
JOIN tickets
ON tickets.itinerary_id = itineraries.id
JOIN flights
ON flights.id = tickets.flight_id
WHERE flights.departure_time BETWEEN '2012-01-01'::date AND '2012-12-31'::date
GROUP BY states.name
ORDER BY states.name;


-- Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. Note: This can be ~50 lines long but doesn't require any subqueries.
-- LIST

SELECT origin.price, states1.name as startingState, states2.name as middleState, states3.name as finalState
FROM flights origin
JOIN airports originAirport
ON originAirport.id = origin.origin_id
JOIN states states1
ON originAirport.state_id = states1.id AND states1.name = 'Oregon'
JOIN flights middleFlight
ON origin.destination_id = middleFlight.origin_id
JOIN airports middleAirport
ON middleAirport.id = middleFlight.origin_id
JOIN states states2
ON middleAirport.state_id = states2.id AND states2.name = 'Pennsylvania'
JOIN airports finalAirport
ON finalAirport.id = middleFlight.destination_id
JOIN states states3
ON finalAirport.state_id = states3.id AND states3.name = 'Arkansas'
WHERE
(origin.departure_time BETWEEN  '2013-05-6'::date AND '2013-06-17'::date
  AND
  (origin.distance + middleFlight.distance) <= 400)
GROUP BY origin.price, startingState, middleState, finalState
ORDER BY origin.price DESC;


-- Show the min price
SELECT MIN(origin.price)
FROM flights origin
JOIN airports originAirport
ON originAirport.id = origin.origin_id
JOIN states states1
ON originAirport.state_id = states1.id AND states1.name = 'Oregon'
JOIN flights middleFlight
ON origin.destination_id = middleFlight.origin_id
JOIN airports middleAirport
ON middleAirport.id = middleFlight.origin_id
JOIN states states2
ON middleAirport.state_id = states2.id AND states2.name = 'Pennsylvania'
JOIN airports finalAirport
ON finalAirport.id = middleFlight.destination_id
JOIN states states3
ON finalAirport.state_id = states3.id AND states3.name = 'Arkansas'
WHERE
(origin.departure_time BETWEEN  '2013-05-6'::date AND '2013-06-17'::date
  AND
  (origin.distance + middleFlight.distance) <= 400);




