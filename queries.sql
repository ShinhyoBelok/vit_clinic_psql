SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT name, species FROM animals;
ROLLBACK;
SELECT name, species FROM animals;
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT name, species FROM animals;
COMMIT;
SELECT name, species FROM animals;
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_animals;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO delete_animals;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM (SELECT * FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31') AS animals_between_1990_2000 GROUP BY species;
-- query multiple tables
SELECT name AS animals, full_name AS owner FROM animals A 
JOIN owners O ON A.owner_id = O.id 
WHERE O.full_name = 'Melody Pond';

SELECT A.name AS animals, S.name AS type FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT A.name AS animals, O.full_name AS owner
FROM animals A
RIGHT JOIN owners O ON A.owner_id = O.id;

SELECT S.name AS type, COUNT(A.name) AS num_of_animals
FROM animals A 
JOIN species S ON A.species_id = S.id
GROUP BY S.name;

SELECT A.name, S.name AS type, O.full_name AS owner
FROM animals A 
JOIN species S ON A.species_id = S.id
JOIN owners O ON A.owner_id = O.id
WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';

SELECT A.name AS animals, A.escape_attempts, O.full_name AS owner
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE A.escape_attempts = 0 AND O.full_name = 'Dean Winchester';

SELECT COUNT(A.name) AS num_of_animals, O.full_name AS owner
FROM animals A
JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name
ORDER BY num_of_animals DESC
LIMIT 1;