/* Database schema to keep the structure of entire database. */

 CREATE TABLE animals (
 id BIGSERIAL NOT NULL PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 date_of_birth DATE NOT NULL,
 escape_attempts INT NOT NULL,
 neutered BOOLEAN NOT NULL,
 weight_kg DECIMAL NOT NULL );

-- adding new column called species to the table.

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

-- Create a table named owners with the following columns

DROP TABLE IF EXISTS owners CASCADE;

CREATE TABLE owners (
id BIGSERIAL PRIMARY KEY,
full_name VARCHAR(100) NOT NULL, 
age INT NOT NULL);

-- Create a table named species with the following columns

DROP TABLE IF EXISTS species CASCADE;

CREATE TABLE species (
id BIGSERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL);

-- Modify animals table

ALTER TABLE animals 
DROP COLUMN IF EXISTS id;

ALTER TABLE animals 
ADD COLUMN id BIGSERIAL NOT NULL PRIMARY KEY;

-- remove column species

ALTER TABLE animals 
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals 
DROP COLUMN species_id;

ALTER TABLE animals 
ADD COLUMN species_id INT;

ALTER TABLE animals 
ADD FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals 
DROP COLUMN owners_id;

ALTER TABLE animals 
ADD COLUMN owners_id INT;

ALTER TABLE animals 
ADD FOREIGN KEY(owners_id) REFERENCES owners(id) ON DELETE CASCADE;



CREATE TABLE vets (
    id BIGSERIAL PRIMARY KEY,
    name varchar(100),
    age int,
    date_of_graduation date
);


CREATE TABLE specializations (
    species_id int,
    vets_id int,
    CONSTRAINT fk_species 
     FOREIGN KEY(species_id) 
      REFERENCES species(id),
    CONSTRAINT fk_vets 
     FOREIGN KEY(vets_id) 
      REFERENCES vets(id)
);

CREATE TABLE visits (
    animals_id int,
    vets_id int,
    date_of_visit date,
    CONSTRAINT fk_animals 
     FOREIGN KEY(animals_id) 
       REFERENCES animals(id),
    CONSTRAINT fk_vets 
     FOREIGN KEY(vets_id) 
       REFERENCES vets(id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animals_id_index ON visits (animals_id);

CREATE INDEX vets_id_index ON visits (vets_id);

CREATE INDEX owners_email_index ON owners (email);
