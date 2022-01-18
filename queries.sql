/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-12-31' and '2019-01-01';
SELECT name FROM animals WHERE neutered = TRUE and escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

-- update the animals table by setting the species column to unspecified
UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;
-- Rollback database
Rollback;

SELECT * FROM animals;

-- inside a transaction
BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals
SET species = 'pokemon'
WHERE species != 'digimon';

-- Commit the transaction.

SELECT * FROM animals;

COMMIT;

-- Verify that change was made and persists after commit.

SELECT * FROM animals;

-- Inside a transaction

BEGIN;

-- delete all records in the animals table

DELETE FROM animals;

SELECT * FROM animals;

-- Rollback transaction

ROLLBACK;

SELECT * FROM animals;

-- Inside a transaction

BEGIN;

-- Delete all animals born after Jan 1st, 2022.

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.

SAVEPOINT first_delete;

-- Update all animals' weight to be their weight multiplied by -1.

 UPDATE animals
 SET weight_kg = weight_kg * -1;

-- Rollback to savepoint

ROLLBACK TO first_delete;

-- Update all animals' weights that are negative to be their weight multiplied by -1.

UPDATE animals
SET weight_kg = weight_kg * -1;
WHERE weight_kg < 0;

SELECT * FROM animals;

-- Commit transaction

COMMIT;

-- count all animals

SELECT 
    COUNT(*)
FROM
    animals;

-- count all animals without escape attempts(NULL)

SELECT 
    COUNT(*)
FROM
    animals;
WHERE 
    escape_attempts = 0;

-- what is average weight of all animals

SELECT 
    AVG(weight_kg)::numeric(10,2) 
FROM
    animals;

-- which animal escape most neutered or not neutered?

SELECT 
    neutered, sum(escape_attempts) AS total_escape 
FROM 
    animals 
GROUP BY
    neutered
HAVING
    SUM(CASE WHEN neutered = TRUE THEN escape_attempts ELSE 0 END) > SUM(CASE WHEN neutered = FALSE THEN escape_attempts ELSE 0 END);

-- What is the minimum and maximum weight of each type of animal?

SELECT 
    species, MIN(weight_kg), MAX(weight_kg) 
FROM 
    animals
GROUP BY 
    species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT 
    species, AVG(escape_attempts)::numeric(10,0) AS avg_escape_attempts 
FROM
    animals
WHERE 
    date_of_birth 
BETWEEN
    '1990-12-31' AND '2000-1-1' 
GROUP BY species;

-- What animals belong to Melody Pond?

SELECT 
    name 
FROM 
    animals a 
JOIN 
    owners o ON o.id = a.owners_id 
WHERE 
    o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT 
    a.name 
FROM 
    animals a 
JOIN 
    species s ON s.id = a.species_id 
WHERE 
    s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT 
    o.full_name AS owners_name, a.name AS animal 
FROM 
    animals a 
FULL JOIN 
    owners o ON o.id = a.owners_id;

-- How many animals are there per species?

SELECT 
    s.name, count(a.name) 
FROM 
    animals a 
JOIN 
    species s 
ON 
    s.id = a.species_id 
GROUP BY 
    s.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT 
    o.full_name, s.name species, a.name animal_name 
FROM 
    animals a 
JOIN 
    species s ON s.id = a.species_id 
JOIN 
    owners o ON a.owners_id = s.id 
WHERE 
    o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT 
    animals.name, owners.full_name, animals.escape_attempts
FROM 
    animals
JOIN 
    owners ON animals.owners_id = owners.id
WHERE 
    owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT 
    owners.full_name, COUNT(animals.name)
FROM 
    animals
JOIN 
    owners ON animals.owners_id = owners.id
GROUP BY 
    owners.full_name
ORDER BY 
    COUNT DESC LIMIT 1; 

-- Who was the last animal seen by William Tatcher?
SELECT 
    animals.name, vets.name, visits.date_of_visit
FROM 
    vets
JOIN 
    visits ON vets.id = visits.vets_id
JOIN 
    animals ON animals.id = visits.animals_id
WHERE 
    vets.name = 'William Tatcher'
ORDER BY 
    visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT 
    COUNT(*) as num_animal
FROM
    vets
JOIN 
    visits ON vets.id = visits.vets_id
WHERE 
    vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT 
    vets.name,species.name as specialization 
FROM 
    vets
LEFT JOIN 
    specializations ON specializations.vets_id = vets.id
LEFT JOIN  
    species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT 
    animals.name as animal_name, visits.date_of_visit 
FROM 
    animals
JOIN 
    visits ON visits.animals_id = animals.id
JOIN 
    vets ON vets.id = visits.vets_id
WHERE 
    vets.name = 'Stephanie Mendez' 
    AND visits.date_of_visit >= '2020-04-01' 
    AND visits.date_of_visit <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT 
    animals.name, COUNT(*)
FROM animals
JOIN 
    visits ON visits.animals_id = animals.id
GROUP BY 
    animals.name
ORDER BY count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT 
    vets.name, visits.date_of_visit, animals.name 
FROM 
    visits 
JOIN 
    vets ON vets.id = visits.vets_id
JOIN 
    animals ON animals.id = visits.animals_id
WHERE 
    vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
	date_of_visit,
	animals.date_of_birth as animal_dob,
	animals.escape_attempts,
	animals.neutered,
	animals.weight_kg as animal_weight,
	vets.name as vet_name,
	vets.age as vet_age,
	vets.date_of_graduation
FROM 
    visits
JOIN 
    animals ON animals.id = visits.animals_id
JOIN 
    vets ON vets.id = visits.vets_id
ORDER BY 
    date_of_visit LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT 
    COUNT(*) 
FROM
    visits
JOIN 
    animals ON animals.id = visits.animals_id
JOIN 
    vets ON vets.id = visits.vets_id
JOIN 
    specializations ON specializations.vets_id = visits.vets_id 
WHERE 
    animals.species_id != specializations.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT 
    species.name as species, COUNT(*) 
FROM 
    visits
JOIN 
    vets ON vets.id = visits.vets_id
JOIN 
    animals ON animals.id = visits.animals_id
JOIN 
    species ON species.id = animals.species_id 
WHERE vets.name = 'Maisy Smith'
GROUP BY 
    species.name;

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';