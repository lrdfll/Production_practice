--
-- PostgreSQL database dump
--

\restrict 7IxfuDFZtEhX4U1qRr6zLwBRA8zkPRx1cx76w57JTXFZDU8zWgXC15sDetJdRtZ

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-03-25 00:04:42

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
-- TOC entry 222 (class 1259 OID 16400)
-- Name: ЕдиницаИзмерения; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ЕдиницаИзмерения" (
    "id_ЕдиницыИзмерения" integer CONSTRAINT "ЕдиницаИзмере_id_ЕдиницыИзме_not_null" NOT NULL,
    "НаименованиеЕдиницыИзмерения" character varying(50) CONSTRAINT "ЕдиницаИзмере_НаименованиеЕ_not_null" NOT NULL
);


ALTER TABLE public."ЕдиницаИзмерения" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16399)
-- Name: ЕдиницаИзмерен_id_ЕдиницыИзмере_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ЕдиницаИзмерен_id_ЕдиницыИзмере_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ЕдиницаИзмерен_id_ЕдиницыИзмере_seq" OWNER TO postgres;

--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 221
-- Name: ЕдиницаИзмерен_id_ЕдиницыИзмере_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ЕдиницаИзмерен_id_ЕдиницыИзмере_seq" OWNED BY public."ЕдиницаИзмерения"."id_ЕдиницыИзмерения";


--
-- TOC entry 242 (class 1259 OID 16554)
-- Name: ЗаказыПокупателей; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ЗаказыПокупателей" (
    "id_Заказа" integer NOT NULL,
    "ДатаЗаказа" date CONSTRAINT "ЗаказыПокупателе_ДатаЗаказа_not_null" NOT NULL,
    "id_Контрагента" integer
);


ALTER TABLE public."ЗаказыПокупателей" OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16553)
-- Name: ЗаказыПокупателей_id_Заказа_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ЗаказыПокупателей_id_Заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ЗаказыПокупателей_id_Заказа_seq" OWNER TO postgres;

--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 241
-- Name: ЗаказыПокупателей_id_Заказа_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ЗаказыПокупателей_id_Заказа_seq" OWNED BY public."ЗаказыПокупателей"."id_Заказа";


--
-- TOC entry 228 (class 1259 OID 16427)
-- Name: Контрагенты; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Контрагенты" (
    "id_Контрагента" integer NOT NULL,
    "Наименование" character varying(255) NOT NULL,
    "id_ТипаКонтрагента" integer,
    "АдресДоставки" text,
    "ИНН" character varying(20),
    "Телефон" character varying(20)
);


ALTER TABLE public."Контрагенты" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16426)
-- Name: Контрагенты_id_Контрагента_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Контрагенты_id_Контрагента_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Контрагенты_id_Контрагента_seq" OWNER TO postgres;

--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 227
-- Name: Контрагенты_id_Контрагента_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Контрагенты_id_Контрагента_seq" OWNED BY public."Контрагенты"."id_Контрагента";


--
-- TOC entry 230 (class 1259 OID 16443)
-- Name: Номенклатура; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Номенклатура" (
    "id_Номенклатуры" integer NOT NULL,
    "НаименованиеТовара" character varying(255) CONSTRAINT "Номенклатура_НаименованиеТо_not_null" NOT NULL,
    "Артикул" character varying(100),
    "id_ЕдиницыИзмерения" integer,
    "id_ТипаНоменклатуры" integer
);


ALTER TABLE public."Номенклатура" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16442)
-- Name: Номенклатура_id_Номенклатуры_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Номенклатура_id_Номенклатуры_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Номенклатура_id_Номенклатуры_seq" OWNER TO postgres;

--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 229
-- Name: Номенклатура_id_Номенклатуры_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Номенклатура_id_Номенклатуры_seq" OWNED BY public."Номенклатура"."id_Номенклатуры";


--
-- TOC entry 246 (class 1259 OID 16633)
-- Name: Пользователи; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Пользователи" (
    "id_Пользователя" integer NOT NULL,
    "Логин" character varying(50) NOT NULL,
    "Пароль" character varying(255) NOT NULL,
    "Роль" character varying(20) NOT NULL,
    "Заблокирован" boolean DEFAULT false NOT NULL,
    "КоличествоНеудачныхПопыток" integer DEFAULT 0 CONSTRAINT "Пользователи_КоличествоНеуд_not_null" NOT NULL,
    "ДатаБлокировки" timestamp with time zone,
    "id_Контрагента" integer,
    "ФИО" character varying(150),
    "ДатаСоздания" timestamp with time zone DEFAULT now() NOT NULL,
    "ДатаПоследнегоВхода" timestamp with time zone,
    CONSTRAINT "Пользователи_Роль_check" CHECK ((("Роль")::text = ANY ((ARRAY['Администратор'::character varying, 'Пользователь'::character varying])::text[])))
);


