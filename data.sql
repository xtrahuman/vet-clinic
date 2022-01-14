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


INSERT INTO 
    vets(name, age, date_of_graduation)
VALUES 
    ('William Tatcher', 45, 'Apr 23, 2000'),
    ('Maisy Smith', 26, 'Jan 17, 2019'),
    ('Stephanie Mendez', 64, 'May 4, 1981'),
    ('Jack Harkness', 38, 'Jun 8, 2008');


INSERT INTO 
    specializations(species_id, vets_id)
VALUES 
    ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
    ((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
    ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
    ((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));

INSERT INTO 
    visits(animals_id, vets_id, date_of_visit)
VALUES 
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'May 24, 2020'),
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Jul 22, 2020'),
    ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb 2, 2021'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan 5, 2020'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Mar 8, 2020'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May 14, 2020'),
    ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 4, 2021'),
    ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Feb 24, 2021'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Dec 21, 2019'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Aug 10, 2020'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Apr 7, 2021'),
    ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'Sep 29, 2019'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Oct 3, 2020'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'Nov 4, 2020'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Jan 24, 2019'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May 15, 2019'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Feb 27, 2020'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'Aug 3, 2020'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 24, 2020'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'Jan 11, 2021');
