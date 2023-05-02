-- Creating a table that will replicate imported_pokemon_data.
-- This will temporarily serve as the 1NF table.
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
    name TEXT, percentage_male REAL, pokedex_number INTEGER,
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

-- Creates an abilitie stable. This table only contains atomic values which helps to 
-- follow 1NF guidelines. 
CREATE TABLE abilities (
    ability_id INTEGER PRIMARY KEY AUTOINCREMENT,
    split_ability TEXT
);

-- Splits the abilities in the abilities column so there are no two
-- abilities in one box. This creates atomic values. 
-- Taken from section BA slides. 
WITH split(abilities, next_ability) AS 
    (SELECT '' AS abilities, abilities||',' AS next_ability
    FROM pokemon
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