ALTER TABLE public."Пользователи" OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16632)
-- Name: Пользователи_id_Пользователя_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Пользователи_id_Пользователя_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Пользователи_id_Пользователя_seq" OWNER TO postgres;

--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 245
-- Name: Пользователи_id_Пользователя_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Пользователи_id_Пользователя_seq" OWNED BY public."Пользователи"."id_Пользователя";


--
-- TOC entry 238 (class 1259 OID 16520)
-- Name: ПроизводственныеПартии; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ПроизводственныеПартии" (
    "id_Партии" integer CONSTRAINT "ПроизводственныеПар_id_Партии_not_null" NOT NULL,
    "ДатаПроизводства" date CONSTRAINT "Производствен_ДатаПроизводс_not_null" NOT NULL,
    "id_Спецификации" integer,
    "ОбъемВыпуска" numeric(15,3) CONSTRAINT "Производственн_ОбъемВыпуска_not_null" NOT NULL
);


ALTER TABLE public."ПроизводственныеПартии" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16519)
-- Name: ПроизводственныеПарти_id_Партии_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ПроизводственныеПарти_id_Партии_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ПроизводственныеПарти_id_Партии_seq" OWNER TO postgres;

--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 237
-- Name: ПроизводственныеПарти_id_Партии_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ПроизводственныеПарти_id_Партии_seq" OWNED BY public."ПроизводственныеПартии"."id_Партии";


--
-- TOC entry 240 (class 1259 OID 16535)
-- Name: РасходМатериала; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."РасходМатериала" (
    "id_Расхода" integer NOT NULL,
    "id_ПартииПроизводства" integer,
    "id_Номенклатуры" integer,
    "КоличествоСписано" numeric(15,3) CONSTRAINT "РасходМатериа_КоличествоСпи_not_null" NOT NULL
);


ALTER TABLE public."РасходМатериала" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16534)
-- Name: РасходМатериала_id_Расхода_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."РасходМатериала_id_Расхода_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."РасходМатериала_id_Расхода_seq" OWNER TO postgres;

--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 239
-- Name: РасходМатериала_id_Расхода_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."РасходМатериала_id_Расхода_seq" OWNED BY public."РасходМатериала"."id_Расхода";


--
-- TOC entry 244 (class 1259 OID 16568)
-- Name: СоставЗаказа; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."СоставЗаказа" (
    "id_СтрокиЗаказа" integer NOT NULL,
    "id_Заказа" integer,
    "id_Номенклатуры" integer,
    "Количество" numeric(15,3) NOT NULL,
    "Цена" numeric(15,2) NOT NULL
);


ALTER TABLE public."СоставЗаказа" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16567)
-- Name: СоставЗаказа_id_СтрокиЗаказа_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."СоставЗаказа_id_СтрокиЗаказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."СоставЗаказа_id_СтрокиЗаказа_seq" OWNER TO postgres;

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 243
-- Name: СоставЗаказа_id_СтрокиЗаказа_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."СоставЗаказа_id_СтрокиЗаказа_seq" OWNED BY public."СоставЗаказа"."id_СтрокиЗаказа";


--
-- TOC entry 236 (class 1259 OID 16501)
-- Name: СоставСпецификации; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."СоставСпецификации" (
    "id_СоставаСпецификации" integer CONSTRAINT "СоставСпецифи_id_СоставаСпец_not_null" NOT NULL,
    "id_Спецификации" integer,
    "id_Номенклатуры" integer,
    "Количество" numeric(15,3) CONSTRAINT "СоставСпецификац_Количество_not_null" NOT NULL
);


ALTER TABLE public."СоставСпецификации" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16500)
-- Name: СоставСпецифик_id_СоставаСпециф_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."СоставСпецифик_id_СоставаСпециф_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."СоставСпецифик_id_СоставаСпециф_seq" OWNER TO postgres;

