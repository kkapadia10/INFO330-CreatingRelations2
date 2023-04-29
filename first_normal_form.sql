--my csv file is called pokemon_data_old
--im putting the data of that into the table called pokemon_data
CREATE TABLE imported_pokemon_data(
  abilities TEXT,
  against_bug REAL, against_dark REAL, against_dragon REAL, against_electric REAL,
  against_fairy REAL, against_fight REAL, against_fire REAL, against_flying REAL,
  against_ghost REAL, against_grass REAL, against_ground REAL, against_ice REAL,
  against_normal REAL, against_poison REAL, against_psychic REAL, against_rock REAL,
  against_steel REAL, against_water REAL, attack INTEGER, base_egg_steps INTEGER,
  base_happiness INTEGER, base_total INTEGER, capture_rate INTEGER,classification TEXT,
  defense INTEGER, experience_growth INTEGER, height_m REAL, hp INTEGER, name TEXT,
  percentage_male REAL, pokedex_number INTEGER, sp_attack INTEGER,
  sp_defense INTEGER, speed INTEGER, type1 TEXT, type2 TEXT, weight_kg REAL,
  generation INTEGER, is_legendary INTEGER);

INSERT INTO pokemon_data 
SELECT * FROM pokemon_data_old;

-- split the abilities column and store the values into a new table so that 
--abilities doesn't have multiple values in one cell, meeting 1NF standards 
CREATE TABLE split_abilities (
    pokedex_number INTEGER,
    split_value VARCHAR(255)
);

--removes the square brackets and single quotes 
-- and inserts them in the split_value column of the split_abilities table along with pokedex-Number
INSERT INTO split_abilities (pokedex_number, split_value)
SELECT pokedex_number, REPLACE(REPLACE(REPLACE(TRIM(value), '[', ''), ']', ''), "'", "") as split_value
FROM pokemon_data
CROSS JOIN json_each('["' || replace(abilities, ',', '","') || '"]')
WHERE value <> '';


--create 1NF table called pokemon_1NF 

CREATE TABLE pokemon_1NF(
  against_bug REAL, against_dark REAL, against_dragon REAL, against_electric REAL,
  against_fairy REAL, against_fight REAL, against_fire REAL, against_flying REAL,
  against_ghost REAL, against_grass REAL, against_ground REAL, against_ice REAL,
  against_normal REAL, against_poison REAL, against_psychic REAL, against_rock REAL,
  against_steel REAL, against_water REAL, attack INTEGER, base_egg_steps INTEGER,
  base_happiness INTEGER, base_total INTEGER, capture_rate INTEGER,classification TEXT,
  defense INTEGER, experience_growth INTEGER, height_m REAL, hp INTEGER, name TEXT,
  percentage_male REAL, pokedex_number INTEGER, sp_attack INTEGER,
  sp_defense INTEGER, speed INTEGER, type1 TEXT, type2 TEXT, weight_kg REAL,
  generation INTEGER, is_legendary INTEGER);
  
  INSERT INTO pokemon_1NF 
  SELECT against_bug, against_dark  , against_dragon  , against_electric  ,
  against_fairy  , against_fight  , against_fire  , against_flying  ,
  against_ghost  , against_grass  , against_ground  , against_ice  ,
  against_normal  , against_poison  , against_psychic  , against_rock  ,
  against_steel  , against_water  , attack  , base_egg_steps  ,
  base_happiness  , base_total  , capture_rate  ,classfication  ,
  defense  , experience_growth  , height_m  , hp  , name  ,
  percentage_male  , pokedex_number  , sp_attack  ,
  sp_defense  , speed  , type1  , type2  , weight_kg  ,
  generation  , is_legendary   
  FROM pokemon_data;



