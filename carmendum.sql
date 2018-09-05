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
    addressid integer,
    mapurl character varying
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
    picurl character varying
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
1	Klaneettitie 5	00420	Suomi	Helsinki
999999999	Ei tiedossa	\N	\N	\N
6	Tehtaankatu 23	00150	Suomi	Helsinki
\.


--
-- Data for Name: appuser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appuser (id, username, email, password) FROM stdin;
1	Pirjo Leppänen	pirjotuulia74@gmail.com	$2a$10$Bb2hNZeis0cunmnoFdIRg.CErY/70wEbzRQmdZ.pfTbmxnKznxZau
\.


--
-- Data for Name: appuserrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appuserrole (userid, userrole) FROM stdin;
1	ROLE_SUPERADMIN
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (id, name) FROM stdin;
1	Carmen
999999999	Poissaolot
\.


--
-- Data for Name: eventwork; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eventwork (id, eventid, workid) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	10
10	1	9
11	1	11
12	1	12
13	1	13
14	1	14
16	999999999	999999999
\.


--
-- Data for Name: place; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.place (id, name, addressid, mapurl) FROM stdin;
999999999	Poissa	999999999	\N
2	Kanneltalo, auditorio	1	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1980.4932017130293!2d24.87288131640374!3d60.23875998198619!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x468df63711cd7a53%3A0x403cd74a0d59cab!2sKanneltalo!5e0!3m2!1sen!2sse!4v1536068572898
1	Kanneltalo, sali	1	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1980.4932017130293!2d24.87288131640374!3d60.23875998198619!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x468df63711cd7a53%3A0x403cd74a0d59cab!2sKanneltalo!5e0!3m2!1sen!2sse!4v1536068572898
8	Agricolan kirkon krypta	6	https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1985.3628561420946!2d24.93699371640123!3d60.158171681956425!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46920bb6fb6778fb%3A0x3ffaf1da6f85ed16!2sMikael+Agricola+Church!5e0!3m2!1sen!2sse!4v1536141584418
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, name, categoryid) FROM stdin;
14	Piano	5
15	Ohjaaja	8
16	Valosuunnittelija	8
20	Micaëla	1
21	Frasquita	1
22	Carmen	2
23	Mercédès	2
24	Remendado	3
25	Don José	3
26	Escamillo	4
27	Dancaïro	4
29	Moralès	4
31	Zuniga	6
32	Tuottaja	7
\.


--
-- Data for Name: rolecategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rolecategory (id, name) FROM stdin;
8	Muut
4	Baritoni
2	Mezzosopraano
3	Tenori
1	Sopraano
5	Piano
6	Basso
7	Tukihenkilöstö
\.


--
-- Data for Name: subevent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subevent (id, name, begin, ending, placeid, eventid, type, workid) FROM stdin;
1	Ensi-ilta	2019-01-18 19:00:00	2019-01-18 22:00:00	1	1	esitys	\N
4	Näyttämöharjoitus	2018-10-07 11:00:00	2018-10-07 19:00:00	2	1	harjoitus	\N
6	Näyttämöharjoitus	2018-10-15 11:00:00	2018-10-15 15:00:00	2	1	harjoitus	3
2	Musiikkiharjoitus	2018-10-01 17:00:00	2018-10-01 21:00:00	2	1	harjoitus	1
5	Näyttämöharjoitus	2018-10-08 11:00:00	2018-10-08 14:00:00	2	1	harjoitus	\N
7	Näyttämöharjoitus	2018-10-14 12:00:00	2018-10-14 17:00:00	2	1	harjoitus	1
8	Näyttämöharjoitus	2018-10-16 17:00:00	2018-10-16 21:00:00	2	1	harjoitus	1
10	Näyttämöharjoitus	2018-10-18 17:00:00	2018-10-18 21:00:00	2	1	harjoitus	1
9	Näyttämöharjoitus	2018-10-17 17:00:00	2018-10-17 21:00:00	2	1	harjoitus	1
11	Näyttämöharjoitus	2018-10-20 12:00:00	2018-10-20 18:00:00	2	1	harjoitus	1
12	Näyttämöharjoitus	2018-10-21 11:00:00	2018-10-21 19:00:00	1	1	harjoitus	1
15	Pirjo töissä	2018-10-03 08:00:00	2018-10-03 16:00:00	999999999	999999999	poissaolo	999999999
16	Pirjo töissä	2018-10-08 08:00:00	2018-10-08 16:00:00	999999999	999999999	poissaolo	999999999
3	Näyttämöharjoitus	2018-10-03 18:00:00	2018-10-03 21:00:00	2	1	harjoitus	2
\.


--
-- Data for Name: subeventcast; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subeventcast (id, subeventid, userid, workroleid) FROM stdin;
1	6	3	18
2	6	5	16
3	6	6	17
4	6	4	14
5	6	2	15
6	2	1	1
7	2	10	10
8	2	4	2
9	2	2	3
10	2	5	4
11	2	6	5
12	2	7	6
13	2	3	8
14	2	3	9
15	2	8	7
16	2	9	11
18	7	10	10
17	7	6	5
19	7	4	2
20	7	5	4
21	7	1	1
22	7	2	3
23	7	7	6
24	7	3	9
25	7	8	11
26	7	3	8
27	7	9	7
28	8	6	5
29	8	1	1
30	8	4	2
31	8	10	10
32	8	5	4
33	8	2	3
34	8	8	7
35	8	3	8
36	8	7	6
37	8	9	11
38	8	3	9
39	8	10	10
40	8	1	1
41	8	4	2
42	8	2	3
43	8	6	5
44	8	7	6
45	8	5	4
46	8	8	7
47	8	9	11
48	8	3	8
49	8	3	9
50	9	10	10
51	9	1	1
52	9	4	2
53	9	5	4
54	9	2	3
55	9	6	5
56	9	7	6
57	9	3	9
58	9	8	11
59	9	3	8
60	9	9	7
61	10	1	1
62	10	10	10
63	10	4	2
64	10	5	4
65	10	2	3
66	10	6	5
67	10	3	9
68	10	8	7
69	10	7	6
70	10	3	8
71	10	9	11
72	11	4	2
73	11	5	4
74	11	2	3
75	11	10	10
76	11	1	1
77	11	6	5
78	11	9	7
79	11	7	6
80	11	3	8
81	11	3	9
82	11	8	11
83	12	10	10
84	12	1	1
85	12	2	3
86	12	4	2
87	12	6	5
88	12	5	4
89	12	7	6
90	12	3	8
91	12	8	7
92	12	3	9
93	12	9	11
99	15	1	98
98	15	1	94
102	16	1	98
103	16	1	94
106	3	3	13
107	3	1	12
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, name, userlevel, email, addressid, phonenumber, picurl) FROM stdin;
1	Pirjo Leppänen	1	pirjotuulia74@gmail.com	0	040-5865574	https://www.pirjoleppanen.com/26678277_10214106185141630_537142874110265524_o.jpg
2	Mari Hautaniemi	0		0		
3	Vikke Häkkinen	0		0		
4	Emmi Kaijansinkko	0		0		
5	Viivi Tulkki	0		0		
6	Petteri Loukio	0		0		
7	Kimmo Turunen	0		0		
8	Ronnie Karlsson	0		0		
9	Aapo-Tapani Kilpelä	0		0		
10	Tiina Korhonen	0		0		
11	Mikko Kallio	1	mikko.m.kallio@gmail.com	\N	\N	\N
\.


--
-- Data for Name: userrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userrole (id, roleid, userid) FROM stdin;
1	26	9
2	31	9
3	22	2
4	27	3
5	29	3
6	21	4
7	32	1
8	20	1
9	23	5
10	24	6
11	25	7
12	26	8
13	31	8
14	14	10
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work (id, work, composer, instrumentation, musicians, durationinminutes) FROM stdin;
1	Carmen	Georges Bizet	2s, 2ms, 2t, 3bar, 1bs, pf	10	180
2	1 Que cherchez-vous, la belle?	Georges Bizet	1s, 1bar, pf	3	4
4	3 C'est bien là, n'est-ce pas	Georges Bizet	1t, 1bs, pf	3	3
3	14 Nous avons en tête une affaire!	Georges Bizet	1s, 2ms, 1t, 1bar, pf	5	10
5	4 Quand je vous aimerai?	Georges Bizet	1ms, kuoro, pf	10	6
6	6 Parle moi de ma mère!	Georges Bizet	1s, 1t, pf	3	8
7	8a Mon officier; c'était une querelle	Georges Bizet	1t, 1bs, pf	3	2
8	8b Tra la, la, la	Georges Bizet	1ms, 1bs, pf	3	4
10	10 Le lieutenant!.. Prenez garde!	Georges Bizet	1ms, 1t, 1bs, pf	4	6
9	9 Près des remparts de Séville	Georges Bizet	1ms, 1t, pf	3	7
11	11 Les tringles des sistres tintaient	Georges Bizet	1s, 2ms, pf	4	6
12	12a Messieurs, Pastia me dit...	Georges Bizet	1s, 2ms, 1bs, pf	5	5
13	12b Vivat! vivat le torero!	Georges Bizet	1s, 2ms, 1bs, kuoro, pf	10	3
14	13 Votre toast	Georges Bizet	1bar, kuoro, pf	10	7
999999999	Poissaolo	\N	\N	10	\N
\.


--
-- Data for Name: workrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workrole (id, workid, roleid, number) FROM stdin;
1	1	20	1
2	1	21	1
3	1	22	1
4	1	23	1
5	1	24	1
6	1	25	1
7	1	26	1
8	1	27	1
9	1	29	1
10	1	14	1
11	1	31	1
12	2	20	1
13	2	29	1
14	3	21	1
15	3	22	1
16	3	23	1
17	3	24	1
18	3	27	1
19	5	21	1
20	5	22	1
21	5	23	1
22	5	24	1
23	5	26	1
24	5	27	1
25	5	29	1
26	5	14	1
27	5	31	1
28	4	25	1
29	4	31	1
30	6	20	1
31	6	25	1
32	6	14	1
33	7	25	1
34	7	31	1
35	8	22	1
36	8	31	1
37	9	22	1
38	9	25	1
39	10	22	1
40	10	25	1
41	10	14	1
42	10	31	1
43	9	14	1
44	8	14	1
45	7	14	1
46	11	21	1
47	11	22	1
48	11	23	1
49	12	21	1
50	12	22	1
51	12	23	1
52	12	14	1
53	12	31	1
55	13	22	1
57	13	31	1
58	13	20	1
59	13	21	1
61	13	23	1
62	13	24	1
63	13	25	1
64	13	27	2
65	13	29	1
67	13	14	1
68	14	20	1
69	14	21	1
70	14	22	1
71	14	23	1
72	14	24	1
73	14	25	1
74	14	26	1
75	14	27	1
76	14	14	1
77	14	31	1
94	999999999	32	1
96	999999999	15	1
97	999999999	16	1
98	999999999	20	1
99	999999999	21	1
100	999999999	22	1
101	999999999	23	1
102	999999999	24	1
103	999999999	25	1
104	999999999	26	1
105	999999999	27	1
106	999999999	29	1
107	999999999	31	1
95	999999999	14	1
\.


--
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_id_seq', 6, true);


--
-- Name: appuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appuser_id_seq', 3, true);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_id_seq', 2, true);


--
-- Name: eventwork_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eventwork_id_seq', 16, true);


--
-- Name: place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.place_id_seq', 8, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_seq', 32, true);


--
-- Name: rolecategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rolecategory_id_seq', 10, true);


--
-- Name: subevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subevent_id_seq', 16, true);


--
-- Name: subeventcast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subeventcast_id_seq', 107, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 11, true);


--
-- Name: userrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userrole_id_seq', 14, true);


--
-- Name: work_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_id_seq', 15, true);


--
-- Name: workrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.workrole_id_seq', 107, true);


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