--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 235
-- Name: СоставСпецифик_id_СоставаСпециф_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."СоставСпецифик_id_СоставаСпециф_seq" OWNED BY public."СоставСпецификации"."id_СоставаСпецификации";


--
-- TOC entry 234 (class 1259 OID 16482)
-- Name: Спецификация; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Спецификация" (
    "id_Спецификации" integer NOT NULL,
    "ДатаУтверждения" date CONSTRAINT "Спецификация_ДатаУтверждени_not_null" NOT NULL,
    "id_Продукции" integer,
    "id_Изготовителя" integer
);


ALTER TABLE public."Спецификация" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16481)
-- Name: Спецификация_id_Спецификации_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Спецификация_id_Спецификации_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Спецификация_id_Спецификации_seq" OWNER TO postgres;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 233
-- Name: Спецификация_id_Спецификации_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Спецификация_id_Спецификации_seq" OWNED BY public."Спецификация"."id_Спецификации";


--
-- TOC entry 226 (class 1259 OID 16418)
-- Name: ТипКонтрагента; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ТипКонтрагента" (
    "id_ТипаКонтрагента" integer CONSTRAINT "ТипКонтрагент_id_ТипаКонтраг_not_null" NOT NULL,
    "НаименованиеТипаКонтрагента" character varying(100) CONSTRAINT "ТипКонтрагент_НаименованиеТ_not_null" NOT NULL
);


ALTER TABLE public."ТипКонтрагента" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16417)
-- Name: ТипКонтрагента_id_ТипаКонтраген_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ТипКонтрагента_id_ТипаКонтраген_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ТипКонтрагента_id_ТипаКонтраген_seq" OWNER TO postgres;

--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 225
-- Name: ТипКонтрагента_id_ТипаКонтраген_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ТипКонтрагента_id_ТипаКонтраген_seq" OWNED BY public."ТипКонтрагента"."id_ТипаКонтрагента";


--
-- TOC entry 224 (class 1259 OID 16409)
-- Name: ТипНоменклатуры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ТипНоменклатуры" (
    "id_ТипаНоменклатуры" integer CONSTRAINT "ТипНоменклату_id_ТипаНоменкл_not_null" NOT NULL,
    "НаименованиеТипаНоменклатуры" character varying(100) CONSTRAINT "ТипНоменклату_НаименованиеТ_not_null" NOT NULL
);


ALTER TABLE public."ТипНоменклатуры" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16408)
-- Name: ТипНоменклатур_id_ТипаНоменклат_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ТипНоменклатур_id_ТипаНоменклат_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ТипНоменклатур_id_ТипаНоменклат_seq" OWNER TO postgres;

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 223
-- Name: ТипНоменклатур_id_ТипаНоменклат_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ТипНоменклатур_id_ТипаНоменклат_seq" OWNED BY public."ТипНоменклатуры"."id_ТипаНоменклатуры";


--
-- TOC entry 220 (class 1259 OID 16391)
-- Name: ТипЦены; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ТипЦены" (
    "id_ТипаЦены" integer NOT NULL,
    "НаименованиеТипаЦены" character varying(255) CONSTRAINT "ТипЦены_НаименованиеТипаЦен_not_null" NOT NULL
);


ALTER TABLE public."ТипЦены" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16390)
-- Name: ТипЦены_id_ТипаЦены_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ТипЦены_id_ТипаЦены_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ТипЦены_id_ТипаЦены_seq" OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 219
-- Name: ТипЦены_id_ТипаЦены_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ТипЦены_id_ТипаЦены_seq" OWNED BY public."ТипЦены"."id_ТипаЦены";


--
-- TOC entry 232 (class 1259 OID 16462)
-- Name: Цены; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Цены" (
    "id_Цены" integer NOT NULL,
    "id_Номенклатуры" integer,
    "Цена" numeric(15,2) NOT NULL,
    "ДатаУстановки" date NOT NULL,
    "id_ТипаЦены" integer
);


ALTER TABLE public."Цены" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16461)
-- Name: Цены_id_Цены_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Цены_id_Цены_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Цены_id_Цены_seq" OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 231
-- Name: Цены_id_Цены_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Цены_id_Цены_seq" OWNED BY public."Цены"."id_Цены";


--
-- TOC entry 4875 (class 2604 OID 16403)
-- Name: ЕдиницаИзмерения id_ЕдиницыИзмерения; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ЕдиницаИзмерения" ALTER COLUMN "id_ЕдиницыИзмерения" SET DEFAULT nextval('public."ЕдиницаИзмерен_id_ЕдиницыИзмере_seq"'::regclass);


