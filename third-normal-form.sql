-- Creates a table called pokemon_type. This table acts as a linking table 
-- which links pokemon and type. This helps eliminate transitive dependencies
-- to meet 3NF requirements.. 
CREATE TABLE pokemon_type(
    pokedex_number REFERENCES pokemon(pokedex_number), 
    type_id REFERENCES type(type_id)
);
-- Creates a table called type. Eliminates some transitive dependency.
-- Helps to meet 3NF requirements. 
CREATE TABLE type(
    type_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    type1_val TEXT, 
    type2_val TEXT
);

-- Creates a table called pokemon_against. This includes againsat columns. 
-- Eliminates transitive dependencies to meet 3NF requirements.
CREATE TABLE pokemon_against(
    type_id INTEGER REFERENCES type(type_id),
    against_bug REAL, against_dark REAL, against_dragon REAL,
    against_electric REAL, against_fairy REAL, against_fight REAL,
    against_fire REAL, against_flying REAL, against_ghost REAL,
    against_grass REAL, against_ground REAL, against_ice REAL,
    against_normal REAL, against_poison REAL, against_psychic REAL,
    against_rock REAL, against_steel REAL, against_water REAL,
    PRIMARY KEY (type_id) 
);

-- Inserts pokedex_number and type_id into the pokemon_type linking table.
-- Eliminates transative dependencies.
INSERT INTO pokemon_type (pokedex_number, type_id)
SELECT pokedex_number, type_id
FROM pokemon
JOIN type ON (pokemon.type1 = type.type1_val) AND (pokemon.type2 = type.type2_val);

-- Insert types into the type table. Used to eliminate transitive dependencies. 
INSERT INTO type (type1_val, type2_val)
SELECT DISTINCT type1, type2
FROM pokemon;

-- Insert into the pokemon_against table. Eliminates transitive dependencies.  
INSERT OR IGNORE INTO pokemon_against (
	type_id, against_bug, against_dark, 
	against_dragon, against_electric, against_fairy, 
	against_fight, against_fire, against_flying,
	against_ghost, against_grass, against_ground,
	against_ice, against_normal, against_poison,
	against_psychic, against_rock, against_steel, 
	against_water
)
SELECT 
	type_id, against_bug, against_dark, 
	against_dragon, against_electric, against_fairy, 
	against_fight, against_fire, against_flying, 
	against_ghost, against_grass, against_ground, 
	against_ice, against_normal, against_poison, 
	against_psychic, against_rock, against_steel, 
	against_water
FROM pokemon JOIN type ON (pokemon.type1 = type.type1_val) AND (pokemon.type2 = type.type2_val);

-- Drop these columns to move the database into 3NF. 
-- As a result of this step, the database will fully be in 3NF.
ALTER TABLE pokemon DROP COLUMN against_bug;
ALTER TABLE pokemon DROP COLUMN against_dark;
ALTER TABLE pokemon DROP COLUMN against_dragon;
ALTER TABLE pokemon DROP COLUMN against_electric;
ALTER TABLE pokemon DROP COLUMN against_fairy;
ALTER TABLE pokemon DROP COLUMN against_fight;
ALTER TABLE pokemon DROP COLUMN against_fire;
ALTER TABLE pokemon DROP COLUMN against_flying;
ALTER TABLE pokemon DROP COLUMN against_ghost;
ALTER TABLE pokemon DROP COLUMN against_grass;
ALTER TABLE pokemon DROP COLUMN against_ground;
ALTER TABLE pokemon DROP COLUMN against_ice;
ALTER TABLE pokemon DROP COLUMN against_normal;
ALTER TABLE pokemon DROP COLUMN against_poison;
ALTER TABLE pokemon DROP COLUMN against_psychic;
ALTER TABLE pokemon DROP COLUMN against_rock;
ALTER TABLE pokemon DROP COLUMN against_steel;
ALTER TABLE pokemon DROP COLUMN against_water; 
ALTER TABLE pokemon DROP COLUMN abilities; 
ALTER TABLE pokemon DROP COLUMN type1; 
ALTER TABLE pokemon DROP COLUMN type2;