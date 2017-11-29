-- Queries 2: Adding in Aggregation
-- 1.	Find the top 5 most expensive flights that end in California.
select * from flights 
where destination_id in (select a.id from airports a
join states s on s.id = a.state_id
where s.name = 'California')
order by price desc
limit 5;

-- 2.	Find the shortest flight that username 'emelia' took.
select * from flights f
join tickets t on f.id = t.flight_id
join itineraries i on t.itinerary_id = i.id
join users u on i.user_id = u.id
where u.username = 'emelia'
order by f.distance
limit 1;

-- 3.	Find the average flight distance for every city in California
select c.name, round(avg(f.distance),0) avg_distance from flights f
left outer join airports a on f.origin_id = a.id
left outer join cities c on c.id = a.city_id
left outer join states s on s.id = a.state_id
where s.name = 'California'
group by c.id
order by name;

-- 4.	Find the 3 users who spent the most money on flights in 2013
select u.*, sum(f.price) from users u
join itineraries i on i.user_id = u.id
join tickets t on i.id = t.itinerary_id
join flights f on f.id = t.flight_id
where to_char(departure_time , 'YYYY') = '2013' or to_char(arrival_time , 'YYYY') = '2013'
group by u.id
order by sum desc
limit 3;

-- 5.	Count all flights to OR from the city of Smithshire that did not land in Delaware
select * from flights f
where (f.origin_id in (select a.id from airports a join cities c on c.id = a.city_id where c.name like 'Smithhaven') 
	and f.destination_id not in (select a.id from airports a join states s on s.id = a.state_id where s.name = 'Delaware'))
	or 
	(f.origin_id not in (select a.id from airports a join states s on s.id = a.state_id where s.name = 'Delaware')
	and f.destination_id in (select a.id from airports a join cities c on c.id = a.city_id where c.name like 'Smithhaven'));

-- 6.	Return the range of lengths of flights in the system(the maximum, and the minimum).
select min(distance), max(distance) 
from flights;