--
-- TOC entry 4885 (class 2604 OID 16557)
-- Name: ЗаказыПокупателей id_Заказа; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ЗаказыПокупателей" ALTER COLUMN "id_Заказа" SET DEFAULT nextval('public."ЗаказыПокупателей_id_Заказа_seq"'::regclass);


--
-- TOC entry 4878 (class 2604 OID 16430)
-- Name: Контрагенты id_Контрагента; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Контрагенты" ALTER COLUMN "id_Контрагента" SET DEFAULT nextval('public."Контрагенты_id_Контрагента_seq"'::regclass);


--
-- TOC entry 4879 (class 2604 OID 16446)
-- Name: Номенклатура id_Номенклатуры; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Номенклатура" ALTER COLUMN "id_Номенклатуры" SET DEFAULT nextval('public."Номенклатура_id_Номенклатуры_seq"'::regclass);


--
-- TOC entry 4887 (class 2604 OID 16636)
-- Name: Пользователи id_Пользователя; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Пользователи" ALTER COLUMN "id_Пользователя" SET DEFAULT nextval('public."Пользователи_id_Пользователя_seq"'::regclass);


--
-- TOC entry 4883 (class 2604 OID 16523)
-- Name: ПроизводственныеПартии id_Партии; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ПроизводственныеПартии" ALTER COLUMN "id_Партии" SET DEFAULT nextval('public."ПроизводственныеПарти_id_Партии_seq"'::regclass);


--
-- TOC entry 4884 (class 2604 OID 16538)
-- Name: РасходМатериала id_Расхода; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."РасходМатериала" ALTER COLUMN "id_Расхода" SET DEFAULT nextval('public."РасходМатериала_id_Расхода_seq"'::regclass);


--
-- TOC entry 4886 (class 2604 OID 16571)
-- Name: СоставЗаказа id_СтрокиЗаказа; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставЗаказа" ALTER COLUMN "id_СтрокиЗаказа" SET DEFAULT nextval('public."СоставЗаказа_id_СтрокиЗаказа_seq"'::regclass);


--
-- TOC entry 4882 (class 2604 OID 16504)
-- Name: СоставСпецификации id_СоставаСпецификации; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставСпецификации" ALTER COLUMN "id_СоставаСпецификации" SET DEFAULT nextval('public."СоставСпецифик_id_СоставаСпециф_seq"'::regclass);


--
-- TOC entry 4881 (class 2604 OID 16485)
-- Name: Спецификация id_Спецификации; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Спецификация" ALTER COLUMN "id_Спецификации" SET DEFAULT nextval('public."Спецификация_id_Спецификации_seq"'::regclass);


--
-- TOC entry 4877 (class 2604 OID 16421)
-- Name: ТипКонтрагента id_ТипаКонтрагента; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ТипКонтрагента" ALTER COLUMN "id_ТипаКонтрагента" SET DEFAULT nextval('public."ТипКонтрагента_id_ТипаКонтраген_seq"'::regclass);


--
-- TOC entry 4876 (class 2604 OID 16412)
-- Name: ТипНоменклатуры id_ТипаНоменклатуры; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ТипНоменклатуры" ALTER COLUMN "id_ТипаНоменклатуры" SET DEFAULT nextval('public."ТипНоменклатур_id_ТипаНоменклат_seq"'::regclass);


--
-- TOC entry 4874 (class 2604 OID 16394)
-- Name: ТипЦены id_ТипаЦены; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ТипЦены" ALTER COLUMN "id_ТипаЦены" SET DEFAULT nextval('public."ТипЦены_id_ТипаЦены_seq"'::regclass);


--
-- TOC entry 4880 (class 2604 OID 16465)
-- Name: Цены id_Цены; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Цены" ALTER COLUMN "id_Цены" SET DEFAULT nextval('public."Цены_id_Цены_seq"'::regclass);


--
-- TOC entry 5090 (class 0 OID 16400)
-- Dependencies: 222
-- Data for Name: ЕдиницаИзмерения; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ЕдиницаИзмерения" ("id_ЕдиницыИзмерения", "НаименованиеЕдиницыИзмерения") FROM stdin;
1	шт
2	кг
\.


