CREATE TYPE phone_type AS ENUM('landline','mobile');
CREATE TYPE transaction_type AS ENUM('deposit','withdraw');

CREATE TABLE states (
	id AS SERIAL PRIMARY KEY NOT NULL,
	"name" AS TEXT NOT NULL
);

CREATE TABLE cities (
	id AS SERIAL PRIMARY KEY NOT NULL,
	"name" AS TEXT NOT NULL,
	state_id AS INTEGER
)

CREATE TABLE customers(
	id AS SERIAL PRIMARY KEY NOT NULL,
	full_name AS TEXT NOT NULL,
	cpf AS VARCHAR(11) UNIQUE NOT NULL,
	email AS TEXT UNIQUE NOT NULL,
	"password" AS TEXT NOT NULL
);

CREATE TABLE customer_adresses(
	id AS SERIAL PRIMARY KEY NOT NULL,
	customer_id AS INTEGER NOT NULL,
	street AS TEXT NOT NULL,
	"number" AS TEXT NOT NULL,
	complement AS TEXT NOT NULL,
	postal_code AS INTEGER NOT NULL,
	city_id AS INTEGER NOT NULL
);



CREATE TABLE customer_phones(
	id AS SERIAL PRIMARY KEY NOT NULL,
	customer_id AS INTEGER NOT NULL,
	"number" AS INTEGER NOT NULL,
	"type" AS phone_type NOT NULL
);



CREATE TABLE bank_accounts(
	id AS SERIAL PRIMARY KEY NOT NULL,
	customer_id AS INTEGER NOT NULL,
	account_number AS INTEGER NOT NULL,
	agency AS INTEGER NOT NULL,
	open_date AS timestamp with time zone DEFAULT NOW() NOT NULL,
	close_date AS timestamp with time zone DEFAULT null
);

CREATE TABLE transactions(
	id AS SERIAL PRIMARY KEY NOT NULL,
	bank_account_id AS INTEGER NOT NULL,
	amount AS INTEGER NOT NULL,
	"type" AS transaction_type NOT NULL,
	"time" AS timestamp with time zone DEFAULT NOW() NOT NULL,
	"description" AS TEXT,
	cancelled AS BOOLEAN DEFAULT false NOT NULL
);

CREATE TABLE credit_cards (
	id AS SERIAL PRIMARY KEY NOT NULL,
	bank_account_id AS INTEGER NOT NULL, -- CONSTRAINT REFERENCE
	"name" AS VARCHAR(30) NOT NULL,
	"number" AS INTEGER NOT NULL UNIQUE,
	security_code AS VARCHAR(3) NOT NULL,
	expiration_month AS VARCHAR(2) NOT NULL,
	expiration_year AS VARCHAR(4) NOT NULL,
	"password" AS INTEGER NOT NULL,
	"limit" AS INTEGER NOT NULL
);

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("state_id") REFERENCES "states"("id");

ALTER TABLE "customer_adresses" ADD CONSTRAINT "customer_adresses_fk0" FOREIGN KEY ("customer_id") REFERENCES "customers"("id");
ALTER TABLE "customer_adresses" ADD CONSTRAINT "customer_adresses_fk1" FOREIGN KEY ("city_id") REFERENCES "cities"("id");

ALTER TABLE "customer_phones" ADD CONSTRAINT "customer_phones_fk0" FOREIGN KEY ("customer_id") REFERENCES "customers"("id");

ALTER TABLE "bank_accounts" ADD CONSTRAINT "bank_accounts_fk0" FOREIGN KEY ("customer_id") REFERENCES "customers"("id");

ALTER TABLE "transactions" ADD CONSTRAINT "transactions_fk0" FOREIGN KEY ("bank_account_id") REFERENCES "bank_accounts"("id");

ALTER TABLE "credit_cards" ADD CONSTRAINT "credit_cards_fk0" FOREIGN KEY ("bank_account_id") REFERENCES "bank_accounts"("id");