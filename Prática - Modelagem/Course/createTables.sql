CREATE DATABASE course_example;

CREATE TYPE grade AS ENUM('Abaixo das expectativas','Dentro das Expectativas','Acima das Expectativas');

CREATE TABLE students (
	"id" SERIAL NOT NULL,
	"name" varchar(50) NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"cpf" varchar(11) NOT NULL UNIQUE,
	"class_id" INTEGER NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE classes (
	"id" SERIAL NOT NULL,
	"name" VARCHAR(4) NOT NULL UNIQUE
) WITH (
  OIDS=FALSE
);

CREATE TABLE student_class (
	"id" SERIAL NOT NULL,
	"student_id" INTEGER NOT NULL,
	"class_id" INTEGER NOT NULL,
	"current" BOOLEAN NOT NULL DEFAULT 'true'
) WITH (
  OIDS=FALSE
);

CREATE TABLE projects (
	"id" SERIAL NOT NULL,
	"name" TEXT NOT NULL,
	"module_id" INTEGER NOT NULL
) WITH (
  OIDS=FALSE
);

CREATE TABLE delivers (
	"id" SERIAL NOT NULL,
	"student_id" INTEGER NOT NULL,
	"project_id" INTEGER NOT NULL,
	"grade" grade NOT NULL,
	"delivered_at" timestamp with time zone NOT NULL DEFAULT NOW()
) WITH (
  OIDS=FALSE
);

CREATE TABLE modules (
	"id" SERIAL NOT NULL,
	"name" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);

ALTER TABLE "student_class" ADD CONSTRAINT "student_class_fk0" FOREIGN KEY ("student_id") REFERENCES "students"("id");
ALTER TABLE "student_class" ADD CONSTRAINT "student_class_fk1" FOREIGN KEY ("class_id") REFERENCES "classes"("id");

ALTER TABLE "projects" ADD CONSTRAINT "projects_fk0" FOREIGN KEY ("module_id") REFERENCES "modules"("id");

ALTER TABLE "delivers" ADD CONSTRAINT "delivers_fk0" FOREIGN KEY ("student_id") REFERENCES "students"("id");
ALTER TABLE "delivers" ADD CONSTRAINT "delivers_fk1" FOREIGN KEY ("project_id") REFERENCES "projects"("id");







