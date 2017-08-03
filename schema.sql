CREATE TABLE tickets (
    id integer NOT NULL,
    itinerary_id integer,
    flight_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone

CREATE TABLE itineraries (
    id integer NOT NULL,
    user_id integer NOT NULL,
    payment_method character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE TABLE users (
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

CREATE TABLE flights (
    id integer NOT NULL,
    origin_id integer NOT NULL,
    destination_id integer NOT NULL,
    departure_time timestamp without time zone NOT NULL,
    arrival_time timestamp without time zone NOT NULL,
    price double precision NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    airline_id integer NOT NULL,
    distance integer NOT NULL
);

CREATE TABLE airports (
    id integer NOT NULL,
    city_id integer NOT NULL,
    state_id integer NOT NULL,
    code character varying NOT NULL,
    long_name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE TABLE states (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE TABLE cities (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE TABLE airlines (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);



