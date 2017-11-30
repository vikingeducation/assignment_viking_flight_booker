-- Queries 2: Adding in Aggregation

-- Find the top 5 most expensive flights that end in California.

select * from flights join states ON(states.id  = destination_id) where states.name = 'California' order by price DESC limit 5;

-- Find the shortest flight that username 'emelia' took.

select * from flights JOIN tickets ON flights.id=tickets.flight_id where itinerary_id = 291 order by (flights.arrival_time - flights.departure_time) limit 1;

-- Find the average flight distance for every city in California

select * from airports join states on (state_id = states.id) where states.name = 'California';

select cities.name, AVG(distance)
from airports join states on (states.id  = state_id)
join flights on (flights.destination_id = airports.id  OR flights.origin_id = airports.id)
join cities ON (cities.id  = city_id)
where states.name  = 'California'
group by cities.name;

-- Find the 3 users who spent the most money on flights in 2013

users.id -> itinearies.id -> tickets.flight_id -> flights.price

SELECT username, price FROM users JOIN itineraries ON (users.id = itineraries.id) JOIN tickets on (users.itinerary_id = tickets.itinerary_id) JOIN flights on (tickets.flight_id = flights.id) group by users.username  order by sum(price) desc  limit 3;

select users.username, sum(price)
from flights join tickets ON(flights.id = tickets.flight_id)
join itineraries on(itineraries.id = tickets.itinerary_id)
join users ON (users.id = itineraries.user_id)
group by users.username
order by sum(price) desc
limit 3;
 select * from cities where name='Smithshire';

-- Count all flights to OR from the city of Smithshire that did not land in Delaware

select * from cities join airports on (cities.id = airports.id) join flights on ()

city_id -> airpots.city_id (to get airports) -> flights (connecting origin & destination)

-- Return the range of lengths of flights in the system(the maximum, and the minimum).

select min(arrival_time - departure_time), max(arrival_time - departure_time) from flights;
