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

CREATE TABLE vets (
  id                  INT GENERATED ALWAYS AS IDENTITY,
  name                VARCHAR(150),
  age                 INT,
  date_of_graduation  DATE,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
  vet_id        INT REFERENCES vets(id),
  specie_id     INT REFERENCES species(id),
  PRIMARY KEY(vet_id, specie_id)
);

CREATE TABLE visits (
  animal_id     INT REFERENCES animals(id),
  vet_id        INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(animal_id, vet_id, date_of_visit)
);

ALTER TABLE owners
ADD COLUMN email VARCHAR(120);

ALTER TABLE visits
  ALTER COLUMN date_of_visit TYPE TIMESTAMP;

CREATE INDEX anml_id ON visits(animal_id ASC);

CREATE INDEX vt_id ON visits(vet_id ASC);

CREATE INDEX own_id ON owners(email ASC);