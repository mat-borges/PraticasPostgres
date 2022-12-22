CREATE TABLE flights (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"code" varchar(7) NOT NULL,
	"company_id" INTEGER NOT NULL,
	"origin_id" INTEGER NOT NULL,
	"departure" timestamp with time zone NOT NULL,
	"destination" INTEGER NOT NULL,
	"arrival_id" timestamp with time zone NOT NULL,
	"seats" INTEGER NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE companies (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"abbreviation" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE airports (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"city_id" INTEGER NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE cities (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"state_id" INTEGER NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE states (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"country_id" INTEGER NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE countries (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE customer (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" varchar(50) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"cpf" varchar(11) NOT NULL UNIQUE
) WITH (
  OIDS=FALSE
);

CREATE TABLE orders (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"customer_id" INTEGER NOT NULL,
	"flight_id" INTEGER NOT NULL
) WITH (
  OIDS=FALSE
);



ALTER TABLE "flights" ADD CONSTRAINT "flights_fk0" FOREIGN KEY ("company_id") REFERENCES "companies"("id");
ALTER TABLE "flights" ADD CONSTRAINT "flights_fk1" FOREIGN KEY ("origin_id") REFERENCES "airports"("id");
ALTER TABLE "flights" ADD CONSTRAINT "flights_fk2" FOREIGN KEY ("destination") REFERENCES "airports"("id");

ALTER TABLE "airports" ADD CONSTRAINT "airports_fk0" FOREIGN KEY ("city_id") REFERENCES "cities"("id");

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("state_id") REFERENCES "states"("id");

ALTER TABLE "states" ADD CONSTRAINT "states_fk0" FOREIGN KEY ("country_id") REFERENCES "countries"("id");

ALTER TABLE "orders" ADD CONSTRAINT "orders_fk0" FOREIGN KEY ("customer_id") REFERENCES "customer"("id");
ALTER TABLE "orders" ADD CONSTRAINT "orders_fk1" FOREIGN KEY ("flight_id") REFERENCES "flights"("id");








