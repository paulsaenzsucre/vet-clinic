/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(150),
    date_of_birth   DATE,
    escape_attempts INT,
    neutered        BOOLEAN,
    weight_kg       DECIMAL(5,2),
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD COLUMN species  VARCHAR(150);

CREATE TABLE owners (
  id        INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(150),
  age       INT,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id    INT GENERATED ALWAYS AS IDENTITY,
  name  VARCHAR(150),
  PRIMARY KEY(id)
);

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT REFERENCES species(id),
ADD COLUMN owner_id INT REFERENCES owners(id);


