USE PokemonAPI;
 

INSERT INTO Pokemon (Id_Pokemon, Pokemon_Name, Pokemon_Pokedex, Pokemon_Type) VALUES
    (1, 'Pikachu',    25, 'Electric'),
    (2, 'Rattata',    19, 'Normal'),
    (3, 'Charmander',  4, 'Fire');
 

INSERT INTO GAMES (id_Game, game_name, Short_name, release_date) VALUES
    (1, 'Pokémon Red',    'RED', '1996-02-27'),
    (2, 'Pokémon Yellow', 'YEL', '1998-09-12'),
    (3, 'Pokémon Gold',   'GLD', '1999-11-21');
 
INSERT INTO Appears_in (fk_Pokemon_Id_Pokemon, fk_GAMES_id_Game) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 2);
 
 /*checagem*/
SELECT p.Pokemon_Name, g.game_name
FROM Appears_in a
JOIN Pokemon p ON p.Id_Pokemon = a.fk_Pokemon_Id_Pokemon
JOIN GAMES g   ON g.id_Game    = a.fk_GAMES_id_Game
ORDER BY p.Pokemon_Name, g.release_date;
 