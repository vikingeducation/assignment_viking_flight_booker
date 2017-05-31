-- Find the top 5 most expensive flights that end in California.
SELECT flights.price
FROM airports
JOIN flights ON airports.id = flights.destination_id
WHERE airports.state_id =
          (  SELECT states.id
            FROM states
            WHERE states.name = 'California')
ORDER BY price DESC
LIMIT 5;

      price
      --------
       833.31
       830.35
       822.06
       796.65
        795.3
      (5 rows)

-- Find the shortest flight that username 'zora_johnson' took.
SELECT *
FROM users
JOIN itineraries ON users.id=itineraries.user_id
JOIN tickets ON tickets.itinerary_id=itineraries.id
JOIN flights ON flights.id=tickets.flight_id
WHERE users.username = 'zora_johnson'
ORDER BY flights.distance LIMIT 1;

      id  | city_id | state_id |   username   | first_name | last_name |          email           |         created_at         |         updated_at         |  id  | user_id | payment_method |         created_at         |         updated_at         |  id   | itinerary_id | flight_id |         created_at         |         updated_at         |  id   | origin_id | destination_id |       departure_time       |        arrival_time        | price |         created_at         |         updated_at         | airline_id | distance
      ------+---------+----------+--------------+------------+-----------+--------------------------+----------------------------+----------------------------+------+---------+----------------+----------------------------+----------------------------+-------+--------------+-----------+----------------------------+----------------------------+-------+-----------+----------------+----------------------------+----------------------------+-------+----------------------------+----------------------------+------------+----------
      2351 |   29604 |     1314 | zora_johnson | Krystel    | Senger    | senger.krystel@marvin.io | 2017-03-24 03:58:02.648845 | 2017-03-24 03:58:02.648845 | 3522 |    2351 | MasterCard     | 2017-03-24 04:14:29.088636 | 2017-03-24 04:14:29.088636 | 11847 |         3522 |     62664 | 2011-11-05 12:58:22.524947 | 2017-03-24 04:47:44.756311 | 62664 |     26027 |          24053 | 2011-03-11 11:49:53.207156 | 2011-03-11 18:19:53.207156 | 147.5 | 2017-03-24 04:05:48.780572 | 2017-03-24 04:05:48.780572 |        107 |      134
      (1 row)


-- Find the average flight distance for every city in California
SELECT AVG(flights.distance) AS avg_flight_distance
FROM airports
JOIN flights ON airports.id = flights.origin_id
WHERE airports.state_id =
          (  SELECT states.id
            FROM states
            WHERE states.name = 'California');

             avg_flight_distance
            ----------------------
             358.4193548387096774
            (1 row)

-- Find the 3 users who spent the most money on flights in 2013

SELECT users.username
FROM users
JOIN itineraries ON users.id=itineraries.user_id
JOIN tickets ON tickets.itinerary_id=itineraries.id
JOIN flights ON flights.id=tickets.flight_id
WHERE flights.departure_time BETWEEN '2013-01-01 00:00:00' AND '2013-12-31 23:59:59'
ORDER BY flights.price DESC
LIMIT 3;


-- Count all flights to OR from the city of Smithshire that did not land in Delaware
SELECT airports.id
FROM cities
JOIN airports ON cities.id=airports.city_id
WHERE airports.city_id =
(SELECT cities.id
FROM cities
WHERE cities.name = 'Smithshire');






-- Return the range of lengths of flights in the system(the maximum, and the minimum).
SELECT MAX(flights.distance) AS max_distance,
MIN(flights.distance) AS min_distance
FROM flights;

