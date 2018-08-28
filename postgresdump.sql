--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: daa; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA daa;


ALTER SCHEMA daa OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    id integer NOT NULL,
    streetaddress character varying(255),
    postcode character varying(255),
    country character varying(255),
    district character varying(255)
);


ALTER TABLE public.address OWNER TO postgres;

--
-- Name: address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_id_seq OWNER TO postgres;

--
-- Name: address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.address_id_seq OWNED BY public.address.id;


--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_id_seq OWNED BY public.event.id;


--
-- Name: eventwork; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eventwork (
    id integer NOT NULL,
    eventid integer,
    workid integer
);


ALTER TABLE public.eventwork OWNER TO postgres;

--
-- Name: eventwork_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eventwork_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eventwork_id_seq OWNER TO postgres;

--
-- Name: eventwork_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eventwork_id_seq OWNED BY public.eventwork.id;


--
-- Name: place; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.place (
    id integer NOT NULL,
    name character varying(255),
    addressid integer
);


ALTER TABLE public.place OWNER TO postgres;

--
-- Name: place_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.place_id_seq OWNER TO postgres;

--
-- Name: place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.place_id_seq OWNED BY public.place.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(255),
    categoryid integer
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: rolecategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rolecategory (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.rolecategory OWNER TO postgres;

--
-- Name: rolecategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rolecategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rolecategory_id_seq OWNER TO postgres;

--
-- Name: rolecategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rolecategory_id_seq OWNED BY public.rolecategory.id;


--
-- Name: subevent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subevent (
    id integer NOT NULL,
    name character varying(255),
    begin timestamp without time zone,
    "end" timestamp without time zone,
    placeid integer,
    eventid integer,
    type character varying(255)
);


ALTER TABLE public.subevent OWNER TO postgres;

--
-- Name: subevent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subevent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subevent_id_seq OWNER TO postgres;

--
-- Name: subevent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subevent_id_seq OWNED BY public.subevent.id;


--
-- Name: subeventcast; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subeventcast (
    id integer NOT NULL,
    subeventid integer,
    userid integer,
    roleid integer,
    workid integer
);


ALTER TABLE public.subeventcast OWNER TO postgres;

--
-- Name: subeventcast_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subeventcast_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subeventcast_id_seq OWNER TO postgres;

--
-- Name: subeventcast_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subeventcast_id_seq OWNED BY public.subeventcast.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    name character varying(255),
    userlevel integer
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: userrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userrole (
    id integer NOT NULL,
    roleid integer,
    userid integer
);


ALTER TABLE public.userrole OWNER TO postgres;

--
-- Name: userrole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userrole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userrole_id_seq OWNER TO postgres;

--
-- Name: userrole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userrole_id_seq OWNED BY public.userrole.id;


--
-- Name: work; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work (
    id integer NOT NULL,
    work character varying(255),
    composer character varying(255),
    instrumentation character varying(255),
    musicians integer,
    durationinminutes integer
);


ALTER TABLE public.work OWNER TO postgres;

--
-- Name: work_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_id_seq OWNER TO postgres;

--
-- Name: work_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_id_seq OWNED BY public.work.id;


--
-- Name: address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address ALTER COLUMN id SET DEFAULT nextval('public.address_id_seq'::regclass);


--
-- Name: event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);


--
-- Name: eventwork id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventwork ALTER COLUMN id SET DEFAULT nextval('public.eventwork_id_seq'::regclass);


--
-- Name: place id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.place ALTER COLUMN id SET DEFAULT nextval('public.place_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: rolecategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rolecategory ALTER COLUMN id SET DEFAULT nextval('public.rolecategory_id_seq'::regclass);


--
-- Name: subevent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subevent ALTER COLUMN id SET DEFAULT nextval('public.subevent_id_seq'::regclass);


--
-- Name: subeventcast id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeventcast ALTER COLUMN id SET DEFAULT nextval('public.subeventcast_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: userrole id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrole ALTER COLUMN id SET DEFAULT nextval('public.userrole_id_seq'::regclass);


--
-- Name: work id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work ALTER COLUMN id SET DEFAULT nextval('public.work_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address (id, streetaddress, postcode, country, district) FROM stdin;
1	Keikkatie 1	00000 Tyrnävä	Suomi	Pohojammaa
2	Harjoituskatu 2	00010 Tyrnävä	Suomi	Pohojammaa
3	Kirkkokuja 4	00030 Tyrnävä	Suomi	Pohojammaa
4	Tie 1	00030	Maa	Ei
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (id, name) FROM stdin;
1	Konsertti1
2	Konsertti2
3	NotAvailable
4	TestikonserttiMuutettu
5	Lisäystestikonsertti
6	Testikonsertti
7	Testikonsertti
8	Uusi testikonsertti
9	Testikonsertti
10	Testikonsertti
11	Testikonsertti
\.


--
-- Data for Name: eventwork; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eventwork (id, eventid, workid) FROM stdin;
1	1	1
2	1	2
3	1	3
\.


--
-- Data for Name: place; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.place (id, name, addressid) FROM stdin;
1	Konserttisali	1
2	Harjoitussali	2
3	Kirkko	3
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, name, categoryid) FROM stdin;
1	Viulisti	1
2	Sopraano	7
3	Alttoviulisti	1
4	Sellisti	1
5	Mezzosopraano	7
6	Pianisti	6
7	Konserttisihteeri	9
8	Järjestäjä	9
9	Autonkuljettaja	9
10	Kontrabasisti	1
11	Lyömäsoittaja	4
12	Klarinetisti	2
13	Sivunkääntäjä	9
14	Pianonvirittäjä	9
15	Tenori	7
16	Tenorisaksofonisti	2
17	Cornisti	3
\.


--
-- Data for Name: rolecategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rolecategory (id, name) FROM stdin;
1	Jousisoittimet
2	Puupuhaltimet
3	Vaskipuhaltimet
4	Lyömäsoittimet
5	Kielisoittimet
6	Kosketinsoittimet
7	Laulu
8	Muut
9	Tukihenkilöstö
\.


--
-- Data for Name: subevent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subevent (id, name, begin, "end", placeid, eventid, type) FROM stdin;
\.


--
-- Data for Name: subeventcast; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subeventcast (id, subeventid, userid, roleid, workid) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, name, userlevel) FROM stdin;
1	Muusikko1	3
2	Muusikko2	3
3	Muusikko3	3
4	Muusikko4	3
5	Muusikko5	3
6	Muusikko6	3
7	Muusikko7	3
8	Muusikko8	3
9	SuperAdmin	1
10	Admin	2
11	Järjestäjä	3
12	Konserttisihteeri	2
13	Muusikko10	3
\.


--
-- Data for Name: userrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userrole (id, roleid, userid) FROM stdin;
26	1	1
27	1	2
28	3	3
29	4	4
30	5	5
31	6	6
32	7	12
33	8	11
34	10	7
35	11	8
36	2	4
37	17	13
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work (id, work, composer, instrumentation, musicians, durationinminutes) FROM stdin;
1	Jousikvartetto	Schumann	2vl, 1vla, 1vcl	4	32
2	Gretchen am Spinnrade	Schubert	1s, 1pf	2	5
3	Tilausteos	Nuori säveltäjä	1s, 2vl, 1vla, 1vcl, 1pf	6	35
\.


--
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_id_seq', 1, false);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_id_seq', 11, true);


