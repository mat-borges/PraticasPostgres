CREATE TABLE "users" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL UNIQUE,
	"date_created" DATE NOT NULL DEFAULT NOW()
);

CREATE TABLE "categories" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL
);

CREATE TABLE "sizes" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(10) NOT NULL
);

CREATE TABLE "products" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL,
	"price" INTEGER NOT NULL,
	"category_id" INTEGER NOT NULL REFERENCES "categories" ("id"),
	"size_id" INTEGER NOT NULL REFERENCES "sizes" ("id")
);

CREATE TABLE "images" (
	"id" SERIAL PRIMARY KEY,
	"product_id" INTEGER NOT NULL REFERENCES "products" ("id"),
	"image_url" TEXT NOT NULL
);

CREATE TABLE "orders" (
	"id" SERIAL PRIMARY KEY,
	"user_id" SERIAL NOT NULL REFERENCES "users" ("id"),
	"status" TEXT NOT NULL DEFAULT 'created',
	"date_created" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "cart" (
	"id" SERIAL PRIMARY KEY,
	"order_id" INTEGER NOT NULL REFERENCES "orders" ("id"),
	"product_id" INTEGER NOT NULL UNIQUE REFERENCES "products" ("id"),
	"qty" INTEGER NOT NULL DEFAULT 0
);







