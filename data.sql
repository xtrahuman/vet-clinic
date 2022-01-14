/* Populate database with sample data. */

INSERT INTO 
    animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
    ('Agumon', 'Feb 3, 2020', 0, TRUE, 10.23),
    ('Gabumon', 'Nov 15, 2018', 2, TRUE, 8.00),
    ('Pikachu', 'Jan 7, 2021', 1, FALSE, 15.04), 
    ('Devimon', 'May 12, 2017', 5, TRUE, 11.00);

-- Populate database with more sample data

INSERT INTO
    animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Charmander', 'Feb 8, 2020', 0, FALSE, -11.00), 
    ('Plantmon', 'Nov 15, 2022', 2, TRUE, -5.70),
    ('Squirtle', 'Apr 2, 1993', 3, FALSE, -12.13),
    ('Angemon', 'Jun 12, 2005', 1, TRUE, -45),
    ('Boarmon', 'Jun 7, 2005', 7, TRUE, 20.40),
    ('Blossom', 'Oct 13, 1998', 3, TRUE, 17.00);

-- Insert data into the owners table

INSERT INTO 
    owners(full_name, age)
VALUES 
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO 
    species(name)
VALUES 
    ('Pokemon'),
    ('Digimon');

-- Modify inserted animals so it includes the species_id value

-- If the name ends in "mon" it will be Digimon

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

-- All other animals are Pokemon

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

-- Sam Smith owns Agumon.

UPDATE animals 
SET owners_id = owners.id 
FROM owners 
WHERE owners.full_name = 'Sam Smith' and name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.

UPDATE animals 
SET owners_id = owners.id 
FROM owners 
WHERE owners.full_name = 'Jennifer Orwell' and (name = 'Gabumon' or name = 'Pikachu');

-- Bob owns Devimon and Plantmon.

UPDATE animals 
SET owners_id = owners.id 
FROM owners 
WHERE owners.full_name = 'Bob' and (name = 'Devimon' or name = 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom.

UPDATE animals 
SET owners_id = owners.id 
FROM owners 
WHERE owners.full_name = 'Melody Pond' and (name = 'Charmander' or name = 'Squirtle' or name = 'Blossom');

-- Dean Winchester owns Angemon and Boarmon.

UPDATE animals 
SET owners_id = owners.id 
FROM owners 
WHERE owners.full_name = 'Dean Winchester' and (name = 'Angemon' or name = 'Boarmon');