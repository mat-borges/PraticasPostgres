CREATE DATABASE rental_company;

\c rental_company;

CREATE TABLE customers (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" varchar(50) NOT NULL,
	"cpf" varchar(11) NOT NULL UNIQUE,
	"email" TEXT NOT NULL UNIQUE,
	"created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
	"address_id" INTEGER NOT NULL,
	"phone_id" INTEGER NOT NULL
);

CREATE TABLE rentals (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"customer_id" INTEGER NOT NULL,
	"rental_date" DATE NOT NULL,
	"original_price" INTEGER NOT NULL,
	"return_date" DATE DEFAULT null,
	"days_late" INTEGER NOT NULL
);

CREATE TABLE movies (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"barcode" TEXT NOT NULL UNIQUE,
	"price_per_day" INTEGER NOT NULL,
	"total_stock" INTEGER NOT NULL,
	"category_id" INTEGER NOT NULL
);

CREATE TABLE categories (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL UNIQUE
);

CREATE TABLE actors (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" varchar(50) NOT NULL,
	"country_id" INTEGER NOT NULL,
	"birthdate" DATE NOT NULL
);

CREATE TABLE movies_actors (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"movie_id" INTEGER NOT NULL,
	"actor_id" INTEGER NOT NULL
);

CREATE TABLE countries (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL
);

CREATE TYPE phone_type AS ENUM ('mobile','landline');

CREATE TABLE phone_numbers (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"number" INTEGER NOT NULL,
	"type" phone_type NOT NULL
);

CREATE TABLE adresses (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"street_name" TEXT NOT NULL,
	"number" TEXT NOT NULL,
	"complement" TEXT NOT NULL,
	"district_id" INTEGER NOT NULL,
	"postal_code" INTEGER NOT NULL
);

CREATE TABLE districts (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"city_id" INTEGER NOT NULL
);

CREATE TABLE cities (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"state_id" INTEGER NOT NULL
);

CREATE TABLE states (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"name" TEXT NOT NULL,
	"country_id" INTEGER NOT NULL
);

CREATE TABLE rental_items (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"movie_id" INTEGER NOT NULL,
	"rental_id" INTEGER NOT NULL
);

CREATE TABLE rental_survey (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"rental_id" SERIAL NOT NULL,
	"rating" INTEGER NOT NULL CHECK (rating>=0 AND rating<=10)
);

CREATE TABLE movie_survey (
	"id" SERIAL PRIMARY KEY NOT NULL,
	"rental_item_id" INTEGER NOT NULL,
	"rating" INTEGER NOT NULL CHECK (rating>=0 AND rating<=10)
);

ALTER TABLE "customers" ADD CONSTRAINT "customers_fk0" FOREIGN KEY ("address_id") REFERENCES "adresses"("id");
ALTER TABLE "customers" ADD CONSTRAINT "customers_fk1" FOREIGN KEY ("phone_id") REFERENCES "phone_numbers"("id");

ALTER TABLE "rentals" ADD CONSTRAINT "rentals_fk0" FOREIGN KEY ("customer_id") REFERENCES "customers"("id");

ALTER TABLE "movies" ADD CONSTRAINT "movies_fk0" FOREIGN KEY ("category_id") REFERENCES "categories"("id");

ALTER TABLE "actors" ADD CONSTRAINT "actors_fk0" FOREIGN KEY ("country_id") REFERENCES "countries"("id");

ALTER TABLE "movies_actors" ADD CONSTRAINT "movies_actors_fk0" FOREIGN KEY ("movie_id") REFERENCES "movies"("id");
ALTER TABLE "movies_actors" ADD CONSTRAINT "movies_actors_fk1" FOREIGN KEY ("actor_id") REFERENCES "actors"("id");

ALTER TABLE "adresses" ADD CONSTRAINT "adresses_fk0" FOREIGN KEY ("district_id") REFERENCES "districts"("id");

ALTER TABLE "districts" ADD CONSTRAINT "districts_fk0" FOREIGN KEY ("city_id") REFERENCES "cities"("id");

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("state_id") REFERENCES "states"("id");

ALTER TABLE "states" ADD CONSTRAINT "states_fk0" FOREIGN KEY ("country_id") REFERENCES "countries"("id");

ALTER TABLE "rental_items" ADD CONSTRAINT "rental_items_fk0" FOREIGN KEY ("movie_id") REFERENCES "movies"("id");
ALTER TABLE "rental_items" ADD CONSTRAINT "rental_items_fk1" FOREIGN KEY ("rental_id") REFERENCES "rentals"("id");

ALTER TABLE "rental_survey" ADD CONSTRAINT "rental_survey_fk0" FOREIGN KEY ("rental_id") REFERENCES "rentals"("id");

ALTER TABLE "movie_survey" ADD CONSTRAINT "movie_survey_fk0" FOREIGN KEY ("rental_item_id") REFERENCES "rental_items"("id");