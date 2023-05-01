-- Creates a new table called pokemon_data. This table is meant to be a copy 
-- of the original imported_pokemon_data table so that we can always keep 
-- the original data unedited in case we make a mistake/error.
CREATE TABLE pokemon_data (
  abilities TEXT, against_bug REAL, against_dark REAL,
    against_dragon REAL, against_electric REAL, against_fairy REAL, 
  against_fight REAL, against_fire REAL, against_flying REAL,
  against_ghost REAL, against_grass REAL, against_ground REAL,
    against_ice REAL, against_normal REAL, against_poison REAL,
    against_psychic REAL, against_rock REAL, against_steel REAL,
    against_water REAL, attack INTEGER, base_egg_steps INTEGER,
    base_happiness INTEGER, base_total INTEGER, capture_rate INTEGER,
  classfication TEXT, defense INTEGER, experience_growth INTEGER,
    height_m REAL, hp INTEGER, name TEXT,
    percentage_male REAL, pokedex_number INTEGER, sp_attack INTEGER,
    sp_defense INTEGER, speed INTEGER, type1 TEXT, 
    type2 TEXT, weight_kg REAL, generation INTEGER,
  is_legendary INTEGER
);

-- Insert all the data from imported_pokemon_data into pokemon_data.
INSERT INTO pokemon_data SELECT * FROM imported_pokemon_data;

-- Creates an abilities table which will have the split of the abilities.
-- The table will only have 1 ability per row, which will satisfy the first rule
-- of first normal form.
-- Autoincrements the abilities_id variable.
CREATE TABLE abilities (
  abilities_id INTEGER PRIMARY KEY AUTOINCREMENT,
  split_ability TEXT
);

-- Create a pokemon_1NF table which will contain 
-- columns/values that will end up satisfying first normal form.
CREATE TABLE pokemon_1NF (
  against_bug REAL, against_dark REAL,
    against_dragon REAL, against_electric REAL, against_fairy REAL, 
  against_fight REAL, against_fire REAL, against_flying REAL,
  against_ghost REAL, against_grass REAL, against_ground REAL,
    against_ice REAL, against_normal REAL, against_poison REAL,
    against_psychic REAL, against_rock REAL, against_steel REAL,
    against_water REAL, attack INTEGER, base_egg_steps INTEGER,
    base_happiness INTEGER, base_total INTEGER, capture_rate INTEGER,
  classfication TEXT, defense INTEGER, experience_growth INTEGER,
    height_m REAL, hp INTEGER, name TEXT,
    percentage_male REAL, pokedex_number INTEGER, sp_attack INTEGER,
    sp_defense INTEGER, speed INTEGER, type1 TEXT, 
    type2 TEXT, weight_kg REAL, generation INTEGER,
  is_legendary INTEGER
);
-- Insert the necessary data into the pokemon_1NF table 
-- in order to fulfill first normal form requirements.
INSERT INTO pokemon_1NF 
SELECT 
  against_bug, against_dark,
    against_dragon, against_electric, against_fairy, 
  against_fight, against_fire, against_flying,
  against_ghost, against_grass, against_ground,
    against_ice, against_normal, against_poison,
    against_psychic, against_rock, against_steel,
    against_water, attack, base_egg_steps,
    base_happiness, base_total, capture_rate,
  classfication, defense, experience_growth,
    height_m, hp, name,
    percentage_male, pokedex_number, sp_attack,
    sp_defense, speed, type1, 
    type2, weight_kg, generation,
  is_legendary
FROM pokemon_data;

WITH split(abilities, next_ability) AS 
    (SELECT '' AS abilities, abilities||',' AS next_ability
    FROM pokemon_data
    UNION ALL
        SELECT 
            substr(next_ability, 0, instr(next_ability, ',')) AS abilities, 
            substr(next_ability, instr(next_ability, ',') +1) AS next_ability
        FROM split 
        WHERE next_ability !=''
)
INSERT INTO abilities(split_ability)
SELECT DISTINCT replace(replace(replace(abilities, '[', ''), ']', ''), '''', '') AS abilities
FROM split
WHERE abilities !='';