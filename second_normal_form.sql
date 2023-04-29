-- Create a pokemon_2NF table which will contain 
-- columns/values that will end up satisfying second normal form.
DROP TABLE IF EXISTS pokemon_2NF;
CREATE TABLE pokemon_2NF (
    attack INTEGER, base_egg_steps INTEGER, base_happiness INTEGER,
    base_total INTEGER, capture_rate INTEGER, classfication TEXT, 
	defense INTEGER, experience_growth INTEGER, height_m REAL, 
	hp INTEGER, name TEXT, percentage_male REAL, 
	pokedex_number INTEGER PRIMARY KEY, sp_attack INTEGER, sp_defense INTEGER, 
	speed INTEGER, weight_kg REAL, generation INTEGER, 
	is_legendary INTEGER
);

 DROP TABLE IF EXISTS abilities;
CREATE TABLE abilities (
	abilities_id INTEGER PRIMARY KEY AUTOINCREMENT, 
	split_ability TEXT
);

INSERT INTO abilities (split_ability)
SELECT DISTINCT split_ability
FROM split_abilites;

DROP TABLE IF EXISTS pokemon_abilities;
CREATE TABLE pokemon_abilities(
    pokedex_number INTEGER,
    abilities_id INTEGER,
    FOREIGN KEY (pokedex_number) REFERENCES pokemon_data (pokedex_number),
    FOREIGN KEY (abilities_id) REFERENCES abilities (abilities_id)
);

INSERT INTO pokemon_abilities (pokedex_number, abilities_id)
SELECT s.pokedex_number, a.abilities_id
FROM split_abilities AS s
JOIN abilities AS a ON s.split_value = a.split_value;

-- Insert the necessary data into the pokemon_2nf table 
-- in order to fulfill second normal form requirements.
INSERT INTO pokemon_2nf SELECT
    attack, base_egg_steps, base_happiness,
    base_total, capture_rate, classfication,  
	defense, experience_growth , height_m, 
	hp, name, percentage_male, 
	pokedex_number, sp_attack, sp_defense, 
	speed, weight_kg, generation, 
	is_legendary 
FROM pokemon_data;