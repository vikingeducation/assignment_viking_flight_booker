-- Queries 1: Warmups
-- Here are some queries we'd like you to answer using this database:
-- 1.	Get a list of all users in California
select username 
from users 
where state_id in (select id from states where name = 'California');

-- 2.	Get a list of all airports in Gwendolynfort
select code, long_name 
from airports 
where city_id = (select id from cities where name like '%Gwendolynfort%');

-- 3.	Get a list of all payment methods used on itineraries by the user with email address 'kallie.weimann@dach.biz'
select payment_method 
from itineraries 
where user_id = (select id from users where email = 'kallie.weimann@dach.biz');

-- 4.	Get a list of prices of all flights whose origins are in Port Gerardbury Probably International Airport.
select price 
from flights 
where origin_id in (select city_id from airports where long_name ilike '%Port Gerardbury Probably International Airport%');

-- 5.	Find a list of all Airport names and codes which connect to the airport coded ZAM.
select * 
from flights 
where origin_id = (select city_id from airports where code = 'ZAM') or destination_id = (select city_id from airports where code = 'ZAM');

-- 6.	Get a list of all airports visited by user Sophie McGlynn after January 1, 2012. (Hint, see if you can get a list of all ticket IDs first).
select * 
from airports 
where city_id in 
    (select origin_id from flights where id in 
    (select flight_id from tickets where itinerary_id = 
    (select id from itineraries where user_id = 
    (select id from users where first_name = 'Sophie' and last_name = 'McGlynn'))))
or city_id in 
    (select destination_id from flights where id in 
    (select flight_id from tickets where itinerary_id = 
    (select id from itineraries where user_id = 
    (select id from users where first_name = 'Sophie' and last_name = 'McGlynn'))));
