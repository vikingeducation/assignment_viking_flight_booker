-- Find the most popular travel destination for users who live in California.

state.name >> users.state_id >> itineraries.user_id >> tickets.itinerary_id | flight_id >> flights.id


SELECT flights.destination_id, count(flights.id)
FROM flights
JOIN tickets ON(flights.id  = tickets.flight_id)
JOIN itineraries ON (tickets.itinerary_id = itineraries.id)
JOIN users ON (itineraries.user_id = users.id)
JOIN states ON(users.state_id = states.id)
WHERE states.name = 'California'
GROUP BY flights.destination_id
ORDER BY count(flights.id) desc;


-- How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.

SELECT *
FROM flights a
JOIN flights b ON(a.destination_id = b.origin_id AND b.destination_id = a.origin_id)
WHERE b.departure_time > a.arrival_time;

-- Find the cheapest flight that was taken by a user who only had one itinerary.

-- wrong answer, need to debug

SELECT users.username, users.id, count(itineraries.user_id), MIN(price) AS min
FROM flights JOIN tickets ON (tickets.flight_id = flights.id)
JOIN itineraries ON(itineraries.id = itinerary_id)
JOIN users ON (users.id  = itineraries.user_id)
GROUP BY users.id
HAVING count(itineraries.user_id) = 1
ORDER BY MIN(price)
LIMIT 1;

-- right answer


SELECT users.first_name, users.last_name, flights.id  AS flight_id, flights.price
FROM flights JOIN tickets ON (tickets.flight_id = flights.id)
JOIN itineraries ON(itineraries.id = itinerary_id)
JOIN users ON (users.id  = itineraries.user_id)
GROUP BY users.id, flights.id
HAVING count(itineraries.user_id) = 1
ORDER BY price
LIMIT 1;


-- Find the average cost of a flight itinerary for users in each state in 2012.

SELECT states.name, AVG(flights.price)
FROM flights JOIN tickets ON (tickets.flight_id = flights.id)
JOIN itineraries ON (itineraries.id = tickets.itinerary_id)
JOIN users ON (users.id = itineraries.user_id)
JOIN states ON(states.id  = users.state_id)
WHERE departure_time BETWEEN '2012-01-01 00:00:00.000000' AND '2013-01-01 00:00:00.000000'
GROUP BY states.name
ORDER BY states.name;

-- Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. Note: This can be ~50 lines long but doesn't require any subqueries.

-- No flights originating in Oregon, Pennsylvania or Arkansas during this 6 week period

SELECT states.name, count(flights.id)
FROM flights
JOIN airports ON (flights.origin_id = airports.id)
JOIN states ON (states.id  = airports.state_id)
WHERE distance < 400 AND departure_time BETWEEN '2013-05-06 00:00:00.000000' AND '2013-06-17 00:00:00.000000'
GROUP BY states.name;
