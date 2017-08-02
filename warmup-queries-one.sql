-- SELECT
--     first_name,
-- 		last_name,
-- 		states.name
--   FROM users
-- 	JOIN states
-- 	  ON states.id = users.state_id
--   WHERE states.name = 'California';

-- SELECT
--     long_name
-- 	FROM airports
-- 	JOIN cities
-- 	  ON cities.id = airports.city_id
-- 	WHERE cities.name = 'Klockoborough';

-- SELECT
--     payment_method
-- 	FROM itineraries
-- 	JOIN users
-- 	  ON users.id = itineraries.user_id
-- 	WHERE users.email = 'stoltenberg.luigi@satterfield.org';

-- SELECT
--     flights.price
-- 	FROM flights
-- 	JOIN airports
-- 	  ON airports.id = flights.origin_id
-- 	WHERE airports.long_name = 'Danielchester Probably International Airport';

-- SELECT DISTINCT
-- 		long_name,
-- 		code
-- 	FROM airports
-- 	JOIN (SELECT
-- 		    origin_id,
-- 		    destination_id
-- 			FROM airports
-- 			JOIN flights
-- 			  ON flights.origin_id = airports.id OR flights.destination_id = airports.id
-- 			WHERE airports.code = 'BXX') as bxx_ids
-- 	ON bxx_ids.origin_id = airports.id OR bxx_ids.destination_id = airports.id
-- 	WHERE airports.code != 'BXX';


SELECT
    airports.long_name as "Airport visited by this dude"
  FROM tickets
  JOIN flights
    ON tickets.flight_id = flights.id
  JOIN airports
    ON flights.destination_id = airports.id
  WHERE tickets.id in (
    SELECT
        tickets.id
      FROM tickets
    	JOIN itineraries on tickets.itinerary_id = itineraries.id
    	WHERE itineraries.user_id = (
    		  SELECT DISTINCT
    			    id
    				FROM users
    				WHERE first_name = 'Percival'
    				  AND last_name = 'Rempel'
    	)
    	  AND itineraries.created_at > make_date(2012, 1, 1)
  )