--
-- Name: eventwork_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventwork_id_seq', 3, true);


--
-- Name: place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.place_id_seq', 3, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 17, true);


--
-- Name: rolecategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rolecategory_id_seq', 9, true);


--
-- Name: subevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subevent_id_seq', 1, false);


--
-- Name: subeventcast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subeventcast_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 13, true);


--
-- Name: userrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userrole_id_seq', 37, true);


--
-- Name: work_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_id_seq', 3, true);


--
-- Name: address address_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pk PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: eventwork eventwork_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventwork
    ADD CONSTRAINT eventwork_pkey PRIMARY KEY (id);


--
-- Name: place place_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: rolecategory rolecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rolecategory
    ADD CONSTRAINT rolecategory_pkey PRIMARY KEY (id);


--
-- Name: subevent subevent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subevent
    ADD CONSTRAINT subevent_pkey PRIMARY KEY (id);


--
-- Name: subeventcast subeventcast_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeventcast
    ADD CONSTRAINT subeventcast_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: userrole userrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT userrole_pkey PRIMARY KEY (id);


--
-- Name: work work_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_pkey PRIMARY KEY (id);


--
-- Name: address_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_id_uindex ON public.address USING btree (id);


--
-- Name: event_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX event_id_uindex ON public.event USING btree (id);


--
-- Name: eventwork_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX eventwork_id_uindex ON public.eventwork USING btree (id);


--
-- Name: place_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX place_id_uindex ON public.place USING btree (id);


--
-- Name: role_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX role_id_uindex ON public.role USING btree (id);


--
-- Name: rolecategory_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX rolecategory_id_uindex ON public.rolecategory USING btree (id);


--
-- Name: subevent_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX subevent_id_uindex ON public.subevent USING btree (id);


--
-- Name: subeventcast_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX subeventcast_id_uindex ON public.subeventcast USING btree (id);


--
-- Name: user_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_id_uindex ON public."user" USING btree (id);


--
-- Name: userrole_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX userrole_id_uindex ON public.userrole USING btree (id);


--
-- Name: work_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX work_id_uindex ON public.work USING btree (id);


--
-- Name: eventwork eventwork_event_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventwork
    ADD CONSTRAINT eventwork_event_id_fk FOREIGN KEY (eventid) REFERENCES public.event(id);


--
-- Name: eventwork eventwork_work_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eventwork
    ADD CONSTRAINT eventwork_work_id_fk FOREIGN KEY (workid) REFERENCES public.work(id);


--
-- Name: place place_address_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_address_id_fk FOREIGN KEY (addressid) REFERENCES public.address(id);


--
-- Name: role role_rolecategory_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_rolecategory_id_fk FOREIGN KEY (categoryid) REFERENCES public.rolecategory(id);


--
-- Name: subevent subevent_event_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subevent
    ADD CONSTRAINT subevent_event_id_fk FOREIGN KEY (eventid) REFERENCES public.event(id);


--
-- Name: subevent subevent_place_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subevent
    ADD CONSTRAINT subevent_place_id_fk FOREIGN KEY (placeid) REFERENCES public.place(id);


--
-- Name: subeventcast subeventcast_role_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeventcast
    ADD CONSTRAINT subeventcast_role_id_fk FOREIGN KEY (roleid) REFERENCES public.role(id);


--
-- Name: subeventcast subeventcast_subevent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeventcast
    ADD CONSTRAINT subeventcast_subevent_id_fk FOREIGN KEY (subeventid) REFERENCES public.subevent(id);


--
-- Name: subeventcast subeventcast_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeventcast
    ADD CONSTRAINT subeventcast_user_id_fk FOREIGN KEY (userid) REFERENCES public."user"(id);


--
-- Name: subeventcast subeventcast_work_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeventcast
    ADD CONSTRAINT subeventcast_work_id_fk FOREIGN KEY (workid) REFERENCES public.work(id);


--
-- Name: userrole userrole_role_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT userrole_role_id_fk FOREIGN KEY (roleid) REFERENCES public.role(id);


--
-- Name: userrole userrole_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT userrole_user_id_fk FOREIGN KEY (userid) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

