-- Get a list of all users in California
SELECT username
FROM states
JOIN users ON states.id=users.state_id
WHERE states.name = 'California';

    username
    --------------------
    jeffrey_zemlak
    hillary.west
    winnifred.baumbach
    rylan
    anibal
    angeline.ruecker
    jacinthe
    conrad.luettgen
    (8 rows)

-- Get a list of all airports in Kadeton
SELECT airports.long_name
FROM airports
JOIN cities ON airports.city_id=cities.id
WHERE cities.name='Kadeton';

    Kadeton Probably International Airport

-- Get a list of all payment methods used on itineraries by the user with email address 'senger.krystel@marvin.io'
SELECT DISTINCT itineraries.payment_method
FROM itineraries
JOIN users ON itineraries.user_id=users.id
WHERE users.email='senger.krystel@marvin.io';

    MasterCard
    Cash

-- Get a list of prices of all flights whose origins are in Kochfurt Probably International Airport.
SELECT flights.price
FROM flights
JOIN airports ON flights.origin_id=airports.id
WHERE airports.long_name='Kochfurt Probably International Airport';

    price
    --------
    341.25
    781.37
    716.91
    (3 rows)

-- Find a list of all Airport names and codes which connect to the airport coded LYT.
SELECT airports.long_name, airports.code
FROM airports
JOIN flights ON airports.id = flights.origin_id
WHERE flights.destination_id IN
  (SELECT airports.id
  FROM airports
  WHERE airports.code = 'LYT');

      long_name                       | code
     -------------------------------------------------------+------
      Lake Arvillaland Probably International Airport       | PUE
      Kristinaville Probably International Airport          | VEN
      West Myriamside Probably International Airport        | BCR
      South Queen Probably International Airport            | QYZ
      Huelville Probably International Airport              | KPC
      South Merle Probably International Airport            | PWB
      New Janieville Probably International Airport         | IKI
      West Wilburn Probably International Airport           | FLX
      Halvorsonborough Probably International Airport       | LGB
      Lisafurt Probably International Airport               | UWE
      North Mariane Probably International Airport          | TAG
      South Jackelineborough Probably International Airport | YSK
      Port Brandyn Probably International Airport           | RXE
      North Jovanyberg Probably International Airport       | AOS
      Lake Destin Probably International Airport            | KWX
      Rosemaryton Probably International Airport            | CIP
      Greenfeldermouth Probably International Airport       | LCZ
      Lake Rupertville Probably International Airport       | MCZ
      Hillsborough Probably International Airport           | KAA
      Madgefurt Probably International Airport              | ZDM
      Cummeratachester Probably International Airport       | ZBX
      Anaton Probably International Airport                 | QEL
      East Rhea Probably International Airport              | DXJ
      Gloverport Probably International Airport             | KIS
      Blockmouth Probably International Airport             | GHM
     (25 rows)

-- Get a list of all airports visited by user Krystel Senger after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
