1. Find the top 5 most expensive flights that end in California.

SELECT *
FROM flights
WHERE flights.destination_id IN (
  SELECT airports.id
  FROM airports JOIN states ON (airports.state_id = states.id)
  WHERE states.name='California')
ORDER BY price DESC
LIMIT 5;

2. Find the shortest flight that username 'zora_johnson' took.

BROKEN

SELECT *
FROM flights
WHERE flights.id IN (
  SELECT tickets.flight_id
  FROM tickets JOIN itineraries ON (tickets.itinerary_id = itineraries.id)
  WHERE itineraries.user_id =
    (SELECT users.id
    FROM users
    WHERE users.username='brent'))
ORDER BY flights.distance
LIMIT 1;

3. Find the average flight distance for every city in California

SELECT cities.name, AVG(flights.distance)
FROM flights JOIN cities ON (flights.origin_id = cities.id)
WHERE flights.origin_id IN (
  SELECT airports.city_id
  FROM airports JOIN states ON (airports.state_id = states.id)
  WHERE states.name='California')
GROUP BY cities.name;

4. Find the 3 users who spent the most money on flights in 2013

SELECT itineraries.user_id, SUM(flights.price)
FROM itineraries JOIN tickets ON (itineraries.id = tickets.itinerary_id)
JOIN flights ON (flights.id = tickets.flight_id)
WHERE tickets.created_at > '2013-01-01 00:00:00' AND tickets.created_at < '2014-01-01 00:00:00'
GROUP BY itineraries.user_id
ORDER BY SUM(flights.price) DESC
LIMIT 3;

5. Count all flights to OR from the city of Smithshire that did not land in Delaware

BROKEN

SELECT COUNT(*)
FROM flights
WHERE flights.origin_id = 
  (SELECT cities.id
  FROM cities
  WHERE cities.name = 'Hyatttown');

6. Return the range of lengths of flights in the system(the maximum, and the minimum).

SELECT MIN(distance), MAX(distance)
FROM flights;
