Get a list of all users in California

SELECT *
FROM users JOIN states ON users.state_id = states.id
WHERE states.name = 'California'

Get a list of all airports in Gwendolynfort

SELECT *
FROM airports
WHERE long_name LIKE 'Gwendolynfort%'

Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'


SELECT itineraries.payment_method
FROM users JOIN itineraries on users.id=itineraries.user_id
WHERE users.email='kallie.weimann@dach.biz'



Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.

SELECT flights.price
FROM flights JOIN airports ON flights.origin_id=airports.id
WHERE airports.long_name= 'Port Gerardbury Probably International Airport';


Find a list of all Airport names and codes which connect to the airport coded ZAM.


SELECT 
CASE WHEN origin.code='ZAM' THEN destination.long_name ELSE origin.long_name END,
CASE WHEN origin.code='ZAM' THEN destination.code ELSE origin.code END
FROM airports origin JOIN flights ON origin.id=flights.origin_id
JOIN airports destination ON destination.id=flights.destination_id
WHERE origin.code='ZAM' OR destination.code='ZAM'




Get a list of all airports visited by user Sophie McGlynn after January 1, 2012.
(Hint, see if you can get a list of all ticket IDs first).


SELECT origin.long_name, destination.long_name
FROM users JOIN itineraries ON users.id=itineraries.user_id JOIN tickets
ON itineraries.id = tickets.itinerary_id JOIN flights ON tickets.flight_id=flights.id
JOIN airports destination ON flights.destination_id= destination.id JOIN airports origin
ON origin.id=flights.origin_id
WHERE users.first_name = 'Sophie' AND users.last_name='McGlynn';