-- airports, users, cities, states, flights,


-- 1. Get a list of all users in California
SELECT *
FROM users
JOIN states ON (users.state_id = states.id)
WHERE states.name = 'California';

-- 2.Get a list of all airports in Kadeton


SELECT *
FROM airports
JOIN cities ON (cities.id = airports.city_id)
WHERE name = 'Kadenview';

3.

-- hansen.lawson@marvin.io

SELECT payment_method
FROM itineraries
JOIN users ON (itineraries.user_id = users.id)
WHERE users.email = 'hansen.lawson@marvin.io';
