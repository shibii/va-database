--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

-- Started on 2020-11-13 15:21:55

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
-- TOC entry 206 (class 1259 OID 18371)
-- Name: hides; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hides (
    user_id integer NOT NULL,
    vacancy_id integer NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 19409)
-- Name: pins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pins (
    user_id integer NOT NULL,
    vacancy_id integer NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 18251)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    pwhash text NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 18249)
-- Name: user_uid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_uid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2863 (class 0 OID 0)
-- Dependencies: 204
-- Name: user_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_uid_seq OWNED BY public.users.id;


--
-- TOC entry 203 (class 1259 OID 16455)
-- Name: vacancies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vacancies (
    id integer NOT NULL,
    url text NOT NULL,
    header text DEFAULT 'NO VACANCY HEADER'::text,
    ts timestamp without time zone DEFAULT now() NOT NULL,
    contents text NOT NULL,
    source text NOT NULL,
    tscontents tsvector
);


--
-- TOC entry 202 (class 1259 OID 16453)
-- Name: vacancy_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vacancy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2864 (class 0 OID 0)
-- Dependencies: 202
-- Name: vacancy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vacancy_id_seq OWNED BY public.vacancies.id;


--
-- TOC entry 2706 (class 2604 OID 18254)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.user_uid_seq'::regclass);


--
-- TOC entry 2703 (class 2604 OID 16458)
-- Name: vacancies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vacancies ALTER COLUMN id SET DEFAULT nextval('public.vacancy_id_seq'::regclass);


--
-- TOC entry 2714 (class 2606 OID 18261)
-- Name: users unique email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "unique email" UNIQUE (email);


--
-- TOC entry 2709 (class 2606 OID 16467)
-- Name: vacancies uniqueurl; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vacancies
    ADD CONSTRAINT uniqueurl UNIQUE (url);


--
-- TOC entry 2716 (class 2606 OID 18259)
-- Name: users user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 2712 (class 2606 OID 16463)
-- Name: vacancies vacancy_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vacancies
    ADD CONSTRAINT vacancy_pkey PRIMARY KEY (id);


--
-- TOC entry 2717 (class 1259 OID 24958)
-- Name: hides_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX hides_user_id_index ON public.hides USING btree (user_id);


--
-- TOC entry 2718 (class 1259 OID 24959)
-- Name: hides_vacancy_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX hides_vacancy_id_index ON public.hides USING btree (vacancy_id);


--
-- TOC entry 2719 (class 1259 OID 24956)
-- Name: pins_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pins_user_id_index ON public.pins USING btree (user_id);


--
-- TOC entry 2720 (class 1259 OID 24957)
-- Name: pins_vacancy_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX pins_vacancy_id_index ON public.pins USING btree (vacancy_id);


--
-- TOC entry 2707 (class 1259 OID 19303)
-- Name: tscontents_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX tscontents_gin ON public.vacancies USING gin (tscontents);


--
-- TOC entry 2710 (class 1259 OID 24960)
-- Name: vacancies_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vacancies_id_index ON public.vacancies USING btree (id);


--
-- TOC entry 2725 (class 2620 OID 18393)
-- Name: vacancies tscontents_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tscontents_update BEFORE INSERT OR UPDATE ON public.vacancies FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('tscontents', 'pg_catalog.finnish', 'contents');


--
-- TOC entry 2721 (class 2606 OID 18374)
-- Name: hides hide_user-id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hides
    ADD CONSTRAINT "hide_user-id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2722 (class 2606 OID 18379)
-- Name: hides hide_vacancy-id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hides
    ADD CONSTRAINT "hide_vacancy-id_fkey" FOREIGN KEY (vacancy_id) REFERENCES public.vacancies(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2723 (class 2606 OID 19422)
-- Name: pins pins_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pins
    ADD CONSTRAINT pins_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2724 (class 2606 OID 19427)
-- Name: pins pins_vacancy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pins
    ADD CONSTRAINT pins_vacancy_id_fkey FOREIGN KEY (vacancy_id) REFERENCES public.vacancies(id) ON UPDATE RESTRICT ON DELETE CASCADE NOT VALID;


-- Completed on 2020-11-13 15:21:55

--
-- PostgreSQL database dump complete
--

