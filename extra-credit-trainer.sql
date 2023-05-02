-- Creates table named trainer. 
CREATE TABLE trainer (
  trainer_id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name VARCHAR(80),
  last_name VARCHAR(80)
);

-- Create table named favorite_pokemon_types. 
CREATE TABLE favorite_pokemon_types (
  trainer_id INTEGER REFERENCES trainer(trainer_id),
  type_id INTEGER REFERENCES type(type_id),
  PRIMARY KEY (trainer_id, type_id)
);

-- Create table named pokemon_team. 
CREATE TABLE pokemon_team (
  team_id INTEGER PRIMARY KEY AUTOINCREMENT,
  trainer_id INTEGER REFERENCES trainer(trainer_id),
  name VARCHAR(50)
);

-- Create table named team_member. 
CREATE TABLE team_member (
  team_id INTEGER REFERENCES pokemon_team(team_id),
  pokedex_number INTEGER REFERENCES pokemon(pokedex_number),
  team_member_id INTEGER,
  PRIMARY KEY (team_id, pokedex_number)
);

-- Insert trainer first and last name into trainer table. 
INSERT INTO trainer (first_name, last_name) VALUES
('Kaden', 'Kapadia'), ('Jon', 'Evans'), ('Shaan', 'Cruz'),
('Jeff', 'Cai'), ('Stacey', 'Beck'), ('Sarah', 'Williams'),
('Mason', 'Sanders'), ('Kevin', 'Lin'), ('Lucy', 'Xia'),
('Deven', 'Patel');

-- Insert trainer's favorite pokemon types into favorite_pokemon_types table.
INSERT INTO favorite_pokemon_types (trainer_id, type_id) VALUES
(1, 13), (1, 4), (2, 7), (3, 1), (3, 6), (4, 5), (4, 14), (5, 8), 
(6, 2), (7, 8), (8, 4), (8, 3), (9, 16), (9, 18), (10, 19), (10, 15);

-- Insert trainer's pokemon_team into pokemon_team table. 
INSERT INTO pokemon_team (trainer_id, name) VALUES
(1, 'Team 1'), (2, 'Team 2'), (3, 'Team 3'),
(4, 'Team 4'), (5, 'Team 5'), (6, 'Team 6'),
(7, 'Team 7'), (8, 'Team 8'), (9, 'Team 9'),
(10, 'Team 10');

-- Insert trainer's pokemons into team_member table. 
INSERT INTO team_member VALUES
(1, 138, 1), (1, 369, 2), (1, 319, 3), (1, 46, 4), (1, 333, 5),
(2, 371, 1), (2, 301, 2), (2, 20, 3), (2, 386, 4), (2, 251, 5),
(3, 352, 1), (3, 118, 2), (3, 284, 3), (3, 234, 4), (3, 162, 5),
(4, 177, 1), (4, 216, 2), 
(5, 276, 1), (5, 308, 2), (5, 180, 3), (5, 45, 4), (5, 329, 5),
(6, 45, 1), (6, 289, 2), (6, 47, 3), (6, 233, 4), 
(7, 298, 1), (7, 370, 2), (7, 127, 3), (7, 167, 4),
(8, 376, 1), (8, 191, 2), (8, 286, 3), (8, 11, 4), (8, 217, 5),
(9, 392, 1), (9, 311, 2), 
(10, 199, 1), (10, 153, 2), (10, 66, 3), (10, 382, 4), (10, 334, 5), (10, 88, 6);