--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)

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
-- Name: buildings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.buildings (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    locations json DEFAULT '{}'::json
);


ALTER TABLE public.buildings OWNER TO admin;

--
-- Name: buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.buildings_id_seq OWNER TO admin;

--
-- Name: buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.buildings_id_seq OWNED BY public.buildings.id;


--
-- Name: sensor_data; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sensor_data (
    id integer NOT NULL,
    sensor_id character varying(255),
    data json NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sensor_data OWNER TO admin;

--
-- Name: sensor_data_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sensor_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensor_data_id_seq OWNER TO admin;

--
-- Name: sensor_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.sensor_data_id_seq OWNED BY public.sensor_data.id;


--
-- Name: sensor_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sensor_types (
    id integer NOT NULL,
    type character varying(100) NOT NULL
);


ALTER TABLE public.sensor_types OWNER TO admin;

--
-- Name: sensor_types_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sensor_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sensor_types_id_seq OWNER TO admin;

--
-- Name: sensor_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.sensor_types_id_seq OWNED BY public.sensor_types.id;


--
-- Name: sensors; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sensors (
    id character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(255),
    latest_data json DEFAULT '{}'::json,
    last_updated timestamp without time zone,
    building_id integer NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.sensors OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    building_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: buildings id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.buildings ALTER COLUMN id SET DEFAULT nextval('public.buildings_id_seq'::regclass);


--
-- Name: sensor_data id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensor_data ALTER COLUMN id SET DEFAULT nextval('public.sensor_data_id_seq'::regclass);


--
-- Name: sensor_types id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensor_types ALTER COLUMN id SET DEFAULT nextval('public.sensor_types_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.buildings (id, name, locations) FROM stdin;
1	FASADA	{\n  "locations": [\n    "Kitchen",\n    "Classroom 1",\n    "Classroom 2",\n    "Classroom 3",\n    "Classroom 4",\n    "Classroom 5",\n    "Checkroom",\n    "Vice Director Office",\n    "Director Office",\n    "Corridor",\n    "Office 1st Floor",\n    "Kindergarten",\n    "Bathroom",\n    "Social room",\n    "Staff toilet",\n    "Office room 1",\n    "Office room 2",\n    "Office room 3"\n  ]\n}
\.


--
-- Data for Name: sensor_data; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sensor_data (id, sensor_id, data, "timestamp") FROM stdin;
1	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.1, "a_act_power": 0, "a_aprt_power": 6.8, "a_pf": 0, "a_freq": 50, "b_current": 0.09, "b_voltage": 233.9, "b_act_power": 9.1, "b_aprt_power": 21, "b_pf": 0.44, "b_freq": 50, "c_current": 0.029, "c_voltage": 235.6, "c_act_power": 0, "c_aprt_power": 6.8, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.147, "total_act_power": 9.084, "total_aprt_power": 34.587, "a_total_act_energy": 8340015.74, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.719999999, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.08, "c_total_act_ret_energy": 17.85, "total_act": 27680697.55, "total_act_ret": 333.64}	2025-07-26 11:00:06
2	70:ee:50:83:35:00	{"temperature": 23.5, "humidity": 68, "Pressure": 1008.8, "AbsolutePressure": 1005.9, "Noise": 32, "CO2": 525}	2025-07-26 10:59:41
3	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.3, "Battery": 84}	2025-07-26 11:00:07.907
4	70:ee:50:83:2a:6c	{"temperature": 23.6, "humidity": 67, "Pressure": 1011.5, "AbsolutePressure": 1005.9, "Noise": 32, "CO2": 464}	2025-07-26 10:50:39
5	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 68}	2025-07-26 11:00:09.146
6	70:ee:50:83:2a:36	{"temperature": 24.3, "humidity": 66, "Pressure": 1011.4, "AbsolutePressure": 1005.8, "Noise": 32, "CO2": 567}	2025-07-26 10:55:08
7	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 64, "Pressure": 1008.9, "AbsolutePressure": 1006, "Noise": 32, "CO2": 515}	2025-07-26 10:52:27
8	shellypro3em-08f9e0e5121c	{"a_current": 1.704, "a_voltage": 234.8, "a_act_power": 335.1, "a_aprt_power": 400.5, "a_pf": 0.83, "a_freq": 50, "b_current": 0.599, "b_voltage": 234.6, "b_act_power": -16.1, "b_aprt_power": 140.6, "b_pf": 0.15, "b_freq": 50, "c_current": 0.853, "c_voltage": 236.2, "c_act_power": -132.7, "c_aprt_power": 201.8, "c_pf": 0.66, "c_freq": 50, "n_current": null, "total_current": 3.156, "total_act_power": 186.226, "total_aprt_power": 742.903, "a_total_act_energy": 9418431.639999999, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362766.8899999997, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945374.8099999996, "total_act": 29611562.38, "total_act_ret": 9244537.84}	2025-07-26 11:00:13
9	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-26 11:00:14.105
10	shellypro3em-34987a45dcd4	{"a_current": 1.004, "a_voltage": 236.5, "a_act_power": -202.4, "a_aprt_power": 237.7, "a_pf": 0.85, "a_freq": 50, "b_current": 1.028, "b_voltage": 235, "b_act_power": -203.2, "b_aprt_power": 242, "b_pf": 0.84, "b_freq": 50, "c_current": 1.037, "c_voltage": 234.8, "c_act_power": -207.6, "c_aprt_power": 243.5, "c_pf": 0.85, "c_freq": 50, "n_current": null, "total_current": 3.069, "total_act_power": -613.184, "total_aprt_power": 723.204, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794418.21, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792880.09, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809887.39, "total_act": 3519.58, "total_act_ret": 2397185.69}	2025-07-26 11:00:15
11	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.6, "a_act_power": 0, "a_aprt_power": 6.7, "a_pf": 0, "a_freq": 50, "b_current": 0.091, "b_voltage": 234.4, "b_act_power": 8.7, "b_aprt_power": 21.4, "b_pf": 0.4, "b_freq": 50, "c_current": 0.029, "c_voltage": 236, "c_act_power": 0, "c_aprt_power": 6.8, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.149, "total_act_power": 8.731, "total_aprt_power": 34.907, "a_total_act_energy": 8340015.74, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.719999999, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.08, "c_total_act_ret_energy": 17.85, "total_act": 27680697.55, "total_act_ret": 333.64}	2025-07-26 11:00:16
12	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-07-26 11:00:16.956
13	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 58}	2025-07-26 11:00:20.338
14	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 49}	2025-07-26 11:00:21.88
15	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 75}	2025-07-26 11:00:22.583
16	shellypro3em-08f9e0e5121c	{"a_current": 1.735, "a_voltage": 234.2, "a_act_power": 337.7, "a_aprt_power": 406.8, "a_pf": 0.83, "a_freq": 50, "b_current": 0.616, "b_voltage": 233.7, "b_act_power": -12.1, "b_aprt_power": 144.2, "b_pf": 0.07, "b_freq": 50, "c_current": 0.875, "c_voltage": 235.4, "c_act_power": -130.6, "c_aprt_power": 206.1, "c_pf": 0.63, "c_freq": 50, "n_current": null, "total_current": 3.226, "total_act_power": 195.075, "total_aprt_power": 757.034, "a_total_act_energy": 9418431.639999999, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362766.8899999997, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945374.8099999996, "total_act": 29611562.38, "total_act_ret": 9244537.84}	2025-07-26 11:00:23
17	shellypro3em-34987a45dcd4	{"a_current": 1.015, "a_voltage": 235.6, "a_act_power": -202.3, "a_aprt_power": 239.4, "a_pf": 0.84, "a_freq": 50, "b_current": 1.036, "b_voltage": 234.3, "b_act_power": -202.2, "b_aprt_power": 243.1, "b_pf": 0.83, "b_freq": 50, "c_current": 1.045, "c_voltage": 233.9, "c_act_power": -206.5, "c_aprt_power": 244.6, "c_pf": 0.85, "c_freq": 50, "n_current": null, "total_current": 3.096, "total_act_power": -610.913, "total_aprt_power": 727.09, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794418.21, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792880.09, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809887.39, "total_act": 3519.58, "total_act_ret": 2397185.69}	2025-07-26 11:00:25
18	shellypro3em-34987a46bc6c	{"a_current": 0.028, "a_voltage": 234.6, "a_act_power": 0, "a_aprt_power": 6.6, "a_pf": 0, "a_freq": 50, "b_current": 0.091, "b_voltage": 234.3, "b_act_power": 8.7, "b_aprt_power": 21.2, "b_pf": 0.41, "b_freq": 50, "c_current": 0.029, "c_voltage": 235.9, "c_act_power": 0, "c_aprt_power": 6.8, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.148, "total_act_power": 8.68, "total_aprt_power": 34.638, "a_total_act_energy": 8340015.74, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.719999999, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.08, "c_total_act_ret_energy": 17.85, "total_act": 27680697.55, "total_act_ret": 333.64}	2025-07-26 11:00:26
19	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-26 11:00:27.322
20	shellypro3em-08f9e0e5121c	{"a_current": 1.967, "a_voltage": 234, "a_act_power": 406.4, "a_aprt_power": 460.7, "a_pf": 0.88, "a_freq": 50, "b_current": 0.592, "b_voltage": 233.8, "b_act_power": -8.2, "b_aprt_power": 138.8, "b_pf": 0.07, "b_freq": 50, "c_current": 0.849, "c_voltage": 235.6, "c_act_power": -124.8, "c_aprt_power": 200.3, "c_pf": 0.63, "c_freq": 50, "n_current": null, "total_current": 3.409, "total_act_power": 273.418, "total_aprt_power": 799.797, "a_total_act_energy": 9418431.639999999, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362766.8899999997, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945374.8099999996, "total_act": 29611562.38, "total_act_ret": 9244537.84}	2025-07-26 11:00:33
21	shellypro3em-34987a45dcd4	{"a_current": 0.993, "a_voltage": 236.2, "a_act_power": -198.7, "a_aprt_power": 234.8, "a_pf": 0.84, "a_freq": 50, "b_current": 1.01, "b_voltage": 234.6, "b_act_power": -198.1, "b_aprt_power": 237.3, "b_pf": 0.83, "b_freq": 50, "c_current": 1.023, "c_voltage": 234.3, "c_act_power": -203.1, "c_aprt_power": 239.7, "c_pf": 0.85, "c_freq": 50, "n_current": null, "total_current": 3.026, "total_act_power": -599.877, "total_aprt_power": 711.865, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794418.21, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792880.09, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809887.39, "total_act": 3519.58, "total_act_ret": 2397185.69}	2025-07-26 11:00:35
22	shellypro3em-34987a46bc6c	{"a_current": 0.028, "a_voltage": 234.3, "a_act_power": 0, "a_aprt_power": 6.6, "a_pf": 0, "a_freq": 50, "b_current": 0.089, "b_voltage": 234.1, "b_act_power": 8.7, "b_aprt_power": 20.9, "b_pf": 0.41, "b_freq": 50, "c_current": 0.03, "c_voltage": 236, "c_act_power": 0, "c_aprt_power": 7, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.147, "total_act_power": 8.714, "total_aprt_power": 34.503, "a_total_act_energy": 8340015.74, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.719999999, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.08, "c_total_act_ret_energy": 17.85, "total_act": 27680697.55, "total_act_ret": 333.64}	2025-07-26 11:00:36
23	shellypro3em-08f9e0e5121c	{"a_current": 1.98, "a_voltage": 234.2, "a_act_power": 408.4, "a_aprt_power": 464.1, "a_pf": 0.88, "a_freq": 50, "b_current": 0.592, "b_voltage": 233.9, "b_act_power": -12.2, "b_aprt_power": 138.6, "b_pf": 0.08, "b_freq": 50, "c_current": 0.857, "c_voltage": 235.5, "c_act_power": -125.5, "c_aprt_power": 202.1, "c_pf": 0.62, "c_freq": 50, "n_current": null, "total_current": 3.429, "total_act_power": 270.608, "total_aprt_power": 804.81, "a_total_act_energy": 9418431.639999999, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362766.8899999997, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945374.8099999996, "total_act": 29611562.38, "total_act_ret": 9244537.84}	2025-07-26 11:00:43
24	shellypro3em-34987a45dcd4	{"a_current": 0.997, "a_voltage": 236.2, "a_act_power": -197.3, "a_aprt_power": 235.9, "a_pf": 0.84, "a_freq": 50, "b_current": 1.019, "b_voltage": 234.7, "b_act_power": -196.8, "b_aprt_power": 239.5, "b_pf": 0.82, "b_freq": 50, "c_current": 1.029, "c_voltage": 234.3, "c_act_power": -201.2, "c_aprt_power": 241.1, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 3.045, "total_act_power": -595.335, "total_aprt_power": 716.441, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794418.21, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792880.09, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809887.39, "total_act": 3519.58, "total_act_ret": 2397185.69}	2025-07-26 11:00:45
25	shellypro3em-34987a46bc6c	{"a_current": 0.028, "a_voltage": 234.7, "a_act_power": 1.1, "a_aprt_power": 6.6, "a_pf": 0.12, "a_freq": 50, "b_current": 0.091, "b_voltage": 234.6, "b_act_power": 8.9, "b_aprt_power": 21.3, "b_pf": 0.42, "b_freq": 50, "c_current": 0.029, "c_voltage": 236.3, "c_act_power": 0, "c_aprt_power": 6.9, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.148, "total_act_power": 10.009, "total_aprt_power": 34.823, "a_total_act_energy": 8340015.74, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.719999999, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.08, "c_total_act_ret_energy": 17.85, "total_act": 27680697.55, "total_act_ret": 333.64}	2025-07-26 11:00:46
26	shellypro3em-08f9e0e5121c	{"a_current": 1.99, "a_voltage": 234.8, "a_act_power": 414, "a_aprt_power": 467.8, "a_pf": 0.89, "a_freq": 50, "b_current": 0.59, "b_voltage": 234.5, "b_act_power": -5.5, "b_aprt_power": 138.6, "b_pf": 0.02, "b_freq": 50, "c_current": 0.834, "c_voltage": 236.2, "c_act_power": -121.2, "c_aprt_power": 197.1, "c_pf": 0.61, "c_freq": 50, "n_current": null, "total_current": 3.414, "total_act_power": 287.364, "total_aprt_power": 803.464, "a_total_act_energy": 9418431.639999999, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362766.8899999997, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945374.8099999996, "total_act": 29611562.38, "total_act_ret": 9244537.84}	2025-07-26 11:00:53
27	shellypro3em-34987a45dcd4	{"a_current": 0.99, "a_voltage": 236.2, "a_act_power": -195, "a_aprt_power": 234.2, "a_pf": 0.83, "a_freq": 50, "b_current": 1.008, "b_voltage": 235, "b_act_power": -195.3, "b_aprt_power": 237.3, "b_pf": 0.82, "b_freq": 50, "c_current": 1.018, "c_voltage": 234.7, "c_act_power": -200.3, "c_aprt_power": 238.9, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 3.016, "total_act_power": -590.658, "total_aprt_power": 710.385, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794418.21, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792880.09, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809887.39, "total_act": 3519.58, "total_act_ret": 2397185.69}	2025-07-26 11:00:55
28	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.5, "a_act_power": 1, "a_aprt_power": 6.7, "a_pf": 0.13, "a_freq": 50, "b_current": 0.09, "b_voltage": 234.3, "b_act_power": 9.1, "b_aprt_power": 21, "b_pf": 0.42, "b_freq": 50, "c_current": 0.028, "c_voltage": 235.7, "c_act_power": 0, "c_aprt_power": 6.6, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.147, "total_act_power": 10.077, "total_aprt_power": 34.402, "a_total_act_energy": 8340015.74, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.719999999, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.08, "c_total_act_ret_energy": 17.85, "total_act": 27680697.55, "total_act_ret": 333.64}	2025-07-26 11:00:56
29	shellypro3em-08f9e0e5121c	{"a_current": 2, "a_voltage": 234.3, "a_act_power": 415.6, "a_aprt_power": 469, "a_pf": 0.88, "a_freq": 50, "b_current": 0.537, "b_voltage": 235, "b_act_power": -29.8, "b_aprt_power": 126.4, "b_pf": 0.24, "b_freq": 50, "c_current": 0.829, "c_voltage": 235.9, "c_act_power": -120.4, "c_aprt_power": 195.7, "c_pf": 0.6, "c_freq": 50, "n_current": null, "total_current": 3.365, "total_act_power": 265.36, "total_aprt_power": 791.083, "a_total_act_energy": 9418438.02, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.14, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945376.94, "total_act": 29611568.77, "total_act_ret": 9244540.209999999}	2025-07-26 11:01:03
30	shellypro3em-34987a45dcd4	{"a_current": 0.97, "a_voltage": 235.9, "a_act_power": -190.7, "a_aprt_power": 229.1, "a_pf": 0.84, "a_freq": 50, "b_current": 0.986, "b_voltage": 234.5, "b_act_power": -189.6, "b_aprt_power": 231.7, "b_pf": 0.82, "b_freq": 50, "c_current": 0.999, "c_voltage": 235.1, "c_act_power": -195.7, "c_aprt_power": 235, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 2.956, "total_act_power": -575.939, "total_aprt_power": 695.816, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794421.55, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792883.43, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809890.81, "total_act": 3519.58, "total_act_ret": 2397195.79}	2025-07-26 11:01:05
371	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-26 11:20:01.702
373	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.3, "Battery": 99}	2025-07-26 11:20:03.793
31	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.3, "a_act_power": 0, "a_aprt_power": 6.8, "a_pf": 0, "a_freq": 50, "b_current": 0.091, "b_voltage": 234.9, "b_act_power": 9.2, "b_aprt_power": 21.5, "b_pf": 0.42, "b_freq": 50, "c_current": 0.029, "c_voltage": 235.8, "c_act_power": 0, "c_aprt_power": 6.7, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.149, "total_act_power": 9.202, "total_aprt_power": 35.041, "a_total_act_energy": 8340015.76, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.870000001, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.09, "c_total_act_ret_energy": 17.85, "total_act": 27680697.72, "total_act_ret": 333.64}	2025-07-26 11:01:06
32	shellypro3em-08f9e0e5121c	{"a_current": 1.991, "a_voltage": 234.6, "a_act_power": 414.7, "a_aprt_power": 467.5, "a_pf": 0.89, "a_freq": 50, "b_current": 0.529, "b_voltage": 234.5, "b_act_power": -32.7, "b_aprt_power": 124.3, "b_pf": 0.25, "b_freq": 50, "c_current": 0.817, "c_voltage": 235.6, "c_act_power": -118.9, "c_aprt_power": 192.7, "c_pf": 0.62, "c_freq": 50, "n_current": null, "total_current": 3.337, "total_act_power": 263.156, "total_aprt_power": 784.539, "a_total_act_energy": 9418438.02, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.14, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945376.94, "total_act": 29611568.77, "total_act_ret": 9244540.209999999}	2025-07-26 11:01:13
33	shellypro3em-34987a45dcd4	{"a_current": 0.973, "a_voltage": 235.7, "a_act_power": -191.1, "a_aprt_power": 229.5, "a_pf": 0.83, "a_freq": 50, "b_current": 0.989, "b_voltage": 234.6, "b_act_power": -190.9, "b_aprt_power": 232.4, "b_pf": 0.82, "b_freq": 50, "c_current": 0.997, "c_voltage": 234.3, "c_act_power": -195.6, "c_aprt_power": 233.6, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 2.959, "total_act_power": -577.554, "total_aprt_power": 695.514, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794421.55, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792883.43, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809890.81, "total_act": 3519.58, "total_act_ret": 2397195.79}	2025-07-26 11:01:15
34	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 235, "a_act_power": 1.1, "a_aprt_power": 6.7, "a_pf": 0.13, "a_freq": 50, "b_current": 0.092, "b_voltage": 234.7, "b_act_power": 9, "b_aprt_power": 21.7, "b_pf": 0.42, "b_freq": 50, "c_current": 0.029, "c_voltage": 236.2, "c_act_power": 0, "c_aprt_power": 6.9, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.15, "total_act_power": 10.094, "total_aprt_power": 35.311, "a_total_act_energy": 8340015.76, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.870000001, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.09, "c_total_act_ret_energy": 17.85, "total_act": 27680697.72, "total_act_ret": 333.64}	2025-07-26 11:01:16
35	shellypro3em-08f9e0e5121c	{"a_current": 2, "a_voltage": 235.7, "a_act_power": 418.9, "a_aprt_power": 471.9, "a_pf": 0.89, "a_freq": 50, "b_current": 0.516, "b_voltage": 235.4, "b_act_power": -24.3, "b_aprt_power": 121.7, "b_pf": 0.2, "b_freq": 50, "c_current": 0.798, "c_voltage": 237.1, "c_act_power": -115.5, "c_aprt_power": 189.3, "c_pf": 0.61, "c_freq": 50, "n_current": null, "total_current": 3.314, "total_act_power": 279.07, "total_aprt_power": 782.974, "a_total_act_energy": 9418438.02, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.14, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945376.94, "total_act": 29611568.77, "total_act_ret": 9244540.209999999}	2025-07-26 11:01:23
36	shellypro3em-34987a45dcd4	{"a_current": 0.948, "a_voltage": 237.1, "a_act_power": -189, "a_aprt_power": 225, "a_pf": 0.84, "a_freq": 50, "b_current": 0.97, "b_voltage": 235.7, "b_act_power": -188.5, "b_aprt_power": 229.1, "b_pf": 0.82, "b_freq": 50, "c_current": 0.971, "c_voltage": 235.6, "c_act_power": -193.3, "c_aprt_power": 228.9, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 2.889, "total_act_power": -570.774, "total_aprt_power": 682.981, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794421.55, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792883.43, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809890.81, "total_act": 3519.58, "total_act_ret": 2397195.79}	2025-07-26 11:01:25
37	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 235.8, "a_act_power": 0, "a_aprt_power": 6.8, "a_pf": 0, "a_freq": 50, "b_current": 0.094, "b_voltage": 235.4, "b_act_power": 9.3, "b_aprt_power": 22.1, "b_pf": 0.42, "b_freq": 50, "c_current": 0.028, "c_voltage": 236.7, "c_act_power": 0, "c_aprt_power": 6.7, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.151, "total_act_power": 9.252, "total_aprt_power": 35.58, "a_total_act_energy": 8340015.76, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.870000001, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.09, "c_total_act_ret_energy": 17.85, "total_act": 27680697.72, "total_act_ret": 333.64}	2025-07-26 11:01:26
38	shellypro3em-08f9e0e5121c	{"a_current": 2.002, "a_voltage": 234.7, "a_act_power": 417.1, "a_aprt_power": 470.2, "a_pf": 0.89, "a_freq": 50, "b_current": 0.545, "b_voltage": 234.6, "b_act_power": -21.9, "b_aprt_power": 128.1, "b_pf": 0.18, "b_freq": 50, "c_current": 0.805, "c_voltage": 235.8, "c_act_power": -114.5, "c_aprt_power": 189.9, "c_pf": 0.61, "c_freq": 50, "n_current": null, "total_current": 3.352, "total_act_power": 280.736, "total_aprt_power": 788.24, "a_total_act_energy": 9418438.02, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.14, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945376.94, "total_act": 29611568.77, "total_act_ret": 9244540.209999999}	2025-07-26 11:01:33
39	shellypro3em-34987a45dcd4	{"a_current": 0.947, "a_voltage": 235.8, "a_act_power": -186, "a_aprt_power": 223.6, "a_pf": 0.83, "a_freq": 49.9, "b_current": 0.97, "b_voltage": 234.7, "b_act_power": -186, "b_aprt_power": 228.1, "b_pf": 0.82, "b_freq": 50, "c_current": 0.97, "c_voltage": 234.7, "c_act_power": -190.4, "c_aprt_power": 227.7, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 2.887, "total_act_power": -562.363, "total_aprt_power": 679.398, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794421.55, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792883.43, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809890.81, "total_act": 3519.58, "total_act_ret": 2397195.79}	2025-07-26 11:01:35
40	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 235, "a_act_power": 1.2, "a_aprt_power": 6.8, "a_pf": 0.18, "a_freq": 50, "b_current": 0.091, "b_voltage": 234.3, "b_act_power": 9.4, "b_aprt_power": 21.4, "b_pf": 0.42, "b_freq": 50, "c_current": 0.028, "c_voltage": 234.4, "c_act_power": 0, "c_aprt_power": 6.7, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.149, "total_act_power": 10.615, "total_aprt_power": 34.873, "a_total_act_energy": 8340015.76, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.870000001, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.09, "c_total_act_ret_energy": 17.85, "total_act": 27680697.72, "total_act_ret": 333.64}	2025-07-26 11:01:36
375	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 99}	2025-07-26 11:20:05.639
378	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 99}	2025-07-26 11:20:12.544
382	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 28}	2025-07-26 11:20:21.82
41	shellypro3em-08f9e0e5121c	{"a_current": 2.007, "a_voltage": 234.9, "a_act_power": 418.3, "a_aprt_power": 471.7, "a_pf": 0.89, "a_freq": 50, "b_current": 0.544, "b_voltage": 234.3, "b_act_power": -16.2, "b_aprt_power": 127.8, "b_pf": 0.19, "b_freq": 50, "c_current": 0.807, "c_voltage": 234.3, "c_act_power": -111.2, "c_aprt_power": 189.2, "c_pf": 0.59, "c_freq": 50, "n_current": null, "total_current": 3.358, "total_act_power": 290.88, "total_aprt_power": 788.711, "a_total_act_energy": 9418438.02, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.14, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945376.94, "total_act": 29611568.77, "total_act_ret": 9244540.209999999}	2025-07-26 11:01:43
42	shellypro3em-34987a45dcd4	{"a_current": 0.952, "a_voltage": 234.6, "a_act_power": -185.8, "a_aprt_power": 223.6, "a_pf": 0.83, "a_freq": 50, "b_current": 0.971, "b_voltage": 235.1, "b_act_power": -187.5, "b_aprt_power": 228.5, "b_pf": 0.82, "b_freq": 50, "c_current": 0.981, "c_voltage": 234.5, "c_act_power": -191.3, "c_aprt_power": 230.1, "c_pf": 0.83, "c_freq": 50, "n_current": null, "total_current": 2.903, "total_act_power": -564.533, "total_aprt_power": 682.14, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794421.55, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792883.43, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809890.81, "total_act": 3519.58, "total_act_ret": 2397195.79}	2025-07-26 11:01:45
43	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.9, "a_act_power": 0, "a_aprt_power": 6.8, "a_pf": 0, "a_freq": 50, "b_current": 0.091, "b_voltage": 234.3, "b_act_power": 9.2, "b_aprt_power": 21.3, "b_pf": 0.43, "b_freq": 50, "c_current": 0.028, "c_voltage": 234.2, "c_act_power": 0, "c_aprt_power": 6.4, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.148, "total_act_power": 9.202, "total_aprt_power": 34.587, "a_total_act_energy": 8340015.76, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.870000001, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.09, "c_total_act_ret_energy": 17.85, "total_act": 27680697.72, "total_act_ret": 333.64}	2025-07-26 11:01:46
44	shellypro3em-08f9e0e5121c	{"a_current": 2, "a_voltage": 234.4, "a_act_power": 415.2, "a_aprt_power": 469.2, "a_pf": 0.88, "a_freq": 50, "b_current": 0.553, "b_voltage": 234, "b_act_power": -23.7, "b_aprt_power": 129.6, "b_pf": 0.18, "b_freq": 50, "c_current": 0.819, "c_voltage": 233.8, "c_act_power": -113.3, "c_aprt_power": 191.7, "c_pf": 0.59, "c_freq": 50, "n_current": null, "total_current": 3.372, "total_act_power": 278.263, "total_aprt_power": 790.443, "a_total_act_energy": 9418438.02, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.14, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945376.94, "total_act": 29611568.77, "total_act_ret": 9244540.209999999}	2025-07-26 11:01:53
45	shellypro3em-34987a45dcd4	{"a_current": 0.954, "a_voltage": 235.3, "a_act_power": -185.9, "a_aprt_power": 224.7, "a_pf": 0.83, "a_freq": 50, "b_current": 0.971, "b_voltage": 234.5, "b_act_power": -186.8, "b_aprt_power": 228, "b_pf": 0.82, "b_freq": 50, "c_current": 0.977, "c_voltage": 234.4, "c_act_power": -190.1, "c_aprt_power": 229.2, "c_pf": 0.83, "c_freq": 50, "n_current": null, "total_current": 2.902, "total_act_power": -562.834, "total_aprt_power": 682.022, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794421.55, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792883.43, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809890.81, "total_act": 3519.58, "total_act_ret": 2397195.79}	2025-07-26 11:01:55
46	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.5, "a_act_power": 1.3, "a_aprt_power": 6.8, "a_pf": 0.13, "a_freq": 50, "b_current": 0.089, "b_voltage": 234.2, "b_act_power": 9.3, "b_aprt_power": 21, "b_pf": 0.44, "b_freq": 50, "c_current": 0.029, "c_voltage": 235, "c_act_power": 0, "c_aprt_power": 6.7, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.147, "total_act_power": 10.565, "total_aprt_power": 34.503, "a_total_act_energy": 8340015.76, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712136.870000001, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.09, "c_total_act_ret_energy": 17.85, "total_act": 27680697.72, "total_act_ret": 333.64}	2025-07-26 11:01:56
47	shellypro3em-08f9e0e5121c	{"a_current": 1.99, "a_voltage": 234.6, "a_act_power": 412.7, "a_aprt_power": 467.4, "a_pf": 0.88, "a_freq": 50, "b_current": 0.555, "b_voltage": 234.3, "b_act_power": -24.7, "b_aprt_power": 130.2, "b_pf": 0.21, "b_freq": 50, "c_current": 0.811, "c_voltage": 234.8, "c_act_power": -114.8, "c_aprt_power": 190.6, "c_pf": 0.6, "c_freq": 50, "n_current": null, "total_current": 3.356, "total_act_power": 273.216, "total_aprt_power": 788.172, "a_total_act_energy": 9418444.96, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.55, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945378.8699999996, "total_act": 29611575.7, "total_act_ret": 9244542.56}	2025-07-26 11:02:03
48	shellypro3em-34987a45dcd4	{"a_current": 0.932, "a_voltage": 235.4, "a_act_power": -183.5, "a_aprt_power": 219.8, "a_pf": 0.83, "a_freq": 50, "b_current": 0.958, "b_voltage": 234.5, "b_act_power": -183.4, "b_aprt_power": 225.1, "b_pf": 0.82, "b_freq": 50, "c_current": 0.961, "c_voltage": 234.3, "c_act_power": -187.8, "c_aprt_power": 225.2, "c_pf": 0.83, "c_freq": 50, "n_current": null, "total_current": 2.851, "total_act_power": -554.675, "total_aprt_power": 670.027, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794424.69, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792886.57, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809894.03, "total_act": 3519.58, "total_act_ret": 2397205.2800000003}	2025-07-26 11:02:05
49	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.4, "a_act_power": 0, "a_aprt_power": 6.7, "a_pf": 0, "a_freq": 50, "b_current": 0.091, "b_voltage": 234.1, "b_act_power": 9.4, "b_aprt_power": 21.2, "b_pf": 0.43, "b_freq": 50, "c_current": 0.029, "c_voltage": 235, "c_act_power": 0, "c_aprt_power": 6.7, "c_pf": 0, "c_freq": 49.9, "n_current": null, "total_current": 0.148, "total_act_power": 9.37, "total_aprt_power": 34.705, "a_total_act_energy": 8340015.7700000005, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712137.02, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.1, "c_total_act_ret_energy": 17.85, "total_act": 27680697.9, "total_act_ret": 333.64}	2025-07-26 11:02:06
50	shellypro3em-08f9e0e5121c	{"a_current": 2.007, "a_voltage": 233.7, "a_act_power": 414, "a_aprt_power": 469.4, "a_pf": 0.88, "a_freq": 50, "b_current": 0.567, "b_voltage": 234.3, "b_act_power": -17.9, "b_aprt_power": 133.2, "b_pf": 0.13, "b_freq": 50, "c_current": 0.819, "c_voltage": 234.9, "c_act_power": -113.7, "c_aprt_power": 192.6, "c_pf": 0.59, "c_freq": 50, "n_current": null, "total_current": 3.393, "total_act_power": 282.401, "total_aprt_power": 795.238, "a_total_act_energy": 9418444.96, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.55, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945378.8699999996, "total_act": 29611575.7, "total_act_ret": 9244542.56}	2025-07-26 11:02:13
376	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.4, "Battery": 53}	2025-07-26 11:20:06.646
386	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 85}	2025-07-26 11:20:30.213
51	shellypro3em-34987a45dcd4	{"a_current": 0.95, "a_voltage": 235.3, "a_act_power": -185.1, "a_aprt_power": 223.8, "a_pf": 0.83, "a_freq": 50, "b_current": 0.975, "b_voltage": 233.9, "b_act_power": -186, "b_aprt_power": 228.3, "b_pf": 0.82, "b_freq": 50, "c_current": 0.975, "c_voltage": 234.6, "c_act_power": -190.9, "c_aprt_power": 228.9, "c_pf": 0.83, "c_freq": 50, "n_current": null, "total_current": 2.9, "total_act_power": -562.026, "total_aprt_power": 680.996, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794424.69, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792886.57, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809894.03, "total_act": 3519.58, "total_act_ret": 2397205.2800000003}	2025-07-26 11:02:15
52	shellypro3em-34987a46bc6c	{"a_current": 0.028, "a_voltage": 233.9, "a_act_power": 0, "a_aprt_power": 6.6, "a_pf": 0, "a_freq": 50, "b_current": 0.356, "b_voltage": 234.6, "b_act_power": 81.4, "b_aprt_power": 83.6, "b_pf": 0.98, "b_freq": 50, "c_current": 0.028, "c_voltage": 235.4, "c_act_power": 0, "c_aprt_power": 6.6, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.412, "total_act_power": 81.371, "total_aprt_power": 96.865, "a_total_act_energy": 8340015.7700000005, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712137.02, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.1, "c_total_act_ret_energy": 17.85, "total_act": 27680697.9, "total_act_ret": 333.64}	2025-07-26 11:02:16
53	shellypro3em-08f9e0e5121c	{"a_current": 2.007, "a_voltage": 235.1, "a_act_power": 418.6, "a_aprt_power": 472.3, "a_pf": 0.89, "a_freq": 50, "b_current": 0.574, "b_voltage": 234.6, "b_act_power": 52.2, "b_aprt_power": 134.8, "b_pf": 0.38, "b_freq": 50, "c_current": 0.783, "c_voltage": 235.9, "c_act_power": -109, "c_aprt_power": 184.9, "c_pf": 0.6, "c_freq": 50, "n_current": null, "total_current": 3.364, "total_act_power": 361.82, "total_aprt_power": 792.075, "a_total_act_energy": 9418444.96, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.55, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945378.8699999996, "total_act": 29611575.7, "total_act_ret": 9244542.56}	2025-07-26 11:02:23
54	shellypro3em-34987a45dcd4	{"a_current": 0.931, "a_voltage": 236.3, "a_act_power": -183.3, "a_aprt_power": 220.3, "a_pf": 0.83, "a_freq": 50, "b_current": 0.957, "b_voltage": 235.4, "b_act_power": -184.6, "b_aprt_power": 225.8, "b_pf": 0.82, "b_freq": 50, "c_current": 0.96, "c_voltage": 234.8, "c_act_power": -188.5, "c_aprt_power": 225.5, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 2.849, "total_act_power": -556.492, "total_aprt_power": 671.609, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794424.69, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792886.57, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809894.03, "total_act": 3519.58, "total_act_ret": 2397205.2800000003}	2025-07-26 11:02:25
55	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.9, "a_act_power": 0, "a_aprt_power": 6.8, "a_pf": 0, "a_freq": 50, "b_current": 0.354, "b_voltage": 234.8, "b_act_power": 81.2, "b_aprt_power": 83.2, "b_pf": 0.98, "b_freq": 50, "c_current": 0.029, "c_voltage": 236.2, "c_act_power": 0, "c_aprt_power": 6.9, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.412, "total_act_power": 81.236, "total_aprt_power": 96.881, "a_total_act_energy": 8340015.7700000005, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712137.02, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.1, "c_total_act_ret_energy": 17.85, "total_act": 27680697.9, "total_act_ret": 333.64}	2025-07-26 11:02:26
56	shellypro3em-08f9e0e5121c	{"a_current": 2.332, "a_voltage": 234.6, "a_act_power": 490.3, "a_aprt_power": 547.6, "a_pf": 0.9, "a_freq": 50, "b_current": 4.334, "b_voltage": 233.5, "b_act_power": 1018.6, "b_aprt_power": 1018.6, "b_pf": 0.52, "b_freq": 50, "c_current": 0.807, "c_voltage": 235.2, "c_act_power": -110.5, "c_aprt_power": 190, "c_pf": 0.57, "c_freq": 50, "n_current": null, "total_current": 7.474, "total_act_power": 1398.362, "total_aprt_power": 1756.178, "a_total_act_energy": 9418444.96, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.55, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945378.8699999996, "total_act": 29611575.7, "total_act_ret": 9244542.56}	2025-07-26 11:02:33
57	shellypro3em-34987a45dcd4	{"a_current": 0.932, "a_voltage": 235.4, "a_act_power": -180.5, "a_aprt_power": 219.7, "a_pf": 0.83, "a_freq": 50, "b_current": 0.96, "b_voltage": 234.8, "b_act_power": -181.4, "b_aprt_power": 225.9, "b_pf": 0.8, "b_freq": 50, "c_current": 0.963, "c_voltage": 234, "c_act_power": -184.3, "c_aprt_power": 225.3, "c_pf": 0.82, "c_freq": 50, "n_current": null, "total_current": 2.855, "total_act_power": -546.263, "total_aprt_power": 670.936, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794424.69, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792886.57, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809894.03, "total_act": 3519.58, "total_act_ret": 2397205.2800000003}	2025-07-26 11:02:35
58	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 234.5, "a_act_power": 0, "a_aprt_power": 6.7, "a_pf": 0, "a_freq": 50, "b_current": 0.355, "b_voltage": 234.1, "b_act_power": 81.1, "b_aprt_power": 83.2, "b_pf": 0.97, "b_freq": 50, "c_current": 0.029, "c_voltage": 235.4, "c_act_power": 0, "c_aprt_power": 6.8, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.412, "total_act_power": 81.051, "total_aprt_power": 96.713, "a_total_act_energy": 8340015.7700000005, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712137.02, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.1, "c_total_act_ret_energy": 17.85, "total_act": 27680697.9, "total_act_ret": 333.64}	2025-07-26 11:02:36
59	shellypro3em-08f9e0e5121c	{"a_current": 2.33, "a_voltage": 235.1, "a_act_power": 493.9, "a_aprt_power": 548.2, "a_pf": 0.9, "a_freq": 50, "b_current": 1.007, "b_voltage": 234.3, "b_act_power": 166.5, "b_aprt_power": 236.3, "b_pf": 0.71, "b_freq": 50, "c_current": 0.784, "c_voltage": 235, "c_act_power": -106.8, "c_aprt_power": 184.5, "c_pf": 0.56, "c_freq": 50, "n_current": null, "total_current": 4.121, "total_act_power": 553.598, "total_aprt_power": 968.982, "a_total_act_energy": 9418444.96, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.55, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945378.8699999996, "total_act": 29611575.7, "total_act_ret": 9244542.56}	2025-07-26 11:02:43
60	shellypro3em-34987a45dcd4	{"a_current": 0.928, "a_voltage": 235.1, "a_act_power": -179.4, "a_aprt_power": 218.4, "a_pf": 0.82, "a_freq": 50, "b_current": 0.951, "b_voltage": 235, "b_act_power": -181.5, "b_aprt_power": 223.8, "b_pf": 0.81, "b_freq": 50, "c_current": 0.952, "c_voltage": 234.3, "c_act_power": -184.4, "c_aprt_power": 223, "c_pf": 0.83, "c_freq": 50, "n_current": null, "total_current": 2.83, "total_act_power": -545.338, "total_aprt_power": 665.199, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794424.69, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792886.57, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809894.03, "total_act": 3519.58, "total_act_ret": 2397205.2800000003}	2025-07-26 11:02:45
390	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 61}	2025-07-26 11:20:39.363
741	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.8, "Battery": 54}	2025-07-26 11:40:04.77
743	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.7, "Battery": 99}	2025-07-26 11:40:05.725
61	shellypro3em-34987a46bc6c	{"a_current": 0.028, "a_voltage": 234.8, "a_act_power": 0, "a_aprt_power": 6.5, "a_pf": 0, "a_freq": 50, "b_current": 0.356, "b_voltage": 234.1, "b_act_power": 81.1, "b_aprt_power": 83.4, "b_pf": 0.98, "b_freq": 50, "c_current": 0.029, "c_voltage": 235.3, "c_act_power": 1.1, "c_aprt_power": 6.8, "c_pf": 0.06, "c_freq": 50, "n_current": null, "total_current": 0.413, "total_act_power": 82.178, "total_aprt_power": 96.814, "a_total_act_energy": 8340015.7700000005, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712137.02, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.1, "c_total_act_ret_energy": 17.85, "total_act": 27680697.9, "total_act_ret": 333.64}	2025-07-26 11:02:46
62	shellypro3em-08f9e0e5121c	{"a_current": 2.343, "a_voltage": 234.9, "a_act_power": 497.7, "a_aprt_power": 550.7, "a_pf": 0.9, "a_freq": 50, "b_current": 0.991, "b_voltage": 234, "b_act_power": 164.8, "b_aprt_power": 232.4, "b_pf": 0.7, "b_freq": 50, "c_current": 0.777, "c_voltage": 235.5, "c_act_power": -103.4, "c_aprt_power": 183.3, "c_pf": 0.58, "c_freq": 50, "n_current": null, "total_current": 4.111, "total_act_power": 559.116, "total_aprt_power": 966.341, "a_total_act_energy": 9418444.96, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437887.66, "b_total_act_ret_energy": 3362767.55, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945378.8699999996, "total_act": 29611575.7, "total_act_ret": 9244542.56}	2025-07-26 11:02:53
63	shellypro3em-34987a45dcd4	{"a_current": 0.902, "a_voltage": 235.8, "a_act_power": -173.7, "a_aprt_power": 212.9, "a_pf": 0.82, "a_freq": 50, "b_current": 0.932, "b_voltage": 235.1, "b_act_power": -174, "b_aprt_power": 219.4, "b_pf": 0.8, "b_freq": 50, "c_current": 0.933, "c_voltage": 234.2, "c_act_power": -178, "c_aprt_power": 218.5, "c_pf": 0.82, "c_freq": 50, "n_current": null, "total_current": 2.767, "total_act_power": -525.689, "total_aprt_power": 650.866, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794424.69, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792886.57, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809894.03, "total_act": 3519.58, "total_act_ret": 2397205.2800000003}	2025-07-26 11:02:55
64	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 235.1, "a_act_power": 0, "a_aprt_power": 6.7, "a_pf": 0, "a_freq": 50, "b_current": 0.354, "b_voltage": 234.2, "b_act_power": 80.9, "b_aprt_power": 83.1, "b_pf": 0.98, "b_freq": 50, "c_current": 0.029, "c_voltage": 235.7, "c_act_power": 0, "c_aprt_power": 6.9, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.412, "total_act_power": 80.9, "total_aprt_power": 96.679, "a_total_act_energy": 8340015.7700000005, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712137.02, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.1, "c_total_act_ret_energy": 17.85, "total_act": 27680697.9, "total_act_ret": 333.64}	2025-07-26 11:02:56
65	shellypro3em-08f9e0e5121c	{"a_current": 2.335, "a_voltage": 235.5, "a_act_power": 495.4, "a_aprt_power": 550.5, "a_pf": 0.9, "a_freq": 50, "b_current": 0.966, "b_voltage": 234.7, "b_act_power": 157.4, "b_aprt_power": 227, "b_pf": 0.69, "b_freq": 50, "c_current": 0.759, "c_voltage": 235.1, "c_act_power": -103.6, "c_aprt_power": 178.6, "c_pf": 0.58, "c_freq": 50, "n_current": null, "total_current": 4.06, "total_act_power": 549.292, "total_aprt_power": 956.096, "a_total_act_energy": 9418452.79, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437889.229999999, "b_total_act_ret_energy": 3362767.65, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945380.69, "total_act": 29611585.1, "total_act_ret": 9244544.47}	2025-07-26 11:03:03
66	shellypro3em-34987a45dcd4	{"a_current": 0.91, "a_voltage": 235, "a_act_power": -176.4, "a_aprt_power": 214.3, "a_pf": 0.82, "a_freq": 50, "b_current": 0.929, "b_voltage": 236.1, "b_act_power": -177.9, "b_aprt_power": 219.6, "b_pf": 0.81, "b_freq": 50, "c_current": 0.932, "c_voltage": 234.9, "c_act_power": -181.7, "c_aprt_power": 219.1, "c_pf": 0.83, "c_freq": 50, "n_current": null, "total_current": 2.772, "total_act_power": -536.069, "total_aprt_power": 652.952, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794427.71, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792889.61, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809897.14, "total_act": 3519.58, "total_act_ret": 2397214.46}	2025-07-26 11:03:05
67	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 235.8, "a_act_power": 0, "a_aprt_power": 6.8, "a_pf": 0, "a_freq": 50, "b_current": 0.356, "b_voltage": 234.6, "b_act_power": 81.2, "b_aprt_power": 83.6, "b_pf": 0.98, "b_freq": 50, "c_current": 0.029, "c_voltage": 234.7, "c_act_power": 0, "c_aprt_power": 6.8, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.414, "total_act_power": 81.22, "total_aprt_power": 97.201, "a_total_act_energy": 8340015.79, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712138.06, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.11, "c_total_act_ret_energy": 17.85, "total_act": 27680698.959999997, "total_act_ret": 333.64}	2025-07-26 11:03:06
68	shellypro3em-08f9e0e5121c	{"a_current": 2.345, "a_voltage": 235.5, "a_act_power": 498.1, "a_aprt_power": 552.6, "a_pf": 0.9, "a_freq": 50, "b_current": 0.998, "b_voltage": 234.2, "b_act_power": 168.3, "b_aprt_power": 234.2, "b_pf": 0.72, "b_freq": 50, "c_current": 0.743, "c_voltage": 234.5, "c_act_power": -99.4, "c_aprt_power": 174.3, "c_pf": 0.57, "c_freq": 50, "n_current": null, "total_current": 4.085, "total_act_power": 567.073, "total_aprt_power": 961.092, "a_total_act_energy": 9418452.79, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437889.229999999, "b_total_act_ret_energy": 3362767.65, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945380.69, "total_act": 29611585.1, "total_act_ret": 9244544.47}	2025-07-26 11:03:13
69	shellypro3em-34987a45dcd4	{"a_current": 0.9, "a_voltage": 235.5, "a_act_power": -175.2, "a_aprt_power": 212.2, "a_pf": 0.83, "a_freq": 49.9, "b_current": 0.919, "b_voltage": 235.6, "b_act_power": -176.7, "b_aprt_power": 217, "b_pf": 0.81, "b_freq": 50, "c_current": 0.917, "c_voltage": 234.6, "c_act_power": -179.8, "c_aprt_power": 215.1, "c_pf": 0.84, "c_freq": 50, "n_current": null, "total_current": 2.736, "total_act_power": -531.796, "total_aprt_power": 644.322, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794427.71, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792889.61, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809897.14, "total_act": 3519.58, "total_act_ret": 2397214.46}	2025-07-26 11:03:15
70	shellypro3em-34987a46bc6c	{"a_current": 0.029, "a_voltage": 235.6, "a_act_power": 0, "a_aprt_power": 6.8, "a_pf": 0, "a_freq": 50, "b_current": 0.356, "b_voltage": 234.3, "b_act_power": 81.3, "b_aprt_power": 83.5, "b_pf": 0.98, "b_freq": 50, "c_current": 0.029, "c_voltage": 234.9, "c_act_power": 0, "c_aprt_power": 6.7, "c_pf": 0, "c_freq": 49.9, "n_current": null, "total_current": 0.413, "total_act_power": 81.253, "total_aprt_power": 97.016, "a_total_act_energy": 8340015.79, "a_total_act_ret_energy": 315.58, "b_total_act_energy": 10712138.06, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628545.11, "c_total_act_ret_energy": 17.85, "total_act": 27680698.959999997, "total_act_ret": 333.64}	2025-07-26 11:03:16
391	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 72}	2025-07-26 11:20:40.183
745	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 71}	2025-07-26 11:40:07.533
747	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.5, "Battery": 99}	2025-07-26 11:40:08.256
71	shellypro3em-08f9e0e5121c	{"a_current": 2.348, "a_voltage": 234.7, "a_act_power": 496.9, "a_aprt_power": 551.6, "a_pf": 0.9, "a_freq": 50, "b_current": 0.993, "b_voltage": 234.8, "b_act_power": 164.9, "b_aprt_power": 233.5, "b_pf": 0.71, "b_freq": 50, "c_current": 0.771, "c_voltage": 234.7, "c_act_power": -101, "c_aprt_power": 181.2, "c_pf": 0.56, "c_freq": 49.9, "n_current": null, "total_current": 4.113, "total_act_power": 560.865, "total_aprt_power": 966.357, "a_total_act_energy": 9418452.79, "a_total_act_ret_energy": 2936396.13, "b_total_act_energy": 11437889.229999999, "b_total_act_ret_energy": 3362767.65, "c_total_act_energy": 8755243.09, "c_total_act_ret_energy": 2945380.69, "total_act": 29611585.1, "total_act_ret": 9244544.47}	2025-07-26 11:03:23
72	shellypro3em-34987a45dcd4	{"a_current": 0.896, "a_voltage": 235.7, "a_act_power": -170.5, "a_aprt_power": 211.5, "a_pf": 0.81, "a_freq": 50, "b_current": 0.92, "b_voltage": 234.5, "b_act_power": -171.2, "b_aprt_power": 216, "b_pf": 0.79, "b_freq": 50, "c_current": 0.918, "c_voltage": 235.1, "c_act_power": -175.9, "c_aprt_power": 215.8, "c_pf": 0.82, "c_freq": 50, "n_current": null, "total_current": 2.733, "total_act_power": -517.631, "total_aprt_power": 643.279, "a_total_act_energy": 14.82, "a_total_act_ret_energy": 794427.71, "b_total_act_energy": 659.59, "b_total_act_ret_energy": 792889.61, "c_total_act_energy": 2845.18, "c_total_act_ret_energy": 809897.14, "total_act": 3519.58, "total_act_ret": 2397214.46}	2025-07-26 11:03:25
1859	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.5, "Battery": 53}	2025-07-26 12:40:03.477
1860	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-26 12:40:05.15
1107	70:ee:50:83:2e:54	{"temperature": 24.9, "humidity": 64, "Pressure": 1012.3, "AbsolutePressure": 1006.7, "Noise": 32, "CO2": 477}	2025-07-26 11:57:58
1108	70:ee:50:83:4e:60	{"temperature": 25.7, "humidity": 63, "Pressure": 1012.6, "AbsolutePressure": 1007, "Noise": 32, "CO2": 590}	2025-07-26 11:55:08
1109	70:ee:50:83:2f:44	{"temperature": 25.1, "humidity": 65, "Pressure": 1012.3, "AbsolutePressure": 1006.7, "Noise": 32, "CO2": 605}	2025-07-26 11:57:22
746	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-26 11:40:08.058
748	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-26 11:40:10.576
749	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.5, "Battery": 99}	2025-07-26 11:40:10.935
1110	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-26 12:00:02.43
1111	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-26 12:00:02.611
1112	70:ee:50:83:2a:82	{"temperature": 23.1, "humidity": 69, "Pressure": 1008.7, "AbsolutePressure": 1007.3, "Noise": 33, "CO2": 497}	2025-07-26 11:59:31
1113	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 71, "Pressure": 1012.8, "AbsolutePressure": 1009.9, "Noise": 31, "CO2": 479}	2025-07-26 11:51:26
1489	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-07-26 12:20:01.767
1115	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1012.3, "AbsolutePressure": 1006.7, "Noise": 32, "CO2": 560}	2025-07-26 11:54:00
1116	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.3, "Battery": 84}	2025-07-26 12:00:05.114
1117	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-26 12:00:05.29
1118	70:ee:50:83:35:00	{"temperature": 23.5, "humidity": 68, "Pressure": 1009, "AbsolutePressure": 1006.1, "Noise": 34, "CO2": 523}	2025-07-26 11:50:11
1862	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.2, "Battery": 99}	2025-07-26 12:40:06.059
1120	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.9, "Battery": 61}	2025-07-26 12:00:05.664
1121	70:ee:50:83:2a:6c	{"temperature": 23.6, "humidity": 67, "Pressure": 1011.7, "AbsolutePressure": 1006.1, "Noise": 33, "CO2": 466}	2025-07-26 11:51:15
1122	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 66, "Pressure": 1011.6, "AbsolutePressure": 1006, "Noise": 32, "CO2": 540}	2025-07-26 11:55:41
1864	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 71}	2025-07-26 12:40:07.849
1124	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 64, "Pressure": 1009.2, "AbsolutePressure": 1006.3, "Noise": 32, "CO2": 504}	2025-07-26 11:52:48
1125	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 69}	2025-07-26 12:00:07.485
1126	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21.1, "Battery": 99}	2025-07-26 12:00:07.751
1127	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-07-26 12:00:08.368
1128	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 58}	2025-07-26 12:00:11.08
1492	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 28}	2025-07-26 12:20:06.213
1865	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-26 12:40:09.445
1131	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 49}	2025-07-26 12:00:15.664
1494	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.3, "Battery": 99}	2025-07-26 12:20:08.491
1133	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-07-26 12:00:19.159
1495	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 99}	2025-07-26 12:20:09.845
1866	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.5, "Battery": 99}	2025-07-26 12:40:12.068
1868	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.2, "Battery": 99}	2025-07-26 12:40:15.09
1871	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.9, "Battery": 99}	2025-07-26 12:40:17.959
1138	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 75}	2025-07-26 12:00:33.341
1499	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 28}	2025-07-26 12:20:20.766
1501	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 71}	2025-07-26 12:20:24.243
1502	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.4, "Battery": 53}	2025-07-26 12:20:24.418
1505	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 99}	2025-07-26 12:20:27.932
1507	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 62}	2025-07-26 12:20:33.318
2226	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-26 13:00:01.46
2227	70:ee:50:83:2e:54	{"temperature": 24.7, "humidity": 64, "Pressure": 1012.6, "AbsolutePressure": 1007, "Noise": 32, "CO2": 496}	2025-07-26 12:58:32
2228	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-26 13:00:02.729
2229	70:ee:50:83:4e:60	{"temperature": 25.4, "humidity": 63, "Pressure": 1012.8, "AbsolutePressure": 1007.2, "Noise": 32, "CO2": 540}	2025-07-26 12:55:37
2230	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.9, "Battery": 61}	2025-07-26 13:00:03.227
2606	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-26 13:20:01.998
2232	70:ee:50:83:2f:44	{"temperature": 24.8, "humidity": 65, "Pressure": 1012.5, "AbsolutePressure": 1006.9, "Noise": 32, "CO2": 571}	2025-07-26 12:57:51
2233	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-26 13:00:04.199
2234	70:ee:50:83:2a:82	{"temperature": 23.1, "humidity": 69, "Pressure": 1008.9, "AbsolutePressure": 1007.5, "Noise": 36, "CO2": 497}	2025-07-26 13:00:00
2235	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 71, "Pressure": 1013.2, "AbsolutePressure": 1010.2, "Noise": 31, "CO2": 473}	2025-07-26 12:52:00
2607	shellytrv-588e81617272	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-26 13:20:03.05
2237	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1012.7, "AbsolutePressure": 1007.1, "Noise": 32, "CO2": 564}	2025-07-26 12:54:37
2238	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21.1, "Battery": 99}	2025-07-26 13:00:06.093
3341	70:ee:50:83:2e:54	{"temperature": 24.7, "humidity": 64, "Pressure": 1012.4, "AbsolutePressure": 1006.8, "Noise": 32, "CO2": 500}	2025-07-26 13:59:07
2240	70:ee:50:83:35:00	{"temperature": 23.5, "humidity": 68, "Pressure": 1009.4, "AbsolutePressure": 1006.5, "Noise": 33, "CO2": 507}	2025-07-26 12:50:48
2241	70:ee:50:83:2a:6c	{"temperature": 23.6, "humidity": 68, "Pressure": 1012.1, "AbsolutePressure": 1006.5, "Noise": 32, "CO2": 496}	2025-07-26 12:51:50
2242	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 66, "Pressure": 1012, "AbsolutePressure": 1006.4, "Noise": 32, "CO2": 529}	2025-07-26 12:51:13
2243	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 64, "Pressure": 1009.5, "AbsolutePressure": 1006.6, "Noise": 32, "CO2": 515}	2025-07-26 12:53:10
2244	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 69}	2025-07-26 13:00:09.963
2609	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 99}	2025-07-26 13:20:04.895
2246	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.3, "Battery": 84}	2025-07-26 13:00:13.418
2610	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.4, "Battery": 99}	2025-07-26 13:20:05.072
2977	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-26 13:40:04.047
2612	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.4, "Battery": 53}	2025-07-26 13:20:05.909
3342	70:ee:50:83:4e:60	{"temperature": 25.3, "humidity": 63, "Pressure": 1012.7, "AbsolutePressure": 1007.1, "Noise": 32, "CO2": 584}	2025-07-26 13:56:07
2251	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 49}	2025-07-26 13:00:26.092
2614	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 99}	2025-07-26 13:20:07.881
2615	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.9, "Battery": 27}	2025-07-26 13:20:12.298
2254	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-26 13:00:34.304
2979	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.5, "Battery": 53}	2025-07-26 13:40:05.76
2256	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 75}	2025-07-26 13:00:36.337
3343	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-26 14:00:02.156
2981	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-26 13:40:07.244
2619	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.1, "Battery": 85}	2025-07-26 13:20:17.854
2982	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 71}	2025-07-26 13:40:08.118
2621	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 27}	2025-07-26 13:20:23.432
2983	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.2, "Battery": 99}	2025-07-26 13:40:08.381
2623	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 62}	2025-07-26 13:20:26.003
2984	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-26 13:40:08.762
2985	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-26 13:40:11.054
2986	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.5, "Battery": 99}	2025-07-26 13:40:13.263
3344	70:ee:50:83:2f:44	{"temperature": 24.8, "humidity": 65, "Pressure": 1012.4, "AbsolutePressure": 1006.8, "Noise": 32, "CO2": 601}	2025-07-26 13:58:21
3345	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-26 14:00:02.861
3346	70:ee:50:83:2a:82	{"temperature": 22.9, "humidity": 69, "Pressure": 1008.8, "AbsolutePressure": 1007.4, "Noise": 32, "CO2": 474}	2025-07-26 13:50:24
3348	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 71, "Pressure": 1012.9, "AbsolutePressure": 1010, "Noise": 31, "CO2": 469}	2025-07-26 13:52:36
3349	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1012.4, "AbsolutePressure": 1006.8, "Noise": 32, "CO2": 540}	2025-07-26 13:55:14
3350	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-26 14:00:04.638
3351	70:ee:50:83:35:00	{"temperature": 23.5, "humidity": 68, "Pressure": 1009.2, "AbsolutePressure": 1006.3, "Noise": 32, "CO2": 505}	2025-07-26 13:51:24
3353	70:ee:50:83:2a:6c	{"temperature": 23.6, "humidity": 68, "Pressure": 1011.9, "AbsolutePressure": 1006.3, "Noise": 32, "CO2": 459}	2025-07-26 13:52:26
3354	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21.1, "Battery": 99}	2025-07-26 14:00:06.032
3355	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 66, "Pressure": 1011.8, "AbsolutePressure": 1006.2, "Noise": 32, "CO2": 544}	2025-07-26 13:56:49
6462	70:ee:50:83:2e:54	{"temperature": 24.7, "humidity": 62, "Pressure": 1010, "AbsolutePressure": 1004.4, "Noise": 32, "CO2": 438}	2025-07-27 09:50:12
3723	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-26 14:20:01.864
3725	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.3, "Battery": 99}	2025-07-26 14:20:03.558
6463	70:ee:50:83:4e:60	{"temperature": 26, "humidity": 61, "Pressure": 1010.2, "AbsolutePressure": 1004.6, "Noise": 32, "CO2": 467}	2025-07-27 09:55:46
6464	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 10:00:01.471
3731	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 99}	2025-07-26 14:20:11.356
3733	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 85}	2025-07-26 14:20:14.193
6465	70:ee:50:83:2f:44	{"temperature": 25.3, "humidity": 64, "Pressure": 1009.9, "AbsolutePressure": 1004.3, "Noise": 32, "CO2": 512}	2025-07-27 09:57:59
6467	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 10:00:02.059
6468	70:ee:50:83:2a:82	{"temperature": 23.2, "humidity": 66, "Pressure": 1006.4, "AbsolutePressure": 1005, "Noise": 32, "CO2": 475}	2025-07-27 09:44:59
6469	70:ee:50:83:32:66	{"temperature": 22, "humidity": 69, "Pressure": 1010.4, "AbsolutePressure": 1007.5, "Noise": 31, "CO2": 420}	2025-07-27 09:54:22
4458	70:ee:50:83:4e:60	{"temperature": 25.3, "humidity": 63, "Pressure": 1012.6, "AbsolutePressure": 1007, "Noise": 32, "CO2": 572}	2025-07-26 14:56:35
4460	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-26 15:00:02.276
4464	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 71, "Pressure": 1012.7, "AbsolutePressure": 1009.8, "Noise": 31, "CO2": 471}	2025-07-26 14:53:12
4466	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1012.4, "AbsolutePressure": 1006.8, "Noise": 32, "CO2": 551}	2025-07-26 14:55:54
5342	70:ee:50:83:2e:54	{"temperature": 24.2, "humidity": 63, "Pressure": 1010.4, "AbsolutePressure": 1004.8, "Noise": 31, "CO2": 454}	2025-07-27 08:54:42
4472	70:ee:50:83:35:00	{"temperature": 23.5, "humidity": 69, "Pressure": 1009, "AbsolutePressure": 1006.1, "Noise": 32, "CO2": 490}	2025-07-26 14:52:01
4474	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 66, "Pressure": 1011.7, "AbsolutePressure": 1006.1, "Noise": 33, "CO2": 529}	2025-07-26 14:57:21
4476	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.3, "Battery": 84}	2025-07-26 15:00:10.901
4478	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 49}	2025-07-26 15:00:13.109
5344	70:ee:50:83:4e:60	{"temperature": 25.3, "humidity": 62, "Pressure": 1010.7, "AbsolutePressure": 1005.1, "Noise": 32, "CO2": 526}	2025-07-27 08:55:17
5346	70:ee:50:83:2f:44	{"temperature": 24.9, "humidity": 63, "Pressure": 1010.3, "AbsolutePressure": 1004.7, "Noise": 32, "CO2": 488}	2025-07-27 08:57:28
5348	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 09:00:03.376
5352	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 66, "Pressure": 1007.2, "AbsolutePressure": 1004.3, "Noise": 31, "CO2": 431}	2025-07-27 08:52:49
5354	70:ee:50:83:2a:6c	{"temperature": 23.4, "humidity": 62, "Pressure": 1009.9, "AbsolutePressure": 1004.3, "Noise": 32, "CO2": 414}	2025-07-27 08:53:40
5358	shellytrv-8cf681cd22c2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 09:00:05.789
5360	70:ee:50:83:4d:e8	{"temperature": 24.7, "humidity": 63, "Pressure": 1007.4, "AbsolutePressure": 1004.5, "Noise": 32, "CO2": 439}	2025-07-27 08:50:13
5362	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.2, "Battery": 84}	2025-07-27 09:00:08.956
5366	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 09:00:20.036
5370	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 75}	2025-07-27 09:00:27.947
4093	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-26 14:40:04.092
4095	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.1, "Battery": 99}	2025-07-26 14:40:05.959
4097	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-26 14:40:06.693
4099	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 71}	2025-07-26 14:40:10.243
5730	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 09:20:07.916
5732	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 28}	2025-07-27 09:20:12.123
5737	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 09:20:15.832
4976	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 99}	2025-07-27 08:40:03.207
4978	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 99}	2025-07-27 08:40:04.021
4980	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23, "Battery": 53}	2025-07-27 08:40:05.283
4982	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.9, "Battery": 71}	2025-07-27 08:40:05.956
4984	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.3, "Battery": 99}	2025-07-27 08:40:09.998
6096	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.6, "Battery": 53}	2025-07-27 09:40:03.287
6098	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 99}	2025-07-27 09:40:04.508
6100	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.5, "Battery": 99}	2025-07-27 09:40:05.291
6101	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.9, "Battery": 99}	2025-07-27 09:40:08.208
6102	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 71}	2025-07-27 09:40:10.115
6103	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 09:40:11.379
6104	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 09:40:11.552
3357	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 64, "Pressure": 1009.3, "AbsolutePressure": 1006.4, "Noise": 32, "CO2": 515}	2025-07-26 13:53:33
3358	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.9, "Battery": 61}	2025-07-26 14:00:08.726
3359	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-07-26 14:00:11.787
6095	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-27 09:40:02.729
3361	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 69}	2025-07-26 14:00:14.096
3362	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.3, "Battery": 84}	2025-07-26 14:00:14.922
3722	shellytrv-588e81617272	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-26 14:20:01.587
3365	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 49}	2025-07-26 14:00:17.301
3366	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.5, "Battery": 99}	2025-07-26 14:00:22.162
3726	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 99}	2025-07-26 14:20:03.737
3728	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 28}	2025-07-26 14:20:05.161
3730	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.4, "Battery": 53}	2025-07-26 14:20:08.156
3370	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 58}	2025-07-26 14:00:32.53
3736	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 61}	2025-07-26 14:20:16.8
3374	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 76}	2025-07-26 14:00:36.815
3738	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.1, "Battery": 71}	2025-07-26 14:20:23.78
4457	70:ee:50:83:2e:54	{"temperature": 24.6, "humidity": 64, "Pressure": 1012.4, "AbsolutePressure": 1006.8, "Noise": 34, "CO2": 500}	2025-07-26 14:59:39
4459	70:ee:50:83:2f:44	{"temperature": 24.8, "humidity": 65, "Pressure": 1012.4, "AbsolutePressure": 1006.8, "Noise": 32, "CO2": 589}	2025-07-26 14:58:50
4461	70:ee:50:83:2a:82	{"temperature": 22.9, "humidity": 69, "Pressure": 1008.7, "AbsolutePressure": 1007.3, "Noise": 32, "CO2": 474}	2025-07-26 14:50:52
4463	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-26 15:00:03.118
4465	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.9, "Battery": 61}	2025-07-26 15:00:03.464
4467	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-26 15:00:04.048
4469	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-07-26 15:00:05.818
4471	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21.1, "Battery": 99}	2025-07-26 15:00:07.909
4473	70:ee:50:83:2a:6c	{"temperature": 23.6, "humidity": 68, "Pressure": 1011.8, "AbsolutePressure": 1006.2, "Noise": 32, "CO2": 459}	2025-07-26 14:53:01
4475	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 64, "Pressure": 1009.3, "AbsolutePressure": 1006.4, "Noise": 32, "CO2": 491}	2025-07-26 14:53:55
4479	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 69}	2025-07-26 15:00:13.657
4483	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 99}	2025-07-26 15:00:24.156
5343	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 09:00:01.457
5347	70:ee:50:83:2a:82	{"temperature": 23.1, "humidity": 66, "Pressure": 1006.7, "AbsolutePressure": 1005.3, "Noise": 32, "CO2": 475}	2025-07-27 08:59:38
5349	70:ee:50:83:32:66	{"temperature": 22, "humidity": 69, "Pressure": 1010.9, "AbsolutePressure": 1008, "Noise": 31, "CO2": 393}	2025-07-27 08:53:47
5351	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1010.4, "AbsolutePressure": 1004.8, "Noise": 32, "CO2": 522}	2025-07-27 08:56:52
5353	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 39}	2025-07-27 09:00:04.88
5355	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 09:00:05.098
5357	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 09:00:05.597
5359	70:ee:50:83:2a:36	{"temperature": 24.2, "humidity": 65, "Pressure": 1009.8, "AbsolutePressure": 1004.2, "Noise": 32, "CO2": 469}	2025-07-27 08:57:18
5361	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 09:00:07.654
4090	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.4, "Battery": 54}	2025-07-26 14:40:02.963
4092	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-26 14:40:03.436
4098	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.5, "Battery": 99}	2025-07-26 14:40:10.072
5371	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 09:00:28.131
5723	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 09:20:01.743
5725	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 99}	2025-07-27 09:20:03.344
5727	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 27}	2025-07-27 09:20:05.034
5729	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.2, "Battery": 52}	2025-07-27 09:20:07.331
5733	shellytrv-588e81617272	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.3, "Battery": 99}	2025-07-27 09:20:13.194
5736	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 71}	2025-07-27 09:20:15.666
5740	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 61}	2025-07-27 09:20:25.148
5742	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.1, "Battery": 85}	2025-07-27 09:20:27.184
4975	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 99}	2025-07-27 08:40:02.858
4981	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-27 08:40:05.5
4983	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 99}	2025-07-27 08:40:08.004
6851	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 99}	2025-07-27 10:20:11.008
6853	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 10:20:13.56
6857	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 27}	2025-07-27 10:20:19.577
6863	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 61}	2025-07-27 10:20:28.362
6865	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.1, "Battery": 85}	2025-07-27 10:20:32.356
8691	70:ee:50:83:2e:54	{"temperature": 24.9, "humidity": 62, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 32, "CO2": 439}	2025-07-27 11:51:19
8695	70:ee:50:83:2f:44	{"temperature": 25, "humidity": 64, "Pressure": 1009.2, "AbsolutePressure": 1003.6, "Noise": 32, "CO2": 478}	2025-07-27 11:58:58
8697	70:ee:50:83:32:66	{"temperature": 22, "humidity": 69, "Pressure": 1009.8, "AbsolutePressure": 1006.9, "Noise": 31, "CO2": 420}	2025-07-27 11:55:34
8699	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 32, "CO2": 510}	2025-07-27 11:58:44
8703	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 39}	2025-07-27 12:00:05.202
8705	70:ee:50:83:2a:6c	{"temperature": 23.4, "humidity": 63, "Pressure": 1008.7, "AbsolutePressure": 1003.1, "Noise": 32, "CO2": 428}	2025-07-27 11:55:27
8707	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1006.2, "AbsolutePressure": 1003.3, "Noise": 32, "CO2": 429}	2025-07-27 11:51:19
8709	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.2, "Battery": 84}	2025-07-27 12:00:08.032
8325	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.8, "Battery": 53}	2025-07-27 11:40:04.531
8329	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-27 11:40:07.306
8331	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 11:40:09.799
8333	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.2, "Battery": 99}	2025-07-27 11:40:10.611
9069	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 12:20:01.469
8714	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 84}	2025-07-27 12:00:21.558
7955	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 11:20:01.409
7959	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 27}	2025-07-27 11:20:06.49
7961	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 99}	2025-07-27 11:20:09.875
9072	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.3, "Battery": 52}	2025-07-27 12:20:06.038
7965	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.2, "Battery": 52}	2025-07-27 11:20:16.907
7967	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 99}	2025-07-27 11:20:18.832
9073	shellytrv-588e81617272	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.1, "Battery": 99}	2025-07-27 12:20:07.201
7971	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 61}	2025-07-27 11:20:29.448
7572	70:ee:50:83:2e:54	{"temperature": 25, "humidity": 62, "Pressure": 1010, "AbsolutePressure": 1004.4, "Noise": 32, "CO2": 438}	2025-07-27 10:50:46
7574	70:ee:50:83:4e:60	{"temperature": 26.2, "humidity": 61, "Pressure": 1010.2, "AbsolutePressure": 1004.6, "Noise": 32, "CO2": 529}	2025-07-27 10:56:14
7576	70:ee:50:83:2a:82	{"temperature": 23, "humidity": 66, "Pressure": 1006.4, "AbsolutePressure": 1005, "Noise": 32, "CO2": 463}	2025-07-27 10:50:31
7578	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 11:00:03.596
7206	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 24, "Battery": 52}	2025-07-27 10:40:02.666
7208	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.9, "Battery": 99}	2025-07-27 10:40:03.545
7210	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.8, "Battery": 99}	2025-07-27 10:40:05.07
7212	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 71}	2025-07-27 10:40:06.208
7214	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 10:40:06.754
7580	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 11:00:04.066
7582	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 39}	2025-07-27 11:00:04.374
9074	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 12:20:10.432
7586	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 65, "Pressure": 1006.7, "AbsolutePressure": 1003.8, "Noise": 32, "CO2": 433}	2025-07-27 10:54:00
7588	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.1, "Battery": 83}	2025-07-27 11:00:06.48
7590	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 11:00:07.125
9075	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 99}	2025-07-27 12:20:10.665
9077	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.5, "Battery": 27}	2025-07-27 12:20:12.208
7596	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 55}	2025-07-27 11:00:14.8
7598	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 11:00:17.027
7600	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 84}	2025-07-27 11:00:17.857
8721	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.3, "Battery": 99}	2025-07-27 12:00:35.932
9079	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 99}	2025-07-27 12:20:14.992
9084	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 61}	2025-07-27 12:20:31.181
9086	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 85}	2025-07-27 12:20:33.728
9087	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.6, "Battery": 28}	2025-07-27 12:20:33.841
6470	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1009.9, "AbsolutePressure": 1004.3, "Noise": 32, "CO2": 501}	2025-07-27 09:57:28
6471	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 39}	2025-07-27 10:00:03.816
6473	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 66, "Pressure": 1006.7, "AbsolutePressure": 1003.8, "Noise": 31, "CO2": 441}	2025-07-27 09:53:23
6474	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 10:00:04.226
6475	70:ee:50:83:2a:6c	{"temperature": 23.4, "humidity": 63, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 33, "CO2": 445}	2025-07-27 09:54:15
6476	70:ee:50:83:2a:36	{"temperature": 24.2, "humidity": 65, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 32, "CO2": 447}	2025-07-27 09:57:51
6477	shellytrv-8cf681cd22c2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 10:00:05.027
6479	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.1, "Battery": 83}	2025-07-27 10:00:05.299
6480	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1006.9, "AbsolutePressure": 1004, "Noise": 32, "CO2": 440}	2025-07-27 09:50:35
6481	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 10:00:06.083
6482	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 10:00:06.388
6483	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 68}	2025-07-27 10:00:09.852
6484	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 10:00:10.054
6846	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 10:20:02.061
6487	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 10:00:15.043
6848	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.2, "Battery": 52}	2025-07-27 10:20:05.006
6489	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 55}	2025-07-27 10:00:17.631
6850	shellytrv-588e81617272	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 10:20:08.732
6493	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 75}	2025-07-27 10:00:30.733
6856	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 27}	2025-07-27 10:20:19.404
6860	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 99}	2025-07-27 10:20:24.994
6862	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 71}	2025-07-27 10:20:25.336
8692	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 12:00:01.604
8694	70:ee:50:83:4e:60	{"temperature": 26, "humidity": 61, "Pressure": 1009.6, "AbsolutePressure": 1004, "Noise": 32, "CO2": 540}	2025-07-27 11:56:42
8696	70:ee:50:83:2a:82	{"temperature": 22.9, "humidity": 66, "Pressure": 1005.7, "AbsolutePressure": 1004.3, "Noise": 32, "CO2": 451}	2025-07-27 11:51:01
8700	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 12:00:04.738
8702	70:ee:50:83:35:00	{"temperature": 23.3, "humidity": 65, "Pressure": 1006, "AbsolutePressure": 1003.1, "Noise": 32, "CO2": 438}	2025-07-27 11:54:37
8704	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 12:00:05.464
8706	70:ee:50:83:2a:36	{"temperature": 24.3, "humidity": 65, "Pressure": 1008.7, "AbsolutePressure": 1003.1, "Noise": 32, "CO2": 440}	2025-07-27 11:58:58
8708	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 12:00:07.483
8713	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 12:00:15.687
8326	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 11:40:04.759
8328	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 71}	2025-07-27 11:40:07.115
8330	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.7, "Battery": 99}	2025-07-27 11:40:07.728
8332	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-27 11:40:10.448
7960	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 11:20:09.605
7966	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.6, "Battery": 27}	2025-07-27 11:20:18.007
7575	70:ee:50:83:2f:44	{"temperature": 25.3, "humidity": 63, "Pressure": 1009.9, "AbsolutePressure": 1004.3, "Noise": 32, "CO2": 524}	2025-07-27 10:58:29
7577	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 11:00:03.374
7205	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.7, "Battery": 99}	2025-07-27 10:40:02.309
7207	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.3, "Battery": 99}	2025-07-27 10:40:02.954
7579	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 69, "Pressure": 1010.4, "AbsolutePressure": 1007.5, "Noise": 31, "CO2": 413}	2025-07-27 10:54:58
7213	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24, "Battery": 99}	2025-07-27 10:40:06.543
7583	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1010, "AbsolutePressure": 1004.4, "Noise": 32, "CO2": 492}	2025-07-27 10:58:07
7585	shellytrv-8cf681cd22c2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-07-27 11:00:05.193
7587	70:ee:50:83:2a:6c	{"temperature": 23.5, "humidity": 63, "Pressure": 1009.4, "AbsolutePressure": 1003.8, "Noise": 32, "CO2": 428}	2025-07-27 10:54:51
7589	70:ee:50:83:2a:36	{"temperature": 24.3, "humidity": 65, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 32, "CO2": 459}	2025-07-27 10:58:25
7591	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1006.9, "AbsolutePressure": 1004, "Noise": 32, "CO2": 440}	2025-07-27 10:45:57
7593	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 69}	2025-07-27 11:00:13.613
7595	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 11:00:14.477
7599	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 11:00:17.593
12041	70:ee:50:83:2e:54	{"temperature": 24.7, "humidity": 62, "Pressure": 1008.9, "AbsolutePressure": 1003.3, "Noise": 31, "CO2": 447}	2025-07-27 14:52:59
9809	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 13:00:02.279
10559	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 13:40:03.275
9813	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-27 13:00:04.334
9815	70:ee:50:83:2a:82	{"temperature": 22.8, "humidity": 66, "Pressure": 1005.7, "AbsolutePressure": 1004.3, "Noise": 32, "CO2": 451}	2025-07-27 12:51:29
9817	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 69, "Pressure": 1009.8, "AbsolutePressure": 1006.9, "Noise": 31, "CO2": 405}	2025-07-27 12:56:09
9819	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 13:00:06.183
9821	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 65, "Pressure": 1006.1, "AbsolutePressure": 1003.2, "Noise": 32, "CO2": 440}	2025-07-27 12:55:13
9823	70:ee:50:83:2a:36	{"temperature": 24.3, "humidity": 65, "Pressure": 1008.7, "AbsolutePressure": 1003.1, "Noise": 32, "CO2": 449}	2025-07-27 12:59:31
9825	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 13:00:08.944
10561	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.7, "Battery": 99}	2025-07-27 13:40:03.879
9829	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 55}	2025-07-27 13:00:19.801
9831	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 13:00:22.886
12043	70:ee:50:83:4e:60	{"temperature": 25.4, "humidity": 62, "Pressure": 1009.1, "AbsolutePressure": 1003.5, "Noise": 32, "CO2": 510}	2025-07-27 14:58:11
9835	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 13:00:27.941
10565	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 71}	2025-07-27 13:40:07.158
10567	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 13:40:09.001
11309	shellytrv-588e81617272	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.1, "Battery": 99}	2025-07-27 14:20:05.955
11311	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.3, "Battery": 52}	2025-07-27 14:20:07.921
12045	70:ee:50:83:2f:44	{"temperature": 24.7, "humidity": 63, "Pressure": 1008.8, "AbsolutePressure": 1003.2, "Noise": 32, "CO2": 464}	2025-07-27 14:50:22
12047	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 69, "Pressure": 1009.4, "AbsolutePressure": 1006.5, "Noise": 32, "CO2": 405}	2025-07-27 14:57:21
12049	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 15:00:03.75
12051	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 65, "Pressure": 1005.6, "AbsolutePressure": 1002.7, "Noise": 32, "CO2": 397}	2025-07-27 14:56:25
12053	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-27 15:00:04.964
11323	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 71}	2025-07-27 14:20:38.11
11325	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 62}	2025-07-27 14:20:41.665
12056	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 15:00:05.709
9443	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 25, "Battery": 99}	2025-07-27 12:40:06.978
9445	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-27 12:40:08.933
9447	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.9, "Battery": 99}	2025-07-27 12:40:11.605
9449	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 12:40:13.454
9451	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.7, "Battery": 99}	2025-07-27 12:40:14.79
10189	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.5, "Battery": 27}	2025-07-27 13:20:04.321
10191	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 99}	2025-07-27 13:20:07.494
10193	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 13:20:10.153
10195	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 13:20:12.226
10199	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 71}	2025-07-27 13:20:19.549
10927	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 14:00:02.036
10929	70:ee:50:83:2f:44	{"temperature": 24.8, "humidity": 63, "Pressure": 1009.2, "AbsolutePressure": 1003.6, "Noise": 32, "CO2": 475}	2025-07-27 13:59:58
10931	70:ee:50:83:2a:82	{"temperature": 22.9, "humidity": 66, "Pressure": 1005.6, "AbsolutePressure": 1004.2, "Noise": 32, "CO2": 451}	2025-07-27 13:52:00
10935	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 14:00:05.329
10937	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.1, "Battery": 83}	2025-07-27 14:00:06.153
10939	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 65, "Pressure": 1006, "AbsolutePressure": 1003.1, "Noise": 31, "CO2": 430}	2025-07-27 13:55:49
10941	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 14:00:10.828
10945	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 14:00:12.647
10951	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 14:00:25.168
11675	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-27 14:40:03.753
10955	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 14:00:40.821
11677	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 71}	2025-07-27 14:40:06.651
10959	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 84}	2025-07-27 14:00:45.869
11679	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.3, "Battery": 99}	2025-07-27 14:40:07.997
11681	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-27 14:40:09.627
9090	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.1, "Battery": 71}	2025-07-27 12:20:35.778
9808	70:ee:50:83:2e:54	{"temperature": 24.9, "humidity": 62, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 32, "CO2": 439}	2025-07-27 12:51:52
9810	70:ee:50:83:4e:60	{"temperature": 25.9, "humidity": 61, "Pressure": 1009.6, "AbsolutePressure": 1004, "Noise": 32, "CO2": 517}	2025-07-27 12:57:12
9812	70:ee:50:83:2f:44	{"temperature": 24.9, "humidity": 63, "Pressure": 1009.4, "AbsolutePressure": 1003.8, "Noise": 32, "CO2": 502}	2025-07-27 12:59:28
9814	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 13:00:04.688
10558	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.6, "Battery": 53}	2025-07-27 13:40:01.783
9818	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1009.4, "AbsolutePressure": 1003.8, "Noise": 32, "CO2": 506}	2025-07-27 12:59:22
9820	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.1, "Battery": 84}	2025-07-27 13:00:06.695
9822	70:ee:50:83:2a:6c	{"temperature": 23.5, "humidity": 63, "Pressure": 1008.7, "AbsolutePressure": 1003.1, "Noise": 32, "CO2": 421}	2025-07-27 12:56:03
9824	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1006.2, "AbsolutePressure": 1003.3, "Noise": 32, "CO2": 429}	2025-07-27 12:51:40
11306	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 14:20:01.928
10562	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.1, "Battery": 99}	2025-07-27 13:40:04.25
10564	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.4, "Battery": 99}	2025-07-27 13:40:06.47
10566	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 13:40:07.35
9834	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 84}	2025-07-27 13:00:26.287
11310	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.5, "Battery": 27}	2025-07-27 14:20:07.274
11312	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 99}	2025-07-27 14:20:10.226
12044	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 15:00:02.17
12046	70:ee:50:83:2a:82	{"temperature": 22.8, "humidity": 66, "Pressure": 1005.2, "AbsolutePressure": 1003.8, "Noise": 32, "CO2": 433}	2025-07-27 14:52:29
12048	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1008.9, "AbsolutePressure": 1003.3, "Noise": 32, "CO2": 478}	2025-07-27 14:50:29
11322	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 85}	2025-07-27 14:20:37.073
12054	70:ee:50:83:2a:6c	{"temperature": 23.4, "humidity": 63, "Pressure": 1008.3, "AbsolutePressure": 1002.7, "Noise": 32, "CO2": 428}	2025-07-27 14:57:16
12055	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 65, "Pressure": 1008.1, "AbsolutePressure": 1002.5, "Noise": 32, "CO2": 449}	2025-07-27 14:50:32
12057	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1005.8, "AbsolutePressure": 1002.9, "Noise": 32, "CO2": 440}	2025-07-27 14:52:23
12058	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 15:00:06.446
12059	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.1, "Battery": 83}	2025-07-27 15:00:07.866
12063	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 55}	2025-07-27 15:00:15.003
12064	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 15:00:19.179
12066	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 15:00:22.527
12067	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 84}	2025-07-27 15:00:22.804
9440	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.8, "Battery": 53}	2025-07-27 12:40:03.614
9444	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 71}	2025-07-27 12:40:07.256
9446	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 12:40:11.224
10192	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.3, "Battery": 52}	2025-07-27 13:20:08.567
10198	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 99}	2025-07-27 13:20:16.262
10200	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 28}	2025-07-27 13:20:20.603
10202	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 85}	2025-07-27 13:20:22.707
10204	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 61}	2025-07-27 13:20:24.092
10926	70:ee:50:83:2e:54	{"temperature": 24.8, "humidity": 62, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 32, "CO2": 423}	2025-07-27 13:52:26
10928	70:ee:50:83:4e:60	{"temperature": 25.6, "humidity": 61, "Pressure": 1009.5, "AbsolutePressure": 1003.9, "Noise": 32, "CO2": 495}	2025-07-27 13:57:42
10932	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 39}	2025-07-27 14:00:04.046
10934	70:ee:50:83:32:66	{"temperature": 22, "humidity": 69, "Pressure": 1009.7, "AbsolutePressure": 1006.8, "Noise": 31, "CO2": 400}	2025-07-27 13:56:44
10936	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 14:00:05.748
10938	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1009.3, "AbsolutePressure": 1003.7, "Noise": 32, "CO2": 502}	2025-07-27 13:59:58
10940	70:ee:50:83:2a:6c	{"temperature": 23.4, "humidity": 63, "Pressure": 1008.7, "AbsolutePressure": 1003.1, "Noise": 32, "CO2": 432}	2025-07-27 13:56:40
10942	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 65, "Pressure": 1008.6, "AbsolutePressure": 1003, "Noise": 32, "CO2": 468}	2025-07-27 14:00:04
10944	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1006.2, "AbsolutePressure": 1003.3, "Noise": 32, "CO2": 444}	2025-07-27 13:52:01
11678	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.9, "Battery": 99}	2025-07-27 14:40:07.373
11680	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 14:40:08.658
11682	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.5, "Battery": 99}	2025-07-27 14:40:11.279
11684	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.5, "Battery": 53}	2025-07-27 14:40:13.343
13542	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 16:20:02.706
15394	70:ee:50:83:2e:54	{"temperature": 24.5, "humidity": 62, "Pressure": 1008.1, "AbsolutePressure": 1002.5, "Noise": 32, "CO2": 422}	2025-07-27 17:54:40
13546	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 16:20:04.933
15395	70:ee:50:83:4e:60	{"temperature": 25, "humidity": 62, "Pressure": 1008.3, "AbsolutePressure": 1002.7, "Noise": 32, "CO2": 531}	2025-07-27 17:59:39
13550	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.6, "Battery": 99}	2025-07-27 16:20:11.59
15397	70:ee:50:83:2f:44	{"temperature": 24.5, "humidity": 63, "Pressure": 1008.1, "AbsolutePressure": 1002.5, "Noise": 32, "CO2": 466}	2025-07-27 17:51:53
15398	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 18:00:02.129
15399	70:ee:50:83:2a:82	{"temperature": 22.8, "humidity": 66, "Pressure": 1004.5, "AbsolutePressure": 1003.1, "Noise": 32, "CO2": 430}	2025-07-27 17:53:57
13909	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 99}	2025-07-27 16:40:02.511
13911	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.3, "Battery": 53}	2025-07-27 16:40:03.624
13913	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24, "Battery": 99}	2025-07-27 16:40:05.737
13915	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 71}	2025-07-27 16:40:06.638
13917	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 16:40:09.997
13919	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 99}	2025-07-27 16:40:12.709
12426	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.3, "Battery": 99}	2025-07-27 15:20:05.296
12428	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.3, "Battery": 52}	2025-07-27 15:20:06.9
12432	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.5, "Battery": 99}	2025-07-27 15:20:14.102
12434	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.6, "Battery": 27}	2025-07-27 15:20:15.453
12440	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 62}	2025-07-27 15:20:32.807
15027	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 17:40:02.839
14279	70:ee:50:83:4e:60	{"temperature": 25.1, "humidity": 62, "Pressure": 1008.4, "AbsolutePressure": 1002.8, "Noise": 32, "CO2": 517}	2025-07-27 16:59:10
14281	70:ee:50:83:2a:82	{"temperature": 22.8, "humidity": 66, "Pressure": 1004.6, "AbsolutePressure": 1003.2, "Noise": 32, "CO2": 426}	2025-07-27 16:53:27
12797	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 24.2, "Battery": 99}	2025-07-27 15:40:05.058
12799	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.8, "Battery": 99}	2025-07-27 15:40:10.436
12801	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 15:40:11.697
14283	70:ee:50:83:32:66	{"temperature": 22, "humidity": 69, "Pressure": 1008.7, "AbsolutePressure": 1005.8, "Noise": 31, "CO2": 391}	2025-07-27 16:58:30
14285	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1008.3, "AbsolutePressure": 1002.7, "Noise": 32, "CO2": 502}	2025-07-27 16:51:41
14287	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 17:00:05.455
14289	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.2, "Battery": 84}	2025-07-27 17:00:06.054
14291	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 65, "Pressure": 1007.6, "AbsolutePressure": 1002, "Noise": 32, "CO2": 432}	2025-07-27 16:51:40
14293	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 17:00:08.844
15029	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 99}	2025-07-27 17:40:04.355
14662	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 27}	2025-07-27 17:20:06.623
14299	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 17:00:17.724
14664	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.3, "Battery": 52}	2025-07-27 17:20:08.219
14303	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 17:00:25.316
14305	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 55}	2025-07-27 17:00:29.342
15031	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.2, "Battery": 53}	2025-07-27 17:40:05.322
14668	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 99}	2025-07-27 17:20:14.289
14670	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23, "Battery": 71}	2025-07-27 17:20:18.601
13159	70:ee:50:83:2e:54	{"temperature": 24.6, "humidity": 62, "Pressure": 1008.3, "AbsolutePressure": 1002.7, "Noise": 32, "CO2": 418}	2025-07-27 15:53:32
13161	70:ee:50:83:4e:60	{"temperature": 25.3, "humidity": 62, "Pressure": 1008.6, "AbsolutePressure": 1003, "Noise": 32, "CO2": 502}	2025-07-27 15:58:40
13163	70:ee:50:83:2a:82	{"temperature": 22.8, "humidity": 66, "Pressure": 1004.7, "AbsolutePressure": 1003.3, "Noise": 32, "CO2": 433}	2025-07-27 15:52:57
13165	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.8, "Battery": 61}	2025-07-27 16:00:03.651
15033	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 99}	2025-07-27 17:40:06.971
15035	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 99}	2025-07-27 17:40:07.611
13171	70:ee:50:83:2a:6c	{"temperature": 23.5, "humidity": 63, "Pressure": 1007.8, "AbsolutePressure": 1002.2, "Noise": 32, "CO2": 420}	2025-07-27 15:57:52
13173	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1005.2, "AbsolutePressure": 1002.3, "Noise": 32, "CO2": 421}	2025-07-27 15:52:44
13175	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.1, "Battery": 84}	2025-07-27 16:00:08.304
13177	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 16:00:10.386
13183	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-27 16:00:16.038
12070	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.3, "Battery": 99}	2025-07-27 15:00:27.773
15884	70:ee:50:83:4e:60	{"temperature": 26.5, "humidity": 51, "Pressure": 1007.8, "AbsolutePressure": 1002.2, "Noise": 32, "CO2": 519}	2025-08-01 10:51:55
15888	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 38}	2025-08-01 11:00:03.653
13543	shellytrv-588e81617272	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21, "Battery": 99}	2025-07-27 16:20:02.892
15892	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-08-01 11:00:05.313
13547	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 19.3, "Battery": 52}	2025-07-27 16:20:06.167
13549	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 27}	2025-07-27 16:20:11.405
15896	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.3, "Battery": 99}	2025-08-01 11:00:07.055
15903	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 48}	2025-08-01 11:00:13.551
13557	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 61}	2025-07-27 16:20:31.492
13914	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-27 16:40:05.919
13916	shellytrv-bc33ac022fa8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.7, "Battery": 99}	2025-07-27 16:40:06.822
12423	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.6, "Battery": 99}	2025-07-27 15:20:02.62
12427	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 27}	2025-07-27 15:20:05.832
12429	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 15:20:10.493
12437	shellytrv-8cf681b9c924	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 85}	2025-07-27 15:20:23.88
14276	70:ee:50:83:2e:54	{"temperature": 24.5, "humidity": 62, "Pressure": 1008.2, "AbsolutePressure": 1002.6, "Noise": 31, "CO2": 432}	2025-07-27 16:54:07
14278	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 17:00:01.245
14280	70:ee:50:83:2f:44	{"temperature": 24.6, "humidity": 63, "Pressure": 1008.2, "AbsolutePressure": 1002.6, "Noise": 32, "CO2": 501}	2025-07-27 16:51:24
12792	shellytrv-588e81a41b41	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.4, "Battery": 53}	2025-07-27 15:40:02.505
12794	shellytrv-842e14fe1fc2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 99}	2025-07-27 15:40:03.974
12796	shellytrv-842e14ffcbea	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-27 15:40:04.873
12798	shellytrv-842e14ffca22	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.5, "Battery": 99}	2025-07-27 15:40:08.007
14284	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 17:00:03.837
12802	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 71}	2025-07-27 15:40:12.212
14659	shellytrv-8cf681be083a	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 17:20:04.562
14288	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 65, "Pressure": 1004.9, "AbsolutePressure": 1002, "Noise": 31, "CO2": 415}	2025-07-27 16:57:38
14290	70:ee:50:83:2a:6c	{"temperature": 23.5, "humidity": 64, "Pressure": 1007.6, "AbsolutePressure": 1002, "Noise": 32, "CO2": 423}	2025-07-27 16:58:29
14292	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1005.1, "AbsolutePressure": 1002.2, "Noise": 32, "CO2": 424}	2025-07-27 16:53:05
14294	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-27 17:00:09.243
14296	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 68}	2025-07-27 17:00:12.031
14661	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 99}	2025-07-27 17:20:06.406
14663	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.2, "Battery": 99}	2025-07-27 17:20:07.455
14665	shellytrv-cc86ecb3e4cd	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.6, "Battery": 27}	2025-07-27 17:20:10.383
14304	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 17:00:27.404
14671	shellytrv-842e14ffaf1c	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 61}	2025-07-27 17:20:20.539
15032	shellytrv-bc33ac022fb6	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.9, "Battery": 99}	2025-07-27 17:40:05.643
15034	shellytrv-588e81a41b77	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 71}	2025-07-27 17:40:07.2
15036	shellytrv-8cf681a52e44	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 17:40:08.534
13162	70:ee:50:83:2f:44	{"temperature": 24.6, "humidity": 63, "Pressure": 1008.3, "AbsolutePressure": 1002.7, "Noise": 32, "CO2": 488}	2025-07-27 15:50:52
13164	70:ee:50:83:32:66	{"temperature": 22.1, "humidity": 69, "Pressure": 1008.8, "AbsolutePressure": 1005.9, "Noise": 31, "CO2": 416}	2025-07-27 15:57:55
13166	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1008.3, "AbsolutePressure": 1002.7, "Noise": 32, "CO2": 481}	2025-07-27 15:51:05
13168	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 16:00:04.012
13170	70:ee:50:83:35:00	{"temperature": 23.4, "humidity": 65, "Pressure": 1005.1, "AbsolutePressure": 1002.2, "Noise": 31, "CO2": 407}	2025-07-27 15:57:02
13172	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 65, "Pressure": 1007.7, "AbsolutePressure": 1002.1, "Noise": 32, "CO2": 434}	2025-07-27 15:51:06
13174	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.1, "Battery": 99}	2025-07-27 16:00:07.175
13176	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 16:00:09.588
13180	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 68}	2025-07-27 16:00:14.21
13182	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 55}	2025-07-27 16:00:15.165
13184	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 16:00:18.687
13186	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 16:00:23.567
13192	shellytrv-8cf681d9a230	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 84}	2025-07-27 16:00:38.741
15885	70:ee:50:83:2f:44	{"temperature": 25.4, "humidity": 53, "Pressure": 1007.5, "AbsolutePressure": 1001.9, "Noise": 32, "CO2": 515}	2025-08-01 10:56:06
15889	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-08-01 11:00:03.832
15893	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 20.6, "Battery": 99}	2025-08-01 11:00:06.373
15897	70:ee:50:83:35:00	{"temperature": 22.6, "humidity": 58, "Pressure": 1004.2, "AbsolutePressure": 1001.3, "Noise": 38, "CO2": 495}	2025-08-01 10:51:57
15904	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 21.9, "Battery": 83}	2025-08-01 11:00:13.799
16212	shellytrv-8cf681b70e6c	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 18.9, "Battery": 52}	2025-08-01 11:20:08.721
16227	shellytrv-8cf681b9c924	{"ValvePosition": -1, "TargetTemperature": 31, "Temperature": 22.3, "Battery": 92}	2025-08-01 11:20:38.663
15886	shellytrv-b4e3f9d9e3d7	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 60}	2025-08-01 11:00:02.321
15890	70:ee:50:83:32:66	{"temperature": 21.6, "humidity": 65, "Pressure": 1008, "AbsolutePressure": 1005.1, "Noise": 32, "CO2": 458}	2025-08-01 10:53:30
15898	shellytrv-8cf681b70b5e	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 45}	2025-08-01 11:00:08.713
15901	70:ee:50:83:2a:36	{"temperature": 23.4, "humidity": 62, "Pressure": 1006.8, "AbsolutePressure": 1001.3, "Noise": 35, "CO2": 501}	2025-08-01 10:55:02
15905	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 99}	2025-08-01 11:00:16.614
15911	shellytrv-8cf681cd22c2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.9, "Battery": 99}	2025-08-01 11:00:27.209
16213	shellytrv-8cf681cd15a2	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 19.7, "Battery": 99}	2025-08-01 11:20:09.73
16222	shellytrv-b4e3f9d9bc83	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 99}	2025-08-01 11:20:26.88
16225	shellytrv-8cf681a51bae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 68}	2025-08-01 11:20:33.448
15400	70:ee:50:83:32:66	{"temperature": 22, "humidity": 69, "Pressure": 1008.5, "AbsolutePressure": 1005.6, "Noise": 31, "CO2": 405}	2025-07-27 17:59:07
15401	shellytrv-b4e3f9e30ab3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 18:00:03.487
15402	shellytrv-842e14ffcb48	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22, "Battery": 99}	2025-07-27 18:00:03.667
15404	70:ee:50:83:2f:6c	{"temperature": 24.2, "humidity": 69, "Pressure": 1008.1, "AbsolutePressure": 1002.5, "Noise": 32, "CO2": 478}	2025-07-27 17:52:17
15406	shellytrv-8cf681d9a228	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 39}	2025-07-27 18:00:04.71
15407	70:ee:50:83:35:00	{"temperature": 23.3, "humidity": 65, "Pressure": 1004.8, "AbsolutePressure": 1001.9, "Noise": 31, "CO2": 415}	2025-07-27 17:58:13
15408	shellytrv-b4e3f9d6249d	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 21, "Battery": 99}	2025-07-27 18:00:06.097
15409	70:ee:50:83:2a:6c	{"temperature": 23.5, "humidity": 64, "Pressure": 1007.5, "AbsolutePressure": 1001.9, "Noise": 32, "CO2": 426}	2025-07-27 17:59:05
15410	shellytrv-8cf681b9c952	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 18:00:07.08
15411	70:ee:50:83:2a:36	{"temperature": 24.4, "humidity": 65, "Pressure": 1007.5, "AbsolutePressure": 1001.9, "Noise": 32, "CO2": 435}	2025-07-27 17:52:13
15412	70:ee:50:83:4d:e8	{"temperature": 24.8, "humidity": 63, "Pressure": 1005, "AbsolutePressure": 1002.1, "Noise": 32, "CO2": 414}	2025-07-27 17:53:26
15883	70:ee:50:83:2e:54	{"temperature": 24.8, "humidity": 55, "Pressure": 1007.5, "AbsolutePressure": 1001.9, "Noise": 32, "CO2": 426}	2025-08-01 10:56:36
15887	70:ee:50:83:2a:82	{"temperature": 22.9, "humidity": 59, "Pressure": 1003.9, "AbsolutePressure": 1002.5, "Noise": 32, "CO2": 494}	2025-08-01 10:55:27
15891	70:ee:50:83:2f:6c	{"temperature": 23.9, "humidity": 59, "Pressure": 1007.6, "AbsolutePressure": 1002, "Noise": 41, "CO2": 826}	2025-08-01 10:55:29
15416	shellytrv-588e81a6306d	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 22.1, "Battery": 84}	2025-07-27 18:00:20.921
15418	shellytrv-8cf681c1abc8	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 49}	2025-07-27 18:00:23.019
15899	70:ee:50:83:2a:6c	{"temperature": 23, "humidity": 58, "Pressure": 1006.9, "AbsolutePressure": 1001.4, "Noise": 33, "CO2": 467}	2025-08-01 10:54:57
15420	shellytrv-8cf681b9c9ae	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 68}	2025-07-27 18:00:24.019
15902	70:ee:50:83:4d:e8	{"temperature": 24.1, "humidity": 58, "Pressure": 1004.4, "AbsolutePressure": 1001.5, "Noise": 67, "CO2": 506}	2025-08-01 10:50:50
15422	shellytrv-8cf681be1608	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 99}	2025-07-27 18:00:26.532
16211	shellytrv-842e14fe1d64	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.3, "Battery": 24}	2025-08-01 11:20:07.448
16214	shellytrv-8cf681cd1598	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-08-01 11:20:12.271
16217	shellytrv-8cf681e9a780	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 99}	2025-08-01 11:20:14.037
\.


