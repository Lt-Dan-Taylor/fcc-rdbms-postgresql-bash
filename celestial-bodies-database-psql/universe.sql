--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: galaxy_types; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.galaxy_types AS ENUM (
    'spiral',
    'elliptical',
    'lenticular',
    'irregular',
    'active',
    'seyfert',
    'quasars',
    'blazars'
);


ALTER TYPE public.galaxy_types OWNER TO freecodecamp;

--
-- Name: planet_types; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.planet_types AS ENUM (
	'terrestial',
	'gas giant',
	'ice giant',
	'super-earth',
	'mini-neptune',
	'exoplanet'
);

ALTER TYPE public.planet_types OWNER TO freecodecamp;

--
-- Name: star_types; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.star_types AS ENUM (
    'main sequence',
    'red giants',
    'white dwarfs',
    'neutron',
    'red dwarfs',
    'yellow dwarfs',
    'brown dwarfs'
);


ALTER TYPE public.star_types OWNER TO freecodecamp;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cluster; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.cluster (
    cluster_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);


ALTER TABLE public.cluster OWNER TO freecodecamp;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.cluster_cluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cluster_cluster_id_seq OWNER TO freecodecamp;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.cluster_cluster_id_seq OWNED BY public.cluster.cluster_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    galaxy_type public.galaxy_types,
    age_in_millions_of_years integer,
    distance_from_earth_in_lightyears bigint,
    description text,
    mass_in_trillions_masses numeric(5,3),
    cluster_id integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(60) NOT NULL,
    orbital_speed_in_km_per_s integer,
    age_in_millions_of_years integer,
    distance_from_earth_in_lightyears bigint,
    description text,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(60) NOT NULL,
    planet_type public.planet_types,
    has_life boolean,
    age_in_millions_of_years integer,
    distance_from_earth_in_lightyears bigint,
    description text,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    star_type public.star_types,
    age_in_millions_of_years integer,
    distance_from_earth_in_lightyears bigint,
    desription text,
    is_spherical boolean,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: cluster cluster_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.cluster ALTER COLUMN cluster_id SET DEFAULT nextval('public.cluster_cluster_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: cluster; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.cluster VALUES (1, 'Bullet Cluster', 'The cluster is named for the merger of two clusters colliding like a bullet');
INSERT INTO public.cluster VALUES (2, 'El Gordo', 'Named for its size, El Gordo or the fat one is the biggest cluster found in the distant universe (at its distance and beyond), at the time of discovery in 2011, with a mass of 3 quadrillion suns');
INSERT INTO public.cluster VALUES (3, 'Musket Ball Cluster', 'Named in comparison to the Bullet Cluster, as this one is older and slower galaxy cluster merger than the Bullet Cluster');
INSERT INTO public.cluster VALUES (4, 'Pandora Cluster', 'Named because the cluster resulted from a collision of clusters, which resulted in many different and strange phenomena');
INSERT INTO public.cluster VALUES (5, 'Virgo Cluster', 'Virgo means the virgin in Latin, and contains one of the brightest stars');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'spiral', 13610, NULL, 'Milky Way Galaxy, large spiral system consisting of several hundred billion stars, one of which is the Sun. It takes its name from the Milky Way, the irregular luminous band of stars and gas clouds that stretches across the sky as seen from Earth', 1.500, 5);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'spiral', 10010, 2537000, 'The Andromeda Galaxy is a barred spiral galaxy and is the nearest major galaxy to the Milky Way. It was originally named the Andromeda Nebula and is cataloged as Messier 31, M31, and NGC 224', 1.230, 5);
INSERT INTO public.galaxy VALUES (3, 'Cartwheel', 'lenticular', 400, 489200000, 'The Cartwheel Galaxy is a lenticular ring galaxy about 500 million light-years away in the constellation Sculptor', 0.004, NULL);
INSERT INTO public.galaxy VALUES (4, 'Messier 82', 'irregular', 13300, 11420000, 'The Cigar Galaxy or M82 Galaxy Messier 82 is a starburst galaxy approximately 12 million light-years away in the constellation Ursa Major', 0.050, NULL);
INSERT INTO public.galaxy VALUES (5, 'Pinwheel', 'spiral', 13510, 25000000, 'The Pinwheel Galaxy is a face-on spiral galaxy 21 million light-years from Earth in the constellation Ursa Major. It was discovered by Pierre Méchain in 1781 and was communicated that year to Charles Messier, who verified its position for inclusion in the Messier Catalogue as one of its final entries', 1.000, NULL);
INSERT INTO public.galaxy VALUES (6, 'Triangulum', 'spiral', 10000, 2723000, 'Spiral galaxy M33 or Triangulum galaxy  is located in the triangle-shaped constellation Triangulum, earning it the nickname the Triangulum galaxy. About half the size of our Milky Way galaxy, M33 is the third-largest member of our Local Group of galaxies following the Andromeda galaxy (M31) and the Milky Way.', 0.050, 5);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', NULL, NULL, NULL, NULL, 3);
INSERT INTO public.moon VALUES (2, 'Phobos', NULL, NULL, NULL, NULL, 4);
INSERT INTO public.moon VALUES (3, 'Deimos', NULL, NULL, NULL, NULL, 4);
INSERT INTO public.moon VALUES (4, 'Io', NULL, NULL, NULL, NULL, 5);
INSERT INTO public.moon VALUES (5, 'Europa', NULL, NULL, NULL, NULL, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', NULL, NULL, NULL, NULL, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', NULL, NULL, NULL, NULL, 5);
INSERT INTO public.moon VALUES (8, 'Amalthea', NULL, NULL, NULL, NULL, 5);
INSERT INTO public.moon VALUES (9, 'Himalia', NULL, NULL, NULL, NULL, 5);
INSERT INTO public.moon VALUES (10, 'Elara', NULL, NULL, NULL, NULL, 5);
INSERT INTO public.moon VALUES (11, 'Titan', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (12, 'Enceladus', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (13, 'Mimas', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (14, 'Iapetus', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (15, 'Atlas', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (16, 'Helene', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (17, 'Calypso', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (18, 'Rhea', NULL, NULL, NULL, NULL, 6);
INSERT INTO public.moon VALUES (19, 'Miranda', NULL, NULL, NULL, NULL, 7);
INSERT INTO public.moon VALUES (20, 'Ariel', NULL, NULL, NULL, NULL, 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 'terrestial', false, 4503, NULL, NULL, 3);
INSERT INTO public.planet VALUES (2, 'Venus', 'terrestial', false, , 4503, NULL, 3);
INSERT INTO public.planet VALUES (3, 'Earth', 'terrestial', true, 4543, NULL, NULL, 3);
INSERT INTO public.planet VALUES (4, 'Mars', 'terrestial', false, 4603, NULL, NULL, 3);
INSERT INTO public.planet VALUES (5, 'Jupyter', 'gas giant', false, 4603, NULL, NULL, 3);
INSERT INTO public.planet VALUES (6, 'Saturn', 'gas giant', false, 4503, NULL, NULL, 3);
INSERT INTO public.planet VALUES (7, 'Uranus', 'ice giant', false, 4503, NULL, NULL, 3);
INSERT INTO public.planet VALUES (8, 'Neptune', 'ice giant', false, 4503, NULL, NULL, 3);
INSERT INTO public.planet VALUES (9, 'Kepler-62e', 'super-earth', 7000, NULL, NULL, NULL, 9);
INSERT INTO public.planet VALUES (10, 'Proxima Centauri b', 'exoplanet', false, 4850, NULL, NULL, 6);
INSERT INTO public.planet VALUES (11, 'Kepler-22b', 'super-earth', false, 4000, NULL, NULL, 7);
INSERT INTO public.planet VALUES (12, 'Osiris', 'exoplanet', false, NULL, 4000, NULL, 8);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Altair', 'main sequence', 1200, 17, 'Altair is the brightest star in the constellation of Aquila and the twelfth-brightest star in the night sky', false, 1);
INSERT INTO public.star VALUES (2, 'Vega', 'main sequence', 450, 25, 'Vega, brightest star in the northern constellation Lyra and fifth brightest in the night sky, with a visual magnitude of 0.03', false, 1);
INSERT INTO public.star VALUES (3, 'SUN', 'main sequence', 4603, NULL, 'The Sun is the star at the center of the Solar System. It is a massive, hot ball of plasma, inflated and heated by energy produced by nuclear fusion reactions at its core', true, 1);
INSERT INTO public.star VALUES (4, 'Betelgeuse', 'red giants', 10, 700, 'Betelgeuse is a red supergiant star of spectral type M1-2 and one of the largest visible to the naked eye. It is usually the tenth-brightest star in the night sky', false, 1);
INSERT INTO public.star VALUES (5, 'Sirius', 'main sequence', 230, 9, 'Sirius is the brightest star in the night sky. Its name is derived from the Greek word Σείριος, meaning lit. glowing or scorching', true, 1);
INSERT INTO public.star VALUES (6, 'Alpha Centauri', 'main sequence', 4850, 4, 'Alpha Centauri is a triple star system in the southern constellation of Centaurus. It consists of three stars: Rigil Kentaurus, Toliman and Proxima Centauri', true, 1);
INSERT INTO public.star VALUES (7, 'Kepler-22', 'main sequence', 4000, 640, 'Kepler-22 is a Sun-like star in the northern constellation of Cygnus, the swan, that is orbited by a planet found to be unequivocally within the stars habitable zone', true, 1);
INSERT INTO public.star VALUES (8, 'HD 209458', 'main sequence', 3500, 159, 'HD 209458 is a star with an orbiting exoplanet in the constellation Pegasus. It has an apparent visual magnitude of 7.65 and an absolute magnitude of 4.28', true, 1);
INSERT INTO public.star VALUES (9, 'Kepler-62', 'main sequence', 7000, 980, 'Kepler-62 is a K-type main sequence star cooler and smaller than the Sun, located roughly 980 light-years from Earth in the constellation Lyra', true, 1);


--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.cluster_cluster_id_seq', 5, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 9, true);


--
-- Name: cluster cluster_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT cluster_name_key UNIQUE (name);


--
-- Name: cluster cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT cluster_pkey PRIMARY KEY (cluster_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy galaxy_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.cluster(cluster_id);


--
-- Name: moon moon_planet_ref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_ref_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_ref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_ref_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_ref_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_ref_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