--
-- TOC entry 5110 (class 0 OID 16554)
-- Dependencies: 242
-- Data for Name: ЗаказыПокупателей; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ЗаказыПокупателей" ("id_Заказа", "ДатаЗаказа", "id_Контрагента") FROM stdin;
1	2023-03-17	4
\.


--
-- TOC entry 5096 (class 0 OID 16427)
-- Dependencies: 228
-- Data for Name: Контрагенты; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Контрагенты" ("id_Контрагента", "Наименование", "id_ТипаКонтрагента", "АдресДоставки", "ИНН", "Телефон") FROM stdin;
1	ООО "Поставка"	3	г.Пятигорск		+79198634592
2	ООО "Кинотеатр Квант"	1	г. Железноводск, ул. Мира, 123	26320045123	+79884581555
3	ООО "Новый JDTO"	1	г. Железноводсу	26320045111	+79884581555
4	ООО "Ромашка"	2	г. Омск, ул. Строителей, 294	4140784214	+79882584546
5	ООО "Ипподром"	3	г. Уфа, ул. Набережная,  37	5874045632	+79627486389
6	ООО "Ассоль"	2	г. Калуга, ул. Пушкина, 94	2629011278	+79184572398
\.


--
-- TOC entry 5098 (class 0 OID 16443)
-- Dependencies: 230
-- Data for Name: Номенклатура; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Номенклатура" ("id_Номенклатуры", "НаименованиеТовара", "Артикул", "id_ЕдиницыИзмерения", "id_ТипаНоменклатуры") FROM stdin;
1	Стул офисный	\N	\N	1
2	Дерево	\N	\N	2
3	Ткань	\N	\N	2
\.


--
-- TOC entry 5114 (class 0 OID 16633)
-- Dependencies: 246
-- Data for Name: Пользователи; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Пользователи" ("id_Пользователя", "Логин", "Пароль", "Роль", "Заблокирован", "КоличествоНеудачныхПопыток", "ДатаБлокировки", "id_Контрагента", "ФИО", "ДатаСоздания", "ДатаПоследнегоВхода") FROM stdin;
1	admin	1234	Администратор	f	0	\N	\N	\N	2026-03-25 00:04:27.175179+03	\N
2	user	1111	Пользователь	f	0	\N	\N	\N	2026-03-25 00:04:27.175179+03	\N
\.


--
-- TOC entry 5106 (class 0 OID 16520)
-- Dependencies: 238
-- Data for Name: ПроизводственныеПартии; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ПроизводственныеПартии" ("id_Партии", "ДатаПроизводства", "id_Спецификации", "ОбъемВыпуска") FROM stdin;
\.


--
-- TOC entry 5108 (class 0 OID 16535)
-- Dependencies: 240
-- Data for Name: РасходМатериала; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."РасходМатериала" ("id_Расхода", "id_ПартииПроизводства", "id_Номенклатуры", "КоличествоСписано") FROM stdin;
\.


--
-- TOC entry 5112 (class 0 OID 16568)
-- Dependencies: 244
-- Data for Name: СоставЗаказа; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."СоставЗаказа" ("id_СтрокиЗаказа", "id_Заказа", "id_Номенклатуры", "Количество", "Цена") FROM stdin;
1	1	1	10.000	3500.00
\.


--
-- TOC entry 5104 (class 0 OID 16501)
-- Dependencies: 236
-- Data for Name: СоставСпецификации; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."СоставСпецификации" ("id_СоставаСпецификации", "id_Спецификации", "id_Номенклатуры", "Количество") FROM stdin;
1	1	2	2.500
2	1	3	1.200
\.


--
-- TOC entry 5102 (class 0 OID 16482)
-- Dependencies: 234
-- Data for Name: Спецификация; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Спецификация" ("id_Спецификации", "ДатаУтверждения", "id_Продукции", "id_Изготовителя") FROM stdin;
1	2023-01-01	1	\N
\.


--
-- TOC entry 5094 (class 0 OID 16418)
-- Dependencies: 226
-- Data for Name: ТипКонтрагента; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ТипКонтрагента" ("id_ТипаКонтрагента", "НаименованиеТипаКонтрагента") FROM stdin;
1	Поставщик
2	Заказчик
3	Оба
\.


--
-- TOC entry 5092 (class 0 OID 16409)
-- Dependencies: 224
-- Data for Name: ТипНоменклатуры; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ТипНоменклатуры" ("id_ТипаНоменклатуры", "НаименованиеТипаНоменклатуры") FROM stdin;
1	Товар
2	Материал
\.


