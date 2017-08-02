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
