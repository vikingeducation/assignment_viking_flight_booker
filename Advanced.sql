Find the most popular travel destination for users who live in California.

    SELECT COUNT(*), flight_state.name
    FROM users
    JOIN states user_state ON users.state_id = user_state.id
    JOIN itineraries ON users.id = itineraries.user_id
    JOIN tickets ON itineraries.id = tickets.itinerary_id
    JOIN flights ON tickets.flight_id = flights.id
    JOIN airports ON flights.destination_id = airports.id
    JOIN states flight_state ON airports.state_id = flight_state.id
    WHERE user_state.name = 'California'
    GROUP BY flight_state.name
    ORDER BY flight_state.name DESC
    LIMIT 1;



How many flights have round trips possible? In other words, we want the count of all airports where there exists a flight FROM that airport and a later flight TO that airport.
Find the cheapest flight that was taken by a user who only had one itinerary.
Find the average cost of a flight itinerary for users in each state in 2012.
Bonus: You're a tourist. It's May 6, 2013. Book the cheapest set of flights over the next six weeks that connect Oregon, Pennsylvania and Arkansas, but do not take any flights over 400 miles in distance. Note: This can be ~50 lines long but doesn't require any subqueries.