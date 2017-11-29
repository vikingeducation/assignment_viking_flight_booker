-- Queries 2: Adding in Aggregation
-- 1.	Find the top 5 most expensive flights that end in California.
select * from flights 
where destination_id in (select a.id from airports a
join states s on s.id = a.state_id
where s.name = 'California')
order by price desc
limit 5

-- 2.	Find the shortest flight that username 'emelia' took.
select * from flights f
join tickets t on f.id = t.flight_id
join itineraries i on t.itinerary_id = i.id
join users u on i.user_id = u.id
where u.username = 'emelia'
order by f.distance
limit 1

-- 3.	Find the average flight distance for every city in California
-- 4.	Find the 3 users who spent the most money on flights in 2013
-- 5.	Count all flights to OR from the city of Smithshire that did not land in Delaware
-- 6.	Return the range of lengths of flights in the system(the maximum, and the minimum).
