Get a list of all users in California

SELECT *
FROM users JOIN states ON users.state_id = states.id
WHERE states.name = 'California'

Get a list of all airports in Gwendolynfort

SELECT *
FROM airports
WHERE long_name LIKE 'Gwendolynfort%'

Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'

CREATE TABLE itineraries (
    id integer NOT NULL,
    user_id integer NOT NULL,
    payment_method character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.
Find a list of all Airport names and codes which connect to the airport coded ZAM.
Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
