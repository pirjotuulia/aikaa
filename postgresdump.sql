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
    city character varying(255)
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
-- Name: appuser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appuser (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    password character varying(255)
);


ALTER TABLE public.appuser OWNER TO postgres;

--
-- Name: appuser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appuser_id_seq OWNER TO postgres;

--
-- Name: appuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appuser_id_seq OWNED BY public.appuser.id;


--
-- Name: appuserrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appuserrole (
    userid integer,
    userrole character varying(255)
);


ALTER TABLE public.appuserrole OWNER TO postgres;

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
    ending timestamp without time zone,
    placeid integer,
    eventid integer,
    type character varying(255),
    workid integer
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
    workroleid integer
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
    userlevel integer,
    email character varying(255),
    addressid integer,
    phonenumber character varying(255),
    picurl character varying(255)
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
-- Name: workrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workrole (
    id integer NOT NULL,
    workid integer,
    roleid integer,
    number integer
);


ALTER TABLE public.workrole OWNER TO postgres;

--
-- Name: workrole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.workrole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workrole_id_seq OWNER TO postgres;

--
-- Name: workrole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.workrole_id_seq OWNED BY public.workrole.id;


--
-- Name: address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address ALTER COLUMN id SET DEFAULT nextval('public.address_id_seq'::regclass);


--
-- Name: appuser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appuser ALTER COLUMN id SET DEFAULT nextval('public.appuser_id_seq'::regclass);


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
-- Name: workrole id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workrole ALTER COLUMN id SET DEFAULT nextval('public.workrole_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address (id, streetaddress, postcode, country, city) FROM stdin;
4	Tie 1	00030	Maa	Ei
3	Kirkkokuja 4	00030	Suomi	Tyrnävä
1	Keikkatie 1	00000	Suomi	Tyrnävä
2	Harjoituskatu 2	00010	Suomi	Tyrnävä
\.


--
-- Data for Name: appuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appuser (id, username, email, password) FROM stdin;
1	Pirjo Leppänen	pirjotuulia74@gmail.com	$2a$10$IBLFLBzDMgtsdp2MrwJBIeUoInL6ZqMXCAsmxPIuni0lLiNzgijY6
3	Mikko Kallio	mikko.m.kallio	$2a$10$r2kCrAkyTX1bvBaQ6onLg.Q4EDFTn0WKe3U6yGunQE1Zbtk2yxNZi
5	Heponen	heponen@ihanuusvirasto.com	$2a$10$Tvx0RUNrz0wKbg6nEwWpu.oCpn3TaYN7iS2jP/DxgVESiwYwbWkIu
6	Admin Admin	admin@admin.com	$2a$10$QAQTSWoPjoL9WJtcLZdzn.QD5jNnjMjbkE1MTefSaVJhKqXkcL0Q6
\.


--
-- Data for Name: appuserrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appuserrole (userid, userrole) FROM stdin;
1	ROLE_SUPERADMIN
2	ROLE_SUPERADMIN
6	ROLE_USER
6	ROLE_ADMIN
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
2	Sopraano	7
5	Mezzosopraano	7
7	Konserttisihteeri	9
8	Järjestäjä	9
9	Autonkuljettaja	9
13	Sivunkääntäjä	9
14	Pianonvirittäjä	9
15	Tenori	7
18	SuperAdmin	9
12	Klarinetti	2
17	Käyrätorvi	3
1	Viulu	1
3	Alttoviulu	1
6	Piano	6
11	Lyömäsoittimet	4
4	Sello	1
16	Tenorisaksofoni	2
10	Kontrabasso	1
19	Pasuuna	3
20	Oboe	2
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

COPY public.subevent (id, name, begin, ending, placeid, eventid, type, workid) FROM stdin;
2	konsertti 1	2019-07-06 19:00:00	2019-07-06 21:00:00	1	1	konsertti	\N
4	poissa	2019-07-06 00:00:00	2019-07-06 15:00:00	\N	3	poissaolo	\N
3	harjoitus	2019-07-05 11:00:00	2019-07-05 13:00:00	2	1	harjoitus	1
1	saliharjoitus	2019-07-06 15:30:00	2019-07-06 17:15:00	1	1	harjoitus	3
5	harjoitus	2019-07-05 13:00:00	2019-07-05 15:00:00	2	1	harjoitus	3
6	saliharjoitus	2019-07-06 17:15:00	2019-07-06 18:00:00	1	1	harjoitus	1
7	saliharjoitus	2019-07-06 15:00:00	2019-07-06 15:30:00	1	1	harjoitus	2
8	harjoitus	2019-07-07 10:00:00	2019-07-07 13:00:00	1	1	harjoitus	1
9	harjoitus	2019-07-03 10:00:00	\N	1	1	harjoitus	1
\.


--
-- Data for Name: subeventcast; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subeventcast (id, subeventid, userid, workroleid) FROM stdin;
2	3	2	1
1	3	1	1
3	3	3	4
4	3	4	5
19	2	1	1
20	2	2	1
22	2	4	5
21	2	3	4
24	2	6	4
23	2	5	2
12	7	6	3
11	7	5	2
7	5	3	7
5	5	1	6
10	5	6	10
18	2	6	10
6	5	2	6
9	5	5	9
15	2	3	7
13	2	1	6
8	5	4	8
14	2	2	6
17	2	5	9
16	2	4	8
26	2	12	5
25	2	11	4
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, name, userlevel, email, addressid, phonenumber, picurl) FROM stdin;
1	Muusikko1	3	\N	\N	\N	\N
2	Muusikko2	3	\N	\N	\N	\N
3	Muusikko3	3	\N	\N	\N	\N
4	Muusikko4	3	\N	\N	\N	\N
5	Muusikko5	3	\N	\N	\N	\N
6	Muusikko6	3	\N	\N	\N	\N
7	Muusikko7	3	\N	\N	\N	\N
8	Muusikko8	3	\N	\N	\N	\N
9	SuperAdmin	1	\N	\N	\N	\N
10	Admin	2	\N	\N	\N	\N
11	Järjestäjä	3	\N	\N	\N	\N
12	Konserttisihteeri	2	\N	\N	\N	\N
13	Muusikko10	3	\N	\N	\N	\N
14	Pirjo Leppänen	1	pirjotuulia74@gmail.com	\N	\N	\N
15	Mikko Kallio	1	mikko.m.kallio@gmail.com	\N	\N	\N
16	Admin Admin	2	admin@admin.com	\N	\N	\N
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
38	18	14
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work (id, work, composer, instrumentation, musicians, durationinminutes) FROM stdin;
1	Jousikvartetto	Schumann	2vl, 1vla, 1vcl	4	32
2	Gretchen am Spinnrade	Schubert	1s, 1pf	2	5
3	Tilausteos	Nuori säveltäjä	1s, 2vl, 1vla, 1vcl, 1pf	6	35
4	Roudaus	\N	lavajärjestäjä	0	\N
5	Kukat, kuulutukset	\N	konserttisihteeri	0	\N
\.


