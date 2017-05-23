1. Find the top 5 most expensive flights that end in California.
select id
from flights join airports on flights.destination_id = airports.id join states on airports.state_id = states.id
where states.name = California
order by flights.price DESC
limit 5;


2. Find the shortest flight that username 'zora_johnson' took.
select flights.id
from flights join tickets on flights.id = tickets.flight_id join itineraries on tickets.itinerary_id = itineraries.id join users on itineraries.user_id =users.id
 where users.username = 'zora_johnson'
 order by flights.distance
 limit 1;

3. Find the average flight distance for every city in California
select avg(flight.distance)
from flights join airports on flights.destination_id = airports.id join states on airports.state_id = states.id
where states.name = 'California'
group by states.name;

4. Find the 3 users who spent the most money on flights in 2013
select users.username
from users join itineraries on users.id = itineraries.user_id join tickets on itineraries.id = tickets.itinerary_id join flights on flights.id = tickets.flight_id
where yr = 2013
group by flights.price
limit 3;

5. Count all flights to OR from the city of Smithshire that did not land in Delaware
select count(flights)
from flights join airports on flights.origin_id = airports.id, flights.destination_id = airports.id
where flights.destination_id = (select airports.id
from airports join states on airports.state_id = states.id
where states.name = 'Delaware') AND
(flights.destination_id = (select airports.id
  from airports join cities on airports.city_id = cities.id
  where cities.name = 'Smithshire') OR
  flights.origin_id = (select airports.id
  from airports join cities on airports.city_id = cities.id
  where cities.name = 'Smithshire'));


6. Return the range of lengths of flights in the system(the maximum, and the minimum).
select max(distance), min(distance)
from flights
