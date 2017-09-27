1. Find the most popular travel destination for users who live in California.

SELECT flights.destination_id
FROM flights JOIN itineraries ON (flights.id = itineraries.id)
JOIN tickets ON (itineraries.id = tickets.itinerary_id)
WHERE itineraries.user_id IN
  (SELECT users.id
  FROM users JOIN states ON (users.state_id = states.id)
  WHERE states.name = 'California');


2. How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.



3. Find the cheapest flight that was taken by a user who only had one itinerary.

SELECT user_id, COUNT(user_id) AS itinerary_count
FROM itineraries
WHERE itinerary_count = '1'
GROUP BY user_id;


4. Find the average cost of a flight itinerary for users in each state in 2012.
