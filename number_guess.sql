--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer,
    best_game integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (3, 'user_1662552329713', 2, 531);
INSERT INTO public.games VALUES (20, 'user_1662554437533', 2, 416);
INSERT INTO public.games VALUES (2, 'user_1662552329714', 5, 282);
INSERT INTO public.games VALUES (19, 'user_1662554437534', 5, 452);
INSERT INTO public.games VALUES (5, 'user_1662552696497', 2, 689);
INSERT INTO public.games VALUES (4, 'user_1662552696498', 5, 23);
INSERT INTO public.games VALUES (22, 'user_1662554469027', 2, 130);
INSERT INTO public.games VALUES (7, 'user_1662552797145', 2, 369);
INSERT INTO public.games VALUES (6, 'user_1662552797146', 5, 116);
INSERT INTO public.games VALUES (21, 'user_1662554469028', 5, 21);
INSERT INTO public.games VALUES (9, 'user_1662553012710', 2, 310);
INSERT INTO public.games VALUES (8, 'user_1662553012711', 5, 312);
INSERT INTO public.games VALUES (24, 'user_1662554559781', 2, 583);
INSERT INTO public.games VALUES (11, 'user_1662553149557', 2, 188);
INSERT INTO public.games VALUES (23, 'user_1662554559782', 5, 255);
INSERT INTO public.games VALUES (10, 'user_1662553149558', 5, 521);
INSERT INTO public.games VALUES (1, 'cevor', 6, 10);
INSERT INTO public.games VALUES (13, 'user_1662553993266', 2, 450);
INSERT INTO public.games VALUES (12, 'user_1662553993267', 5, 508);
INSERT INTO public.games VALUES (26, 'user_1662554764306', 2, 361);
INSERT INTO public.games VALUES (15, 'user_1662554059855', 2, 163);
INSERT INTO public.games VALUES (25, 'user_1662554764307', 5, 151);
INSERT INTO public.games VALUES (14, 'user_1662554059856', 5, 495);
INSERT INTO public.games VALUES (16, 'marvan', 1, 4);
INSERT INTO public.games VALUES (18, 'user_1662554388464', 2, 507);
INSERT INTO public.games VALUES (28, 'user_1662554849479', 2, 150);
INSERT INTO public.games VALUES (17, 'user_1662554388465', 5, 124);
INSERT INTO public.games VALUES (27, 'user_1662554849480', 5, 273);
INSERT INTO public.games VALUES (30, 'user_1662555012000', 2, 856);
INSERT INTO public.games VALUES (29, 'user_1662555012001', 5, 107);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 30, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: games games_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

