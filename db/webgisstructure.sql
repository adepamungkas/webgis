--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

-- Started on 2020-07-28 04:00:27

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
-- TOC entry 15 (class 2615 OID 23274)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- TOC entry 18 (class 2615 OID 23544)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- TOC entry 12 (class 2615 OID 23049)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 12
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- TOC entry 3 (class 3079 OID 23224)
-- Name: address_standardizer; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS address_standardizer WITH SCHEMA public;


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION address_standardizer; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer IS 'Used to parse an address into constituent elements. Generally used to support geocoding address normalization step.';


--
-- TOC entry 2 (class 3079 OID 23231)
-- Name: address_standardizer_data_us; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS address_standardizer_data_us WITH SCHEMA public;


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION address_standardizer_data_us; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer_data_us IS 'Address Standardizer US dataset example';


--
-- TOC entry 4 (class 3079 OID 23213)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 7 (class 3079 OID 21453)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- TOC entry 6 (class 3079 OID 22455)
-- Name: postgis_raster; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_raster WITH SCHEMA public;


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION postgis_raster; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_raster IS 'PostGIS raster types and functions';


--
-- TOC entry 5 (class 3079 OID 23193)
-- Name: postgis_sfcgal; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_sfcgal WITH SCHEMA public;


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis_sfcgal; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_sfcgal IS 'PostGIS SFCGAL functions';


--
-- TOC entry 9 (class 3079 OID 23275)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 9
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 8 (class 3079 OID 23050)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 296 (class 1259 OID 23761)
-- Name: tbl_lines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_lines (
    id integer NOT NULL,
    name text,
    geom public.geometry(LineString,4326),
    line_len double precision
);


ALTER TABLE public.tbl_lines OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 23759)
-- Name: tbl_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_lines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_lines_id_seq OWNER TO postgres;

--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 295
-- Name: tbl_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_lines_id_seq OWNED BY public.tbl_lines.id;


--
-- TOC entry 294 (class 1259 OID 23750)
-- Name: tbl_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_points (
    id integer NOT NULL,
    name character varying(64),
    geom public.geometry(Point,4326)
);


ALTER TABLE public.tbl_points OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 23748)
-- Name: tbl_points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_points_id_seq OWNER TO postgres;

--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 293
-- Name: tbl_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_points_id_seq OWNED BY public.tbl_points.id;


--
-- TOC entry 292 (class 1259 OID 23723)
-- Name: tbl_polygon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_polygon (
    id integer NOT NULL,
    geom public.geometry(Polygon,4326),
    n_hood character varying(3),
    name character varying(30),
    description character varying(150),
    shape_area double precision,
    shape_len double precision
);


ALTER TABLE public.tbl_polygon OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 23721)
-- Name: tbl_polygon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_polygon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_polygon_id_seq OWNER TO postgres;

--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 291
-- Name: tbl_polygon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_polygon_id_seq OWNED BY public.tbl_polygon.id;


--
-- TOC entry 4655 (class 2604 OID 23764)
-- Name: tbl_lines id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_lines ALTER COLUMN id SET DEFAULT nextval('public.tbl_lines_id_seq'::regclass);


--
-- TOC entry 4654 (class 2604 OID 23753)
-- Name: tbl_points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_points ALTER COLUMN id SET DEFAULT nextval('public.tbl_points_id_seq'::regclass);


--
-- TOC entry 4653 (class 2604 OID 23726)
-- Name: tbl_polygon id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_polygon ALTER COLUMN id SET DEFAULT nextval('public.tbl_polygon_id_seq'::regclass);


--
-- TOC entry 4786 (class 2606 OID 23758)
-- Name: tbl_points tbl_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_points
    ADD CONSTRAINT tbl_points_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 23728)
-- Name: tbl_polygon tbl_polygon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_polygon
    ADD CONSTRAINT tbl_polygon_pkey PRIMARY KEY (id);


--
-- TOC entry 4782 (class 1259 OID 23747)
-- Name: sidx_tbl_polygon_geom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sidx_tbl_polygon_geom ON public.tbl_polygon USING gist (geom);


-- Completed on 2020-07-28 04:00:29

--
-- PostgreSQL database dump complete
--

