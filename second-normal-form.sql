-- Dropping table 1NF Pokemon table to create 2NF pokemon table.
DROP TABLE IF EXISTS pokemon;

-- Creating a table that will replicate imported_pokemon_data.
-- This will temporarily serve as the 2NF table.
-- Helps to eliminate partial dependencies.
CREATE TABLE pokemon (
    against_bug REAL, against_dark REAL, against_dragon REAL,
    against_electric REAL, against_fairy REAL, against_fight REAL,
    against_fire REAL, against_flying REAL, against_ghost REAL,
    against_grass REAL, against_ground REAL, against_ice REAL,
    against_normal REAL, against_poison REAL, against_psychic REAL,
    against_rock REAL, against_steel REAL, against_water REAL,
    attack INTEGER, base_egg_steps INTEGER, base_happiness INTEGER,
    base_total INTEGER, capture_rate INTEGER, defense INTEGER,
    experience_growth INTEGER, height_m REAL, hp INTEGER,
    name TEXT, percentage_male REAL, pokedex_number INTEGER PRIMARY KEY,
    sp_attack INTEGER, sp_defense INTEGER, speed INTEGER,
    weight_kg REAL, generation INTEGER, is_legendary INTEGER,
    abilities TEXT, classfication TEXT, type1 TEXT, type2 TEXT
);

-- Inserts the data from the original imported_pokemon_data into the pokemon table.
INSERT INTO pokemon (
    against_bug, against_dark, against_dragon, against_electric, against_fairy,
    against_fight, against_fire, against_flying, against_ghost, against_grass,
    against_ground, against_ice, against_normal, against_poison, against_psychic,
    against_rock, against_steel, against_water, attack, base_egg_steps,
    base_happiness, base_total, capture_rate, defense, experience_growth, height_m,
    hp, name, percentage_male, pokedex_number, sp_attack, sp_defense, speed,
    weight_kg, generation, is_legendary, abilities, classfication, type1, type2
)
SELECT
    against_bug, against_dark, against_dragon, against_electric, against_fairy,
    against_fight, against_fire, against_flying, against_ghost, against_grass,
    against_ground, against_ice, against_normal, against_poison, against_psychic,
    against_rock, against_steel, against_water, attack, base_egg_steps,
    base_happiness, base_total, capture_rate, defense, experience_growth, height_m,
    hp, name, percentage_male, pokedex_number, sp_attack, sp_defense, speed,
    weight_kg, generation, is_legendary, abilities, classfication, type1, type2
FROM imported_pokemon_data;

-- Creates a table called pokemon_abilities. This table acts as a linking table 
-- which links pokemon and abilities. This helps eliminate partial dependencies. 
CREATE TABLE pokemon_abilities(
    ability_id REFERENCES abilities(ability_id), 
    pokedex_number REFERENCES pokemon(pokedex_number)
);

-- Inserts data into the pokemon_abilities linking table. This removes partial
-- dependencies. 
INSERT INTO pokemon_abilities(ability_id, pokedex_number)
SELECT a.ability_id, p.pokedex_number
FROM abilities a
JOIN pokemon p ON p.abilities LIKE '%' || a.split_ability || '%';