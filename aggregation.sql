Find the top 5 most expensive flights that end in California.

SELECT flights.price
FROM flights JOIN airports ON flights.destination_id=airports.id
JOIN states ON airports.state_id = states.id
WHERE states.name='California'
ORDER BY flights.price DESC
LIMIT 5

/*old stuff*/
SELECT flights.price
FROM flights
WHERE flights.destination_id=(/*subquery for id of airport*/)
ORDER BY flights.price DESC
LIMIT 5

/*subquery of airport id in CA*/
SELECT
FROM airports
WHERE airports.stat

/*subquery for destination_id of california*/
SELECT states.id
FROM states
WHERE states.name = 'California'



Find the shortest flight that username 'emelia' took.
SELECT MIN(flights.arrival_time - flights.departure_time)
FROM
users JOIN itineraries on users.id=itineraries.user_id
JOIN tickets on tickets.itinerary_id=itineraries.id
JOIN flights ON tickets.flight_id=flights.id
WHERE users.username = 'emelia'

Find the average flight distance for every city in California

SELECT AVG(flights.distance)
FROM
states JOIN airports ON states.id=airports.state_id
JOIN flights ON airports.id=flights.origin_id
WHERE states.name='California'

/*
SELECT AVG(flights.distance)
FROM
states JOIN airports ON states.id=airports.state_id
JOIN flights ON airports.id=flights.destination_id
WHERE states.name='California'
*/

Find the 3 users who spent the most money on flights in 2013

SELECT SUM(flights.price)
FROM
users JOIN itineraries ON users.id=itineraries.user_id
JOIN tickets ON tickets.itinerary_id=itineraries.id
JOIN tickets.flight
/*other joins to reach flight */
JOIN flights
GROUP BY users
ORDER BY SUM(flights.price) DESC
LIMIT 3

Count all flights to OR from the city of Smithshire that did not land in Delaware
Return the range of lengths of flights in the system(the maximum, and the minimum).