--
-- TOC entry 5088 (class 0 OID 16391)
-- Dependencies: 220
-- Data for Name: ТипЦены; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ТипЦены" ("id_ТипаЦены", "НаименованиеТипаЦены") FROM stdin;
1	Закупочная
2	Розничная
\.


--
-- TOC entry 5100 (class 0 OID 16462)
-- Dependencies: 232
-- Data for Name: Цены; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Цены" ("id_Цены", "id_Номенклатуры", "Цена", "ДатаУстановки", "id_ТипаЦены") FROM stdin;
1	2	500.00	2023-01-01	1
2	3	200.00	2023-01-01	1
\.


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 221
-- Name: ЕдиницаИзмерен_id_ЕдиницыИзмере_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ЕдиницаИзмерен_id_ЕдиницыИзмере_seq"', 2, true);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 241
-- Name: ЗаказыПокупателей_id_Заказа_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ЗаказыПокупателей_id_Заказа_seq"', 1, true);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 227
-- Name: Контрагенты_id_Контрагента_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Контрагенты_id_Контрагента_seq"', 6, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 229
-- Name: Номенклатура_id_Номенклатуры_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Номенклатура_id_Номенклатуры_seq"', 3, true);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 245
-- Name: Пользователи_id_Пользователя_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Пользователи_id_Пользователя_seq"', 2, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 237
-- Name: ПроизводственныеПарти_id_Партии_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ПроизводственныеПарти_id_Партии_seq"', 1, false);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 239
-- Name: РасходМатериала_id_Расхода_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."РасходМатериала_id_Расхода_seq"', 1, false);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 243
-- Name: СоставЗаказа_id_СтрокиЗаказа_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СоставЗаказа_id_СтрокиЗаказа_seq"', 1, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 235
-- Name: СоставСпецифик_id_СоставаСпециф_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СоставСпецифик_id_СоставаСпециф_seq"', 2, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 233
-- Name: Спецификация_id_Спецификации_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Спецификация_id_Спецификации_seq"', 1, true);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 225
-- Name: ТипКонтрагента_id_ТипаКонтраген_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ТипКонтрагента_id_ТипаКонтраген_seq"', 1, false);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 223
-- Name: ТипНоменклатур_id_ТипаНоменклат_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ТипНоменклатур_id_ТипаНоменклат_seq"', 2, true);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 219
-- Name: ТипЦены_id_ТипаЦены_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ТипЦены_id_ТипаЦены_seq"', 2, true);


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 231
-- Name: Цены_id_Цены_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Цены_id_Цены_seq"', 2, true);


--
-- TOC entry 4895 (class 2606 OID 16407)
-- Name: ЕдиницаИзмерения ЕдиницаИзмерения_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ЕдиницаИзмерения"
    ADD CONSTRAINT "ЕдиницаИзмерения_pkey" PRIMARY KEY ("id_ЕдиницыИзмерения");


--
-- TOC entry 4915 (class 2606 OID 16561)
-- Name: ЗаказыПокупателей ЗаказыПокупателей_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ЗаказыПокупателей"
    ADD CONSTRAINT "ЗаказыПокупателей_pkey" PRIMARY KEY ("id_Заказа");


--
-- TOC entry 4901 (class 2606 OID 16436)
-- Name: Контрагенты Контрагенты_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Контрагенты"
    ADD CONSTRAINT "Контрагенты_pkey" PRIMARY KEY ("id_Контрагента");


--
-- TOC entry 4903 (class 2606 OID 16450)
-- Name: Номенклатура Номенклатура_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Номенклатура"
    ADD CONSTRAINT "Номенклатура_pkey" PRIMARY KEY ("id_Номенклатуры");


--
-- TOC entry 4921 (class 2606 OID 16649)
-- Name: Пользователи Пользователи_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Пользователи"
    ADD CONSTRAINT "Пользователи_pkey" PRIMARY KEY ("id_Пользователя");


--
-- TOC entry 4923 (class 2606 OID 16651)
-- Name: Пользователи Пользователи_Логин_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Пользователи"
    ADD CONSTRAINT "Пользователи_Логин_key" UNIQUE ("Логин");


--
-- TOC entry 4911 (class 2606 OID 16528)
-- Name: ПроизводственныеПартии ПроизводственныеПартии_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ПроизводственныеПартии"
    ADD CONSTRAINT "ПроизводственныеПартии_pkey" PRIMARY KEY ("id_Партии");