--
-- Data for Name: workrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workrole (id, workid, roleid, number) FROM stdin;
1	1	1	2
3	2	6	1
4	1	3	1
5	1	4	1
6	3	1	2
7	3	3	1
8	3	4	1
10	3	6	1
11	4	8	1
12	5	7	1
2	2	5	1
9	3	5	1
\.


--
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_id_seq', 1, false);


--
-- Name: appuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appuser_id_seq', 6, true);


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

SELECT pg_catalog.setval('public.role_id_seq', 20, true);


--
-- Name: rolecategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rolecategory_id_seq', 9, true);


--
-- Name: subevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subevent_id_seq', 9, true);


--
-- Name: subeventcast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subeventcast_id_seq', 26, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 16, true);


--
-- Name: userrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userrole_id_seq', 38, true);


--
-- Name: work_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_id_seq', 5, true);


--
-- Name: workrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.workrole_id_seq', 12, true);


--
-- Name: address address_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pk PRIMARY KEY (id);


--
-- Name: appuser appuser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appuser
    ADD CONSTRAINT appuser_pkey PRIMARY KEY (id);


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
-- Name: workrole workrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workrole
    ADD CONSTRAINT workrole_pkey PRIMARY KEY (id);


--
-- Name: address_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX address_id_uindex ON public.address USING btree (id);


--
-- Name: appuser_email_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX appuser_email_uindex ON public.appuser USING btree (email);


--
-- Name: appuser_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX appuser_id_uindex ON public.appuser USING btree (id);


--
-- Name: appuser_username_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX appuser_username_uindex ON public.appuser USING btree (username);


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
-- Name: workrole_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX workrole_id_uindex ON public.workrole USING btree (id);


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
-- Name: subevent subevent_work_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subevent
    ADD CONSTRAINT subevent_work_id_fk FOREIGN KEY (workid) REFERENCES public.work(id);


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
-- Name: subeventcast subeventcast_workrole_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subeventcast
    ADD CONSTRAINT subeventcast_workrole_id_fk FOREIGN KEY (workroleid) REFERENCES public.workrole(id);


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
-- Name: workrole workrole_role_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workrole
    ADD CONSTRAINT workrole_role_id_fk FOREIGN KEY (roleid) REFERENCES public.role(id);


--
-- Name: workrole workrole_work_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workrole
    ADD CONSTRAINT workrole_work_id_fk FOREIGN KEY (workid) REFERENCES public.work(id);


--
-- PostgreSQL database dump complete
--