--
-- Data for Name: sensor_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sensor_types (id, type) FROM stdin;
1	AirQuality
2	Heater
3	EnergyMeter
\.


--
-- Data for Name: sensors; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sensors (id, name, location, latest_data, last_updated, building_id, type_id) FROM stdin;
70:ee:50:83:2f:6c	AirQuality_DirectorOffice	Director Office	{"temperature": 23.9, "humidity": 59, "Pressure": 1007.6, "AbsolutePressure": 1002, "Noise": 41, "CO2": 826}	2025-08-01 10:55:29	1	1
70:ee:50:83:4e:60	AirQuality_ClassRoom2	Classroom 2	{"temperature": 26.5, "humidity": 51, "Pressure": 1007.8, "AbsolutePressure": 1002.2, "Noise": 32, "CO2": 519}	2025-08-01 10:51:55	1	1
70:ee:50:83:2e:4e	AirQuality_ViceDirectorOffice	Vice Director Office	{}	\N	1	1
shellytrv-8cf681b9c952	Heater_Corridor_4	Corridor	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.3, "Battery": 99}	2025-08-01 11:00:07.055	1	2
shellytrv-8cf681a52e44	Heater_ClassRoom5_3	Classroom 5	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.4, "Battery": 99}	2025-07-27 17:40:08.534	1	2
shellytrv-8cf681b70b5e	Heater_Corridor_3	Corridor	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.2, "Battery": 45}	2025-08-01 11:00:08.713	1	2
shellytrv-bc33ac022f76	Heater_ClassRoom2_1	Classroom 2	{}	\N	1	2
shellytrv-b4e3f9d9e3d7	Heater_Corridor_5	Corridor	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 20.2, "Battery": 60}	2025-08-01 11:00:02.321	1	2
shellytrv-588e816162de	Heater_ClassRoom3_1	Classroom 3	{}	\N	1	2
shellytrv-bc33ac022fa8	Heater_ClassRoom1_3	Classroom 1	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.6, "Battery": 99}	2025-07-27 17:40:02.839	1	2
shellytrv-588e81a63315	Heater_ClassRoom4_2	Classroom 4	{}	\N	1	2
shellytrv-588e81a41b47	Heater_ClassRoom5_1	Classroom 5	{}	\N	1	2
shellytrv-8cf681be1032	Heater_ClassRoom5_2	Classroom 5	{}	\N	1	2
shellytrv-8cf681b70b5a	Heater_ClassRoom5_4	Classroom 5	{}	\N	1	2
shellytrv-8cf681cd1598	Heater_StaffToilet	Staff toilet	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-08-01 11:20:12.271	1	2
shellytrv-b4e3f9e30ab3	Heater_Corridor_6	Corridor	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-08-01 11:00:03.832	1	2
shellytrv-8cf681a52e2e	Heater_Kitchen_1	Kitchen	{}	\N	1	2
shellytrv-8cf681e9a780	Heater_Corridor_8	Corridor	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 99}	2025-08-01 11:20:14.037	1	2
shellytrv-8cf681d9a228	Heater_Corridor_7	Corridor	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.9, "Battery": 38}	2025-08-01 11:00:03.653	1	2
shellytrv-8cf681a51bae	Heater_OfficeRoom1	Office room 1	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.4, "Battery": 68}	2025-08-01 11:20:33.448	1	2
shellytrv-b4e3f9d9bc83	Heater_OfficeRoom2	Office room 2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.3, "Battery": 99}	2025-08-01 11:20:26.88	1	2
shellytrv-8cf681b9c9ae	Heater_Kitchen_3	Kitchen	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 68}	2025-07-27 18:00:24.019	1	2
shellytrv-bc33ac022fb6	Heater_ClassRoom2_2	Classroom 2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.9, "Battery": 99}	2025-07-27 17:40:05.643	1	2
shellytrv-588e81a41b41	Heater_ClassRoom1_1	Classroom 1	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 23.2, "Battery": 53}	2025-07-27 17:40:05.322	1	2
70:ee:50:83:4d:e8	AirQuality_OfficeFirstFloor	Office 1st Floor	{"temperature": 24.1, "humidity": 58, "Pressure": 1004.4, "AbsolutePressure": 1001.5, "Noise": 67, "CO2": 506}	2025-08-01 10:50:50	1	1
shellytrv-588e81616fe8	Heater_ClassRoom3_3	Classroom 3	{"ValvePosition": 100, "TargetTemperature": 5, "Temperature": 22, "Battery": 70}	2025-07-06 17:40:11.503	1	2
shellytrv-8cf681be1608	Heater_ViceDirectorOffice	Vice Director Office	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 99}	2025-08-01 11:00:16.614	1	2
70:ee:50:83:2f:44	AirQuality_ClassRoom3	Classroom 3	{"temperature": 25.4, "humidity": 53, "Pressure": 1007.5, "AbsolutePressure": 1001.9, "Noise": 32, "CO2": 515}	2025-08-01 10:56:06	1	1
shellytrv-842e14fe1d64	Heater_ClassRoom4_3	Classroom 4	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.3, "Battery": 24}	2025-08-01 11:20:07.448	1	2
shellytrv-842e14ffcb48	Heater_Corridor_2	Corridor	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.8, "Battery": 99}	2025-08-01 11:00:05.313	1	2
shellytrv-b4e3f9d6249d	Heater_Corridor_9	Corridor	{"ValvePosition": 100, "TargetTemperature": 23, "Temperature": 20.6, "Battery": 99}	2025-08-01 11:00:06.373	1	2
shellytrv-842e14ffaf1c	Heater_OfficeRoom3	Office room 3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 61}	2025-07-27 17:20:20.539	1	2
70:ee:50:83:2a:36	AirQuality_CheckRoom	Checkroom	{"temperature": 23.4, "humidity": 62, "Pressure": 1006.8, "AbsolutePressure": 1001.3, "Noise": 35, "CO2": 501}	2025-08-01 10:55:02	1	1
shellytrv-8cf681cd15a2	Heater_Bathroom_2	Bathroom	{"ValvePosition": 100, "TargetTemperature": 21, "Temperature": 19.7, "Battery": 99}	2025-08-01 11:20:09.73	1	2
shellytrv-842e14ffca22	Heater_ClassRoom3_2	Classroom 3	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 99}	2025-07-27 17:40:07.611	1	2
shellytrv-588e81a41b77	Heater_ClassRoom1_2	Classroom 1	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 71}	2025-07-27 17:40:07.2	1	2
shellytrv-842e14fe1fc2	Heater_ClassRoom1_4	Classroom 1	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.3, "Battery": 99}	2025-07-27 17:40:04.355	1	2
70:ee:50:83:2a:6c	AirQuality_Kitchen	Kitchen	{"temperature": 23, "humidity": 58, "Pressure": 1006.9, "AbsolutePressure": 1001.4, "Noise": 33, "CO2": 467}	2025-08-01 10:54:57	1	1
shellytrv-8cf681be083a	Heater_Bathroom_3	Bathroom	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.7, "Battery": 99}	2025-07-27 17:20:04.562	1	2
shellytrv-8cf681cd22c2	Heater_Kitchen_4	Kitchen	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 20.9, "Battery": 99}	2025-08-01 11:00:27.209	1	2
shellytrv-588e81a6306d	Heater_Corridor_1	Corridor	{"ValvePosition": 0, "TargetTemperature": 20, "Temperature": 21.9, "Battery": 83}	2025-08-01 11:00:13.799	1	2
shellytrv-8cf681c1abc8	Heater_Kitchen_2	Kitchen	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21.4, "Battery": 48}	2025-08-01 11:00:13.551	1	2
70:ee:50:83:35:00	AirQuality_Corridor	Corridor	{"temperature": 22.6, "humidity": 58, "Pressure": 1004.2, "AbsolutePressure": 1001.3, "Noise": 38, "CO2": 495}	2025-08-01 10:51:57	1	1
shellytrv-8cf681b70e6c	Heater_Bathroom_1	Bathroom	{"ValvePosition": 100, "TargetTemperature": 22, "Temperature": 18.9, "Battery": 52}	2025-08-01 11:20:08.721	1	2
70:ee:50:83:2a:82	AirQuality_ClassRoom4	Classroom 4	{"temperature": 22.9, "humidity": 59, "Pressure": 1003.9, "AbsolutePressure": 1002.5, "Noise": 32, "CO2": 494}	2025-08-01 10:55:27	1	1
shellypro3em-34987a46bc6c	EnergyMeter_Kindergarden_3	Kindergarten	{"a_current": 0.028, "a_voltage": 233.3, "a_act_power": 1.1, "a_aprt_power": 6.6, "a_pf": 0.19, "a_freq": 50, "b_current": 0.086, "b_voltage": 231.3, "b_act_power": 8.8, "b_aprt_power": 19.9, "b_pf": 0.44, "b_freq": 50, "c_current": 0.028, "c_voltage": 230.7, "c_act_power": 0, "c_aprt_power": 6.5, "c_pf": 0, "c_freq": 50, "n_current": null, "total_current": 0.143, "total_act_power": 9.875, "total_aprt_power": 33.056, "a_total_act_energy": 8340171.41, "a_total_act_ret_energy": 319.18, "b_total_act_energy": 10718503.55, "b_total_act_ret_energy": 0.21, "c_total_act_energy": 8628677.6, "c_total_act_ret_energy": 18.45, "total_act": 27687352.56, "total_act_ret": 337.85}	2025-08-03 15:51:33	1	3
shellypro3em-34987a45dcd4	EnergyMeter_Kindergarden_2	Kindergarten	{"a_current": 0.421, "a_voltage": 230.8, "a_act_power": -20.3, "a_aprt_power": 97.4, "a_pf": 0.21, "a_freq": 50, "b_current": 0.445, "b_voltage": 233.4, "b_act_power": -19.7, "b_aprt_power": 104.1, "b_pf": 0.19, "b_freq": 50, "c_current": 0.438, "c_voltage": 231.5, "c_act_power": -25.1, "c_aprt_power": 101.5, "c_pf": 0.25, "c_freq": 50, "n_current": null, "total_current": 1.305, "total_act_power": -65.12, "total_aprt_power": 302.941, "a_total_act_energy": 15.54, "a_total_act_ret_energy": 824379.71, "b_total_act_energy": 671.73, "b_total_act_ret_energy": 822941.73, "c_total_act_energy": 2906.33, "c_total_act_ret_energy": 840577.08, "total_act": 3593.6, "total_act_ret": 2487898.51}	2025-08-03 15:51:33	1	3
shellytrv-8cf681d9a230	Heater_DirectorOffice	Director Office	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.2, "Battery": 84}	2025-07-27 16:00:38.741	1	2
shellytrv-588e81617272	Heater_ClassRoom4_1	Classroom 4	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 21, "Battery": 99}	2025-07-27 16:20:02.892	1	2
shellytrv-8cf681b9c924	Heater_SocialRoom	Social room	{"ValvePosition": -1, "TargetTemperature": 31, "Temperature": 22.3, "Battery": 92}	2025-08-01 11:20:38.663	1	2
shellytrv-cc86ecb3e4cd	Heater_CheckRoom	Checkroom	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 22.6, "Battery": 27}	2025-07-27 17:20:10.383	1	2
shellytrv-842e14ffcbea	Heater_ClassRoom2_3	Classroom 2	{"ValvePosition": 0, "TargetTemperature": 5, "Temperature": 23.4, "Battery": 99}	2025-07-27 17:40:06.971	1	2
70:ee:50:83:2e:54	AirQuality_ClassRoom1	Classroom 1	{"temperature": 24.8, "humidity": 55, "Pressure": 1007.5, "AbsolutePressure": 1001.9, "Noise": 32, "CO2": 426}	2025-08-01 10:56:36	1	1
70:ee:50:83:32:66	AirQuality_ClassRoom5	Classroom 5	{"temperature": 21.6, "humidity": 65, "Pressure": 1008, "AbsolutePressure": 1005.1, "Noise": 32, "CO2": 458}	2025-08-01 10:53:30	1	1
shellypro3em-08f9e0e5121c	EnergyMeter_Kindergarden_1	Kindergarten	{"a_current": 1.558, "a_voltage": 233.3, "a_act_power": 287.4, "a_aprt_power": 363.7, "a_pf": 0.79, "a_freq": 50, "b_current": 0.905, "b_voltage": 231.1, "b_act_power": 146.1, "b_aprt_power": 209.4, "b_pf": 0.7, "b_freq": 50, "c_current": 0.572, "c_voltage": 230.1, "c_act_power": 50.4, "c_aprt_power": 131.8, "c_pf": 0.38, "c_freq": 50, "n_current": null, "total_current": 3.035, "total_act_power": 483.784, "total_aprt_power": 704.934, "a_total_act_energy": 9491460.38, "a_total_act_ret_energy": 2942245.9, "b_total_act_energy": 11522235.31, "b_total_act_ret_energy": 3370131.29, "c_total_act_energy": 8807740.12, "c_total_act_ret_energy": 2959717.58, "total_act": 29821435.8, "total_act_ret": 9272094.77}	2025-08-03 15:51:32	1	3
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, username, password, building_id) FROM stdin;
1	admin	admin123!	1
\.


--
-- Name: buildings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.buildings_id_seq', 1, true);


--
-- Name: sensor_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sensor_data_id_seq', 16593, true);


--
-- Name: sensor_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sensor_types_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (id);


--
-- Name: sensor_data sensor_data_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensor_data
    ADD CONSTRAINT sensor_data_pkey PRIMARY KEY (id);


--
-- Name: sensor_types sensor_types_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensor_types
    ADD CONSTRAINT sensor_types_pkey PRIMARY KEY (id);


--
-- Name: sensors sensors_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors
    ADD CONSTRAINT sensors_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: sensor_data sensor_data_sensor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensor_data
    ADD CONSTRAINT sensor_data_sensor_id_fkey FOREIGN KEY (sensor_id) REFERENCES public.sensors(id) ON DELETE CASCADE;


--
-- Name: sensors sensors_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors
    ADD CONSTRAINT sensors_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.buildings(id);


--
-- Name: sensors sensors_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors
    ADD CONSTRAINT sensors_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.sensor_types(id);


--
-- Name: users users_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.buildings(id);


--
-- PostgreSQL database dump complete
--

