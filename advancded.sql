1. Find the most popular travel destination for users who live in California.
select cities.name
from cities join airports on cities.id = airports.city_id join flights on airports.id = flights.destination_id join tickets on flights.id = tickets.flight_id join itineraries on tickets.itinerary_id = itineraries.id join users on itineraries.user_id = users.id
where users.state_id = (select states.id
from states
where states.name = 'California');

2. How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.
select airports.long_name
from airports join flights on airports.id = flights.destination_id, airports.id = flights.origin_id
where flights.arrival_time < flights.departure_time;


3. Find the cheapest flight that was taken by a user who only had one itinerary.
select flights.id
from flights join airports on airports.id = flights.destination_id join tickets on flights.id = tickets.flight_id join itineraries on tickets.itinerary_id = itineraries.id
where flights.price < all AND itineraries.user_id = 1;

4. Find the average cost of a flight itinerary for users in each state in 2012.
select avg(flights.price), state.name
from flights join airports on airports.id = flights.destination_id join state on airports.state_id = states.id
where created_at like '2012-%';


Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. Note: This can be ~50 lines long but doesn't require any subqueries.
