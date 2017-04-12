-- Get a list of all users in California
SELECT username
FROM states
JOIN users ON states.id=users.state_id
WHERE states.name = 'California'


-- Get a list of all airports in Kadeton





-- Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'
-- Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.
-- Find a list of all Airport names and codes which connect to the airport coded LYT.
-- Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).