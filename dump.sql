--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: article; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.article (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone,
    category_id integer,
    media_filename character varying(255),
    user_id integer,
    author_id integer
);


ALTER TABLE public.article OWNER TO postgres;

--
-- Name: article_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.article_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.article_id_seq OWNER TO postgres;

--
-- Name: article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.article_id_seq OWNED BY public.article.id;


--
-- Name: article_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.article_tag (
    article_id integer,
    tag_id integer
);


ALTER TABLE public.article_tag OWNER TO postgres;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_id_seq OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(80) NOT NULL,
    email character varying(256) NOT NULL,
    password_hash character varying(256),
    articles_count integer NOT NULL,
    age integer NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: article id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article ALTER COLUMN id SET DEFAULT nextval('public.article_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
b0732a6301c7
\.


--
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.article (id, title, content, created_at, category_id, media_filename, user_id, author_id) FROM stdin;
4	123	text	2025-04-10 12:06:40.191278	\N	\N	\N	\N
5	1234	text	2025-04-10 12:07:28.085297	\N	Screenshot_2025-03-30_212641.png	\N	\N
6	«Я тоже жду, когда он вернется». Соняша – о карьере Дурачья, отношениях и свадьбе	1 апреля Дурачье и его девушка Соняша стали амбассадорами BetBoom. Антон подметил вклад Жени в подписание: «Рад возможности снова поработать с BetBoom. Отдельно хочу поблагодарить моего босса Евгению (по совместительству девушку) – без нее бы этого соглашения не состоялось. Впереди нас ждет много приколов, проектов и активностей».\r\n\r\n\r\nМы поговорили с Соняшей:\r\n\r\n➤ Как начала играть в Доту;\r\n\r\n➤ Об отношениях с Антоном;\r\n\r\n➤ Насколько влияют девушки на игроков во время турниров;\r\n\r\n➤ И когда ждать свадьбу.	2025-04-10 12:10:48.390911	\N	Screenshot_2024-11-26_165353.png	\N	\N
7	IQ как у зомби или эндермена?	3 апреля в мировой прокат выйдет «Minecraft в кино». Джейсон Момоа и Эмма Майерс попадут фэнтези-мир известной песочницы и попробуют из него выбраться. Нас ждет безумное зрелище!\r\n\r\nВместе с BetBoom мы подготовили для вас интеллектуальный тест – знания «Майнкрафта» вам пригодятся, но ничего не решают. Проходите тест и держите фрибет – 1000 ₽ для новых пользователей!	2025-04-10 12:14:21.614959	\N	Screenshot_2025-03-26_151645.png	\N	\N
8	unreal)	eto ya	2025-04-11 10:56:03.268535	\N	\N	\N	\N
9	satoru	gojo	2025-04-11 10:56:26.31136	\N	Screenshot_2025-02-28_181142.png	\N	\N
10	skorost	ineta\r\n	2025-04-11 10:57:09.716228	\N	Screenshot_2025-01-30_011746.png	\N	\N
11	ыввфыв	выфвфывф	2025-05-14 18:16:28.408104	\N	\N	\N	\N
12	wdawdawd	<b>dsadasdasdasdasdasdasd</b><i>dsadasdasd</i><h1>dsadasdadadasd</h1>\r\n	2025-05-21 18:48:51.272935	\N	\N	\N	\N
13	dasdasd	<b>dsadasdsadsd</b><b></b>	2025-05-21 18:49:28.731859	\N	\N	\N	\N
14	вфывфвфцывфы	<i>выфвыфывфыв</i>	2025-05-21 18:56:29.967842	\N	\N	\N	\N
15	123	12314	2025-05-22 14:34:27.207797	\N	\N	19	\N
22	123123123123	asdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	2025-05-25 13:25:09.799077	\N	\N	19	19
23	qewqew	asdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\r\nasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\r\nasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\r\nasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa	2025-05-25 13:26:21.741621	\N	\N	19	19
27	1231	12312312341	2025-05-30 15:11:06.607407	\N	\N	19	19
28	123123123	123123123	2025-05-30 15:11:09.981788	\N	\N	19	19
29	1231231	1231231	2025-05-30 15:11:12.732339	\N	\N	19	19
30	123213123	123123123	2025-05-30 15:11:15.996648	\N	\N	19	19
31	фывфыв	выфвыв	2025-05-30 15:19:48.337356	\N	\N	19	19
\.


--
-- Data for Name: article_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.article_tag (article_id, tag_id) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, name) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, articles_count, age, created_at) FROM stdin;
1	evor1	samsongiraffe@gmail.com	scrypt:32768:8:1$XbCUUHF3o41WQqSJ$4f35b1b81e0a3e44257db778deabb6b798795cfcf13747105a1f2b0d573e92280aeb7b53a0feda3d7ac877370c460870b4fcff70f033b4dfba652c22fe30422e	0	0	\N
2	evor2	samsongiraffe2@gmail.com	scrypt:32768:8:1$lNLvkTFkUlaer4xt$31d896114e4ce2dfd5cf87826cf615b833260fb6ce447c54ef19e31b0a216a9c05cee22ecf289bb2c66277b81518c88f74b50ae35b7deb43835c1c54b414cc0b	0	0	\N
3	evor	samsongiraffe3@gmail.com	scrypt:32768:8:1$JQx8DfJmKUkGfgLL$84c92fd85c5a19a2aefba0185219ea43fe24706679ce7797e2f01a5e269666d5c0b47778667d38143c9cc010421f36cd139b2ae5ac8770abf00b196596e60b8b	0	0	\N
4	evor4	samsongiraffe4@gmail.com	scrypt:32768:8:1$2xePNbA4MEsQ7wLd$783ccdc714ce07ba758d1016c9215cce2ddc3ea3ac198f814974e4eb74d39e9cc36c2ad125a4aa3b0bb62731000430c4210d9e250b778cf23fdcf66eda7b9d0c	0	0	\N
5	evor5	samsongiraffe5@gmail.com	scrypt:32768:8:1$jO5ytaBb4holDNwH$cb5b5d457cc7a01ec10a63780dd9fae9e3b041a06fa6a4008f5bfb81eb76191a9c60b21d7b6c2a14e68bc81ae08faa16d89c322c5005803ed93737f27459423f	0	0	\N
6	evor6	samsongiraffe6@gmail.com	scrypt:32768:8:1$vqABdvy6fypiHJRg$7039e41743230fa0cfa850fe5c6ad01506ac00cace4504c4fd855051d5a06300874cb339b5011d543fd05b814806a6b6fc394bfcab4878c24399715f956ea98c	0	0	\N
7	evor7	samsongiraffe7@gmail.com	scrypt:32768:8:1$pK7bY7lCajqfwyyu$5cae74377127217667f2e3109fc2f9f5167aade211f664b517ebaee1b0642797f916449c9bedc33aa27676e68644b87116f9dc1bb52ed1ec858a0f1cb8455747	0	0	\N
8	evor8	samsongiraffe8@gmail.com	scrypt:32768:8:1$W4jRx2K8MXuThLaU$15a27d0b91e4025a30e1dbc542e84399bf528d11e7a3c21e7c3497fe67951756b924b95df337490034b5d7795315ad189c4570a58b9c0a7db85e01c425da332f	0	0	\N
9	evor10	samsongiraffe10@gmail.com	\N	0	0	\N
10	evor11	samsongiraffe11@gmail.com	\N	0	0	\N
11	evor12	samsongiraffe12@gmail.com	scrypt:32768:8:1$qHeuSLJzILUiBVOh$0c8642d03d40476261bcd053c7458f2945241cf806d8ab3f6ee930a943ccb5a3ba0cf50cb9fe4ceb4d6eb47c95228b536fb6e606c2ceaf74a55ac4039f805ee2	0	0	\N
12	evor13	samsongiraffe13@gmail.com	scrypt:32768:8:1$zhUS1iplRt4j2wJ1$b5c735af9ad502310f09767aa4fa68aeaf80ab411402310e6ff2908a13c6a30e1c9342236010af3cf00225f4b289c2a134e7aaecdff1439c116c32bef9928d1e	0	0	\N
13	evor14	samsongiraffe14@gmail.com	scrypt:32768:8:1$3ISPAutRdlEWfsO6$80e5e4e56c59b399be45e5abac413a95c4cdd026b712d50d922b892f790e1f107bd70ff774cb523d5ad054d3ad400d33d9b7aecb9bbb962b1d3af060c339ee51	0	0	\N
14	evor15	samsongiraffe15@gmail.com	scrypt:32768:8:1$JQ0ONnAnQuyurm1V$6325ca1caf0bbaaa3401cff5b1753c9fee1c67d826b237501e3272192db94a0198af78d07b66ea7cd7d02ded504f9da88e951798b1da3c1ad193812ed072b270	0	0	\N
15	evor16	samsongiraffe16@gmail.com	scrypt:32768:8:1$5mb3igyX5ehdKViY$469b24e6f33180819f26d371890aa40626028a0d948d20fb4b3e558e5e9cd2cada6ea51481f6aa749490453df1bd97415f15543a0ee1299a13d00560284e3fec	0	0	\N
16	evor17	samsongiraffe17@gmail.com	scrypt:32768:8:1$QVLRZUZ5LhLQwZOx$1b38163267077414c5b622e53196b7679b11b2ce4c15dbd1fbdbe46c00df5ae4947fef086be258c6e5d4a73433c742548bc4a1c0d18eefdf50e093a57d9326cc	0	0	\N
17	evor18	samsongiraffe18@gmail.com	scrypt:32768:8:1$AeGIDngtFqTCWWGF$66b3fbd5cc987d828936a1c23cc1c780bcd9790ec5ef41c5eb50c22d16fc4425552290bc823290b3298789d2c8767dee7e386d2f9295d71f198417ead9783714	0	0	\N
18	evor19	samsongiraffe19@gmail.com	scrypt:32768:8:1$xvRr1cn0G5SEeF8z$4edc095715e265b922a77653832554168d2943ae11bf754d8b5c7605f54096ca08eb98dd27af16199269035213d043bbe8443d9acdaf85d0f2a8c277ca313b2e	0	0	\N
19	evor20	samsongiraffe20@gmail.com	scrypt:32768:8:1$wU2xdC4TndXsoQbm$0fe19fc019a7ff6e58b1b63651096ca0309ecb3d2ed53e5aab10ea5a6eb5084b34ed9862c2e71066f435de108e7f9f1881933b3a71f3a60dde697d0cecc5f2da	0	0	\N
20	evor21	samsongiraffe21@gmail.com	scrypt:32768:8:1$mKI7jPzwzIhJI8nb$40d7a1958d329fd06be099158f765dc1aeb68877895be5115841e517a62b16d33f283a8490a795613b1b07c1079243a32c08aa51a46f5b721ad36a8e3c6f12e6	0	0	2025-05-30 15:11:43.087082
\.


--
-- Name: article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.article_id_seq', 31, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 20, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: article article_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: article article_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: article article_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: article_tag article_tag_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article_tag
    ADD CONSTRAINT article_tag_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.article(id);


--
-- Name: article_tag article_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article_tag
    ADD CONSTRAINT article_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: article article_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

