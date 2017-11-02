-- CREATE TABLE airlines (
--     id integer NOT NULL,
--     name character varying NOT NULL,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone
-- );

-- CREATE TABLE airports (
--     id integer NOT NULL,
--     city_id integer NOT NULL,
--     state_id integer NOT NULL,
--     code character varying NOT NULL,
--     long_name character varying NOT NULL,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone
-- );

-- CREATE TABLE cities (
--     id integer NOT NULL,
--     name character varying NOT NULL,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone
-- );

-- CREATE TABLE flights (
--     id integer NOT NULL,
--     origin_id integer NOT NULL,
--     destination_id integer NOT NULL,
--     departure_time timestamp without time zone NOT NULL,
--     arrival_time timestamp without time zone NOT NULL,
--     price double precision NOT NULL,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone,
--     airline_id integer NOT NULL,
--     distance integer NOT NULL
-- );

-- CREATE TABLE itineraries (
--     id integer NOT NULL,
--     user_id integer NOT NULL,
--     payment_method character varying NOT NULL,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone
-- );

-- CREATE TABLE states (
--     id integer NOT NULL,
--     name character varying NOT NULL,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone
-- );

-- CREATE TABLE tickets (
--     id integer NOT NULL,
--     itinerary_id integer,
--     flight_id integer,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone
-- );

-- CREATE TABLE users (
--     id integer NOT NULL,
--     city_id integer NOT NULL,
--     state_id integer NOT NULL,
--     username character varying NOT NULL,
--     first_name character varying NOT NULL,
--     last_name character varying NOT NULL,
--     email character varying NOT NULL,
--     created_at timestamp without time zone,
--     updated_at timestamp without time zone
-- );








-- Get a list of all users in California
SELECT concat_ws(' ', first_name::text, last_name::text) 
  FROM users 
  JOIN states 
  ON users.state_id = states.id 
  WHERE states.name = 'California';

-- Get a list of all airports in Gwendolynfort
SELECT long_name 
FROM airports 
JOIN cities 
ON airports.city_id = cities.id 
WHERE cities.name = 'Gwendolynfort';

-- Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'
SELECT payment_method
FROM itineraries 
JOIN users 
ON itineraries.user_id = users.id 
WHERE users.email = 'kallie.weimann@dach.biz';

-- Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.
SELECT price 
FROM flights 
JOIN airports 
ON flights.origin_id = airports.id 
WHERE airports.long_name = 'Port Gerardbury Probably International Airport';

-- Find a list of all Airport names and codes which connect to the airport coded ZAM.
SELECT DISTINCT dest.long_name, dest.code
FROM flights
JOIN airports orig ON flights.origin_id = orig.id
JOIN airports dest ON flights.destination_id = dest.id
WHERE orig.code = 'ZAM' OR dest.code= 'ZAM';

-- Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
SELECT orig.long_name, dest.long_name
FROM flights
JOIN airports orig ON flights.origin_id = orig.id
JOIN airports dest ON flights.destination_id = dest.id
WHERE flights.id IN (
	SELECT tickets.flight_id
	FROM tickets 
	JOIN itineraries ON tickets.itinerary_id = itineraries.id
	JOIN users ON itineraries.user_id = users.id
	WHERE users.first_name = 'Sophie'
	  AND users.last_name = 'McGlynn'
	)
	AND flights.departure_time > '2012-01-01' 
	AND flights.arrival_time > '2012-01-01';


-- SELECT tickets.flight_id
-- 	FROM tickets 
-- 	JOIN itineraries ON tickets.itinerary_id = itineraries.id
-- 	JOIN users ON itineraries.user_id = users.id
-- 	WHERE users.first_name = 'Sophie'
-- 	  AND users.last_name = 'McGlynn'

-- produces flight ids:

-- 10361
-- 9426 //incorrect date
-- 6508 //incorrect date
-- 6128 
-- 8912

