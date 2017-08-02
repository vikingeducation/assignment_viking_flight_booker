-- 1. Get a list of all users in California
SELECT (first_name || ' ' || last_name) AS user FROM users JOIN states ON (users.state_id = states.id);

-- 2. SELECT name FROM airports JOIN cities ON (airports.id = city_id) LIMIT 5;
