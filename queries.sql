/*Queries that provide answers to the questions from all projects.*/

-- Show all animals
SELECT *
FROM animals;

-- Find all animals whose name ends in "mon". */
SELECT *
FROM animals
WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE DATE_PART('YEAR', date_of_birth) >= 2016 AND DATE_PART('YEAR', date_of_birth) <= 2019;

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
FROM animals
WHERE neutered AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered;

-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE NOT name = 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
FROM animals
WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Inside a transaction update the animals table by setting the species column to 
-- unspecified. Verify that change was made. Then roll back the change and verify
-- that the species columns went back to the state before the transaction.
BEGIN;
  UPDATE animals
  SET species = 'unspecified';
  SELECT *
  FROM animals;
ROLLBACK;
SELECT *
FROM animals;

-- Inside a transaction:
-- · Update the animals table by setting the species column to digimon for all
--   animals that have a name ending in mon.
-- · Update the animals table by setting the species column to pokemon for all
--   animals that don't have species already set.
-- · Commit the transaction.
-- · Verify that change was made and persists after commit.
BEGIN;
  UPDATE animals
  SET species = 'digimon'
  WHERE name LIKE '%mon';
  UPDATE animals
  SET species = 'pokemon'
  WHERE species IS NULL;
COMMIT;

SELECT *
FROM animals;

-- Inside a transaction delete all records in the animals table, then roll back
-- the transaction.
-- After the rollback verify if all records in the animals table still exists.
BEGIN;
  DELETE
  FROM animals;
ROLLBACK;

SELECT *
FROM animals;

-- Inside a transaction:
-- · Delete all animals born after Jan 1st, 2022.
-- · Create a savepoint for the transaction.
-- · Update all animals' weight to be their weight multiplied by -1.
-- · Rollback to the savepoint
-- · Update all animals' weights that are negative to be their weight multiplied by -1.
-- · Commit transaction
BEGIN;
  DELETE
  FROM animals
  WHERE date_of_birth > '2022-01-01';
  SAVEPOINT firstStep;
  UPDATE animals
  SET weight_kg = weight_kg * -1;
  ROLLBACK TO firstStep;
  UPDATE animals
  SET weight_kg = weight_kg * -1
  WHERE weight_kg < 0;
COMMIT;

SELECT *
FROM animals;

-- Write queries to answer the following questions:
-- · How many animals are there?
SELECT COUNT(*)
FROM animals;

-- · How many animals have never tried to escape?
SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;

-- · What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;

-- · Who escapes the most, neutered or not neutered animals?
SELECT
  CASE
    WHEN neutered THEN 'Neutered'
    ELSE 'Not neutered'
  END As Type,
  SUM(escape_attempts) AS Escapes
FROM animals
GROUP BY neutered
ORDER  BY escapes DESC
LIMIT 1;

-- · What is the minimum and maximum weight of each type of animal?
SELECT
  CASE
    WHEN neutered THEN 'Neutered'
    ELSE 'Not neutered'
  END As Type,
  MIN(weight_kg) AS min_weight,
  MAX(weight_kg) AS max_weight
FROM animals
GROUP BY neutered;

-- · What is the average number of escape attempts per animal type
--   of those born between 1990 and 2000?
SELECT
  CASE
    WHEN neutered THEN 'Neutered'
    ELSE 'Not neutered'
  END As Type,
  AVG(escape_attempts) AS Escapes
FROM animals
WHERE DATE_PART('YEAR', date_of_birth) >= 1990
  AND DATE_PART('YEAR', date_of_birth) <= 2000
GROUP BY neutered;


-- What animals belong to Melody Pond?
SELECT name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
FROM animals
INNER JOIN species ON  animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name AS owner, STRING_AGG (animals.name, ', ') AS animals
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name;

-- How many animals are there per species?
SELECT species.name AS species, COUNT(animals.name)
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester ' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name AS owner, COUNT(animals.name)
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
HAVING COUNT(animals.name) = (
  SELECT MAX(animals_count)
  FROM (
    SELECT owners.full_name AS owner, COUNT(animals.name) AS animals_count
    FROM owners
    LEFT JOIN animals ON owners.id = animals.owner_id
    GROUP BY owners.full_name
  ) AS counts);


-- Who was the last animal seen by William Tatcher?
SELECT animals.name
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
WHERE visits.date_of_visit = (
  SELECT MAX(dates)
  FROM (
    SELECT visits.animal_id, visits.date_of_visit AS dates
    FROM visits
    INNER JOIN vets ON visits.vet_id = vets.id
    WHERE vets.name = 'William Tatcher'
    ORDER BY visits.date_of_visit DESC) AS meetings);

-- How many different animals did Stephanie Mendez see
SELECT COUNT (*)
FROM visits
LEFT JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, STRING_AGG (species.name, ', ') AS specialities
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.specie_id = species.id
GROUP BY vets.name;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON  visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.date_of_visit)
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
HAVING COUNT(visits.date_of_visit) = (
  SELECT MAX(vet_visits)
  FROM (
    SELECT animal_id, COUNT(date_of_visit) AS vet_visits
    FROM visits
    GROUP BY animal_id
  ) AS counts);

-- Who was Maisy Smith's first visit?
SELECT animals.name
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
WHERE visits.date_of_visit = (
  SELECT MIN(dates)
  FROM (
    SELECT visits.animal_id, visits.date_of_visit AS dates
    FROM visits
    INNER JOIN vets ON visits.vet_id = vets.id
    WHERE vets.name = 'Maisy Smith') AS meetings);

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT visits.date_of_visit AS visit_date, animals.name AS animal_name, animals.date_of_birth AS animal_birth,
  animals.escape_attempts AS animal_escapes,
  CASE
    WHEN neutered THEN 'Neutered'
    ELSE 'Not neutered'
  END AS animal_type,
  animals.weight_kg AS animal_weight, owners.full_name AS owner_name, vets.name AS vet_name,
  vets.age AS vet_age, vets.date_of_graduation AS vet_grad_date
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE visits.date_of_visit = (
  SELECT MAX(dates)
  FROM (
    SELECT visits.animal_id, visits.date_of_visit AS dates
    FROM visits) AS meetings);

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
LEFT JOIN specializations ON animals.species_id = specializations.specie_id
  AND visits.vet_id = specializations.vet_id
WHERE specializations.specie_id IS NULL AND specializations.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT (animals.species_id)
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN species ON  animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name
HAVING COUNT (animals.species_id) = (
  SELECT MAX(specie_visits)
  FROM (
    SELECT species.name, COUNT (animals.species_id) AS specie_visits
    FROM visits
    INNER JOIN animals ON visits.animal_id = animals.id
    INNER JOIN vets ON visits.vet_id = vets.id
    INNER JOIN species ON  animals.species_id = species.id
    WHERE vets.name = 'Maisy Smith'
    GROUP BY species.name) AS species_count);