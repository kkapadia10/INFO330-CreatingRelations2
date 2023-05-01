-- Create a pokemon_2NF table which will contain 
-- columns/values that will end up satisfying second normal form.
CREATE TABLE pokemon_2NF (
    attack INTEGER, base_egg_steps INTEGER, base_happiness INTEGER,
    base_total INTEGER, capture_rate INTEGER, classfication TEXT, 
	defense INTEGER, experience_growth INTEGER, height_m REAL, 
	hp INTEGER, name TEXT, percentage_male REAL, 
	pokedex_number INTEGER PRIMARY KEY, sp_attack INTEGER, sp_defense INTEGER, 
	speed INTEGER, weight_kg REAL, generation INTEGER, 
	is_legendary INTEGER
);

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

CREATE TABLE pokemon_abilities(
	abilities_id REFERENCES abilities (abilities_id),
	pokedex_number REFERENCES pokemon_data (pokedex_number)
);

INSERT INTO pokemon_abilities(abilities_id, pokedex_number)
SELECT a.abilities_id, p.pokedex_number
FROM abilities a
JOIN pokemon_data p ON p.abilities LIKE '%' || a.split_ability || '%';