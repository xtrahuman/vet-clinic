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
SET species = 'unspecified'
WHERE id = animals.id;

-- Rollback database
Rollback;

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

COMMIT;

-- Verify that change was made and persists after commit.

SELECT * FROM animals;

-- Inside a transaction

BEGIN;

-- delete all records in the animals table

DELETE FROM animals;

-- Rollback transaction

ROLLBACK;

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
SET weight_kg = weigh
WHERE weight_kg < 0;

-- Commit transaction

COMMIT;