--
-- TOC entry 4913 (class 2606 OID 16542)
-- Name: РасходМатериала РасходМатериала_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."РасходМатериала"
    ADD CONSTRAINT "РасходМатериала_pkey" PRIMARY KEY ("id_Расхода");


--
-- TOC entry 4917 (class 2606 OID 16576)
-- Name: СоставЗаказа СоставЗаказа_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставЗаказа"
    ADD CONSTRAINT "СоставЗаказа_pkey" PRIMARY KEY ("id_СтрокиЗаказа");


--
-- TOC entry 4909 (class 2606 OID 16508)
-- Name: СоставСпецификации СоставСпецификации_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставСпецификации"
    ADD CONSTRAINT "СоставСпецификации_pkey" PRIMARY KEY ("id_СоставаСпецификации");


--
-- TOC entry 4907 (class 2606 OID 16489)
-- Name: Спецификация Спецификация_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Спецификация"
    ADD CONSTRAINT "Спецификация_pkey" PRIMARY KEY ("id_Спецификации");


--
-- TOC entry 4899 (class 2606 OID 16425)
-- Name: ТипКонтрагента ТипКонтрагента_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ТипКонтрагента"
    ADD CONSTRAINT "ТипКонтрагента_pkey" PRIMARY KEY ("id_ТипаКонтрагента");


--
-- TOC entry 4897 (class 2606 OID 16416)
-- Name: ТипНоменклатуры ТипНоменклатуры_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ТипНоменклатуры"
    ADD CONSTRAINT "ТипНоменклатуры_pkey" PRIMARY KEY ("id_ТипаНоменклатуры");


--
-- TOC entry 4893 (class 2606 OID 16398)
-- Name: ТипЦены ТипЦены_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ТипЦены"
    ADD CONSTRAINT "ТипЦены_pkey" PRIMARY KEY ("id_ТипаЦены");


--
-- TOC entry 4905 (class 2606 OID 16470)
-- Name: Цены Цены_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Цены"
    ADD CONSTRAINT "Цены_pkey" PRIMARY KEY ("id_Цены");


--
-- TOC entry 4918 (class 1259 OID 16658)
-- Name: idx_Пользователи_Заблокирован; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_Пользователи_Заблокирован" ON public."Пользователи" USING btree ("Заблокирован");


--
-- TOC entry 4919 (class 1259 OID 16657)
-- Name: idx_Пользователи_Роль; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "idx_Пользователи_Роль" ON public."Пользователи" USING btree ("Роль");


--
-- TOC entry 4939 (class 2606 OID 16652)
-- Name: Пользователи fk_Пользователи_Контрагенты; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Пользователи"
    ADD CONSTRAINT "fk_Пользователи_Контрагенты" FOREIGN KEY ("id_Контрагента") REFERENCES public."Контрагенты"("id_Контрагента") ON DELETE SET NULL;


--
-- TOC entry 4936 (class 2606 OID 16562)
-- Name: ЗаказыПокупателей ЗаказыПокупателе_id_Контрагента_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ЗаказыПокупателей"
    ADD CONSTRAINT "ЗаказыПокупателе_id_Контрагента_fkey" FOREIGN KEY ("id_Контрагента") REFERENCES public."Контрагенты"("id_Контрагента");


--
-- TOC entry 4924 (class 2606 OID 16437)
-- Name: Контрагенты Контрагенты_id_ТипаКонтрагента_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Контрагенты"
    ADD CONSTRAINT "Контрагенты_id_ТипаКонтрагента_fkey" FOREIGN KEY ("id_ТипаКонтрагента") REFERENCES public."ТипКонтрагента"("id_ТипаКонтрагента");


--
-- TOC entry 4925 (class 2606 OID 16451)
-- Name: Номенклатура Номенклатура_id_ЕдиницыИзмерени_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Номенклатура"
    ADD CONSTRAINT "Номенклатура_id_ЕдиницыИзмерени_fkey" FOREIGN KEY ("id_ЕдиницыИзмерения") REFERENCES public."ЕдиницаИзмерения"("id_ЕдиницыИзмерения");


--
-- TOC entry 4926 (class 2606 OID 16456)
-- Name: Номенклатура Номенклатура_id_ТипаНоменклатур_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Номенклатура"
    ADD CONSTRAINT "Номенклатура_id_ТипаНоменклатур_fkey" FOREIGN KEY ("id_ТипаНоменклатуры") REFERENCES public."ТипНоменклатуры"("id_ТипаНоменклатуры");


--
-- TOC entry 4933 (class 2606 OID 16529)
-- Name: ПроизводственныеПартии Производственны_id_Спецификации_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ПроизводственныеПартии"
    ADD CONSTRAINT "Производственны_id_Спецификации_fkey" FOREIGN KEY ("id_Спецификации") REFERENCES public."Спецификация"("id_Спецификации");


--
-- TOC entry 4934 (class 2606 OID 16543)
-- Name: РасходМатериала РасходМатериал_id_ПартииПроизв_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."РасходМатериала"
    ADD CONSTRAINT "РасходМатериал_id_ПартииПроизв_fkey" FOREIGN KEY ("id_ПартииПроизводства") REFERENCES public."ПроизводственныеПартии"("id_Партии");


--
-- TOC entry 4935 (class 2606 OID 16548)
-- Name: РасходМатериала РасходМатериала_id_Номенклатуры_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."РасходМатериала"
    ADD CONSTRAINT "РасходМатериала_id_Номенклатуры_fkey" FOREIGN KEY ("id_Номенклатуры") REFERENCES public."Номенклатура"("id_Номенклатуры");


--
-- TOC entry 4937 (class 2606 OID 16577)
-- Name: СоставЗаказа СоставЗаказа_id_Заказа_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставЗаказа"
    ADD CONSTRAINT "СоставЗаказа_id_Заказа_fkey" FOREIGN KEY ("id_Заказа") REFERENCES public."ЗаказыПокупателей"("id_Заказа") ON DELETE CASCADE;


--
-- TOC entry 4938 (class 2606 OID 16582)
-- Name: СоставЗаказа СоставЗаказа_id_Номенклатуры_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставЗаказа"
    ADD CONSTRAINT "СоставЗаказа_id_Номенклатуры_fkey" FOREIGN KEY ("id_Номенклатуры") REFERENCES public."Номенклатура"("id_Номенклатуры");


--
-- TOC entry 4931 (class 2606 OID 16514)
-- Name: СоставСпецификации СоставСпецифика_id_Номенклатуры_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставСпецификации"
    ADD CONSTRAINT "СоставСпецифика_id_Номенклатуры_fkey" FOREIGN KEY ("id_Номенклатуры") REFERENCES public."Номенклатура"("id_Номенклатуры");


--
-- TOC entry 4932 (class 2606 OID 16509)
-- Name: СоставСпецификации СоставСпецифика_id_Спецификации_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."СоставСпецификации"
    ADD CONSTRAINT "СоставСпецифика_id_Спецификации_fkey" FOREIGN KEY ("id_Спецификации") REFERENCES public."Спецификация"("id_Спецификации") ON DELETE CASCADE;


--
-- TOC entry 4929 (class 2606 OID 16495)
-- Name: Спецификация Спецификация_id_Изготовителя_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Спецификация"
    ADD CONSTRAINT "Спецификация_id_Изготовителя_fkey" FOREIGN KEY ("id_Изготовителя") REFERENCES public."Контрагенты"("id_Контрагента");


--
-- TOC entry 4930 (class 2606 OID 16490)
-- Name: Спецификация Спецификация_id_Продукции_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Спецификация"
    ADD CONSTRAINT "Спецификация_id_Продукции_fkey" FOREIGN KEY ("id_Продукции") REFERENCES public."Номенклатура"("id_Номенклатуры");


--
-- TOC entry 4927 (class 2606 OID 16471)
-- Name: Цены Цены_id_Номенклатуры_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Цены"
    ADD CONSTRAINT "Цены_id_Номенклатуры_fkey" FOREIGN KEY ("id_Номенклатуры") REFERENCES public."Номенклатура"("id_Номенклатуры");


--
-- TOC entry 4928 (class 2606 OID 16476)
-- Name: Цены Цены_id_ТипаЦены_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Цены"
    ADD CONSTRAINT "Цены_id_ТипаЦены_fkey" FOREIGN KEY ("id_ТипаЦены") REFERENCES public."ТипЦены"("id_ТипаЦены");


-- Completed on 2026-03-25 00:04:42

--
-- PostgreSQL database dump complete
--

\unrestrict 7IxfuDFZtEhX4U1qRr6zLwBRA8zkPRx1cx76w57JTXFZDU8zWgXC15sDetJdRtZ

