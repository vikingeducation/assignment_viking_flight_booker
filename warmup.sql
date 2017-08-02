--Get a list of all users in California

SELECT username
FROM users JOIN states ON states.id=users.state_id
WHERE states.name = 'California'

--Get a list of all airports in Kadeton
SELECT long_name
FROM airports JOIN cities ON cities.id=airports.city_id
WHERE cities.name = 'Kadeton'