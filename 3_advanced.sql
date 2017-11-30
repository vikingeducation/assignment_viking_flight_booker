-- Find the most popular travel destination for users who live in California.

state.name >> users.state_id >> itineraries.user_id >> tickets.itinerary_id | flight_id >> flights.id


select flights.destination_id, count(flights.id)
from flights
join tickets on(flights.id  = tickets.flight_id)
join itineraries on (tickets.itinerary_id = itineraries.id)
join users on (itineraries.user_id = users.id)
join states on(users.state_id = states.id)
where states.name = 'California'
group by flights.destination_id
order by count(flights.id) desc;


-- How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.

select *
from flights a
join flights b on(a.destination_id = b.origin_id AND b.destination_id = a.origin_id)
WHERE b.departure_time > a.arrival_time;

-- Find the cheapest flight that was taken by a user who only had one itinerary.

-- wrong answer, need to debug

select users.username, users.id, count(itineraries.user_id), MIN(price) as min
from flights join tickets on (tickets.flight_id = flights.id)
join itineraries on(itineraries.id = itinerary_id)
join users on (users.id  = itineraries.user_id)
group by users.id
having count(itineraries.user_id) = 1
order by MIN(price)
limit 1;

-- right answer


select users.first_name, users.last_name, flights.id  as flight_id, flights.price
from flights join tickets on (tickets.flight_id = flights.id)
join itineraries on(itineraries.id = itinerary_id)
join users on (users.id  = itineraries.user_id)
group by users.id, flights.id
having count(itineraries.user_id) = 1
order by price
limit 1;


-- Find the average cost of a flight itinerary for users in each state in 2012.

select states.name, AVG(flights.price)
from flights join tickets on (tickets.flight_id = flights.id)
join itineraries on (itineraries.id = tickets.itinerary_id)
join users on (users.id = itineraries.user_id)
join states on(states.id  = users.state_id)
group by states.name
order by states.name;

-- Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. Note: This can be ~50 lines long but doesn't require any subqueries.

-- No flights originating in Oregon, Pennsylvania or Arkansas during this 6 week period

select states.name, count(flights.id)
from flights
join airports on (flights.origin_id = airports.id)
join states on (states.id  = airports.state_id)
where distance < 400 AND departure_time BETWEEN '2013-05-06 00:00:00.000000' AND '2013-06-17 00:00:00.000000'
group by states.name;
