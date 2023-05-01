-- Create a pokemon_3NF table which will contain 
-- columns/values that will end up satisfying third normal form.
CREATE TABLE pokemon_3NF (
	pokedex_number INTEGER PRIMARY KEY, name TEXT, classfication TEXT,
	capture_rate INTEGER, generation INTEGER, 
	is_legendary INTEGER, attack INTEGER, sp_attack INTEGER,
	defense INTEGER, sp_defense INTEGER, percentage_male REAL, 
	speed INTEGER, weight_kg REAL, experience_growth INTEGER, 
	height_m REAL, hp INTEGER, base_total INTEGER, base_happiness INTEGER, base_egg_steps INTEGER);
	

-- Create a type table to hold type values (which includes the against
-- categories as they are a part of type). This table helps us
-- eliminate transitive dependency.
CREATE TABLE type (
    type_id INTEGER PRIMARY KEY AUTOINCREMENT, type1 TEXT, type2 TEXT);

--  Create a pokemon_type table to hold pokemon type values .
-- This table is a linking table that links the Pokemon table with the type table.
DROP TABLE IF EXISTS pokemon_type;
	CREATE TABLE pokemon_type (
    pokedex_number INTEGER,
    type_id INTEGER,
    FOREIGN KEY (pokedex_number) REFERENCES pokemon_data (pokedex_number),
    FOREIGN KEY (type_id) REFERENCES type (type_id)
);
	
DROP TABLE IF EXISTS against;
CREATE TABLE against (
	type_id INTEGER PRIMARY KEY AUTOINCREMENT, against_bug REAL,
    against_dark REAL, against_dragon REAL, against_electric REAL,
    against_fairy REAL, against_fight REAL, against_fire REAL,
    against_flying REAL, against_ghost REAL, against_grass REAL,
    against_ground REAL, against_ice REAL, against_normal REAL,
    against_poison REAL, against_psychic REAL, against_rock REAL,
    against_steel REAL, against_water REAL);
	
	
-- Insert the necessary data into the pokemon_3nf table 
-- in order to fulfill third normal form requirements.
INSERT INTO pokemon_3nf SELECT 
	pokedex_number, name, classfication, 
	capture_rate, generation, 
	is_legendary, attack, sp_attack, 
	defense, sp_defense, percentage_male, 
	speed, weight_kg, experience_growth, 
	height_m, hp, base_total, base_egg_steps, base_happiness 
FROM pokemon_data;

-- Insert the type data into the type table 
-- in order to fulfill third normal form requirements.
INSERT INTO type (type1, type2)
SELECT DISTINCT 
  type1, type2 
FROM pokemon_data; 

INSERT INTO pokemon_type (pokedex_number, type_id)
SELECT pokedex_number, type_id
FROM pokemon_data
JOIN type ON (pokemon_data.type1 = type.type1) AND (pokemon_data.type2 = type.type2); 

INSERT INTO against (
	against_bug,
    against_dark, against_dragon, against_electric,
    against_fairy, against_fight, against_fire,
    against_flying, against_ghost, against_grass,
    against_ground, against_ice, against_normal,
    against_poison, against_psychic, against_rock,
    against_steel, against_water)
SELECT
	against_bug,
    against_dark, against_dragon, against_electric,
    against_fairy, against_fight, against_fire,
    against_flying, against_ghost, against_grass,
    against_ground, against_ice, against_normal,
    against_poison, against_psychic, against_rock,
    against_steel, against_water
FROM pokemon_data;