--
-- PostgreSQL database dump
--

-- Dumped from database version 17.3 (Debian 17.3-3.pgdg120+1)
-- Dumped by pg_dump version 17.4

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

--
-- Name: payment_name_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.payment_name_enum AS ENUM (
    'default',
    'fallback'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id uuid NOT NULL,
    amount double precision NOT NULL,
    requested_at timestamp(0) without time zone NOT NULL,
    provider public.payment_name_enum DEFAULT 'default'::public.payment_name_enum NOT NULL,
    timing integer NOT NULL,
    message character varying(255)
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: payments_requested_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payments_requested_at_index ON public.payments USING btree (requested_at);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20250717125031);
INSERT INTO public."schema_migrations" (version) VALUES (20250717193209);
INSERT INTO public."schema_migrations" (version) VALUES (20250718071953);
INSERT INTO public."schema_migrations" (version) VALUES (20250718202831);
INSERT INTO public."schema_migrations" (version) VALUES (20250718203148);
