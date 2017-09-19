 TABLE users (
    id integer NOT NULL,
    city_id integer NOT NULL,
    state_id integer NOT NULL,
    username character varying NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

 TABLE states (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

SELECT first_name, last_name
	FROM users JOIN states ON users.state_id = states.id
	WHERE name = 'California';

SELECT long_name
FROM airports JOIN cities ON city_id = cities.id
WHERE cities.name = 'Lake Ashley';

SELECT payment_method
FROM itineraries JOIN users ON users.id = itineraries.user_id
WHERE email = 'hansen.lawson@marvin.io';

SELECT price
FROM airports JOIN flights ON origin_id = airports.id
WHERE long_name = 'Matildechester Probably International Airport';

SELECT long_name, code
FROM airports JOIN flights ON flights.origin_id = airports.id
WHERE flights.destination_id = (
  SELECT airports.id
  FROM airports JOIN flights ON flights.destination_id = airports.id
  WHERE airports.code = 'PHL'
  GROUP BY airports.id
);

SELECT long_name, code
FROM airports JOIN flights ON flights.destination_id = airports.id
WHERE flights.origin_id = (
  SELECT airports.id
  FROM airports JOIN flights ON flights.origin_id = airports.id
  WHERE airports.code = 'PHL'
  GROUP BY airports.id
);s

Find a list of all Airport names and codes which connect to the airport coded LYT.

//flight.origin_id = PHL(num) get destination_id (airport name)
//flight.destination_id = PHL(num) get origin_id (airport name)
