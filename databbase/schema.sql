/* Lógico_1 – corrigido */
CREATE DATABASE IF NOT EXISTS PokemonAPI;
USE PokemonAPI;

CREATE TABLE Pokemon (
    Id_Pokemon INTEGER AUTO_INCREMENT PRIMARY KEY,
    Pokemon_Name VARCHAR(50) NOT NULL,
    Pokemon_Pokedex INTEGER NOT NULL UNIQUE,
    Pokemon_Type VARCHAR(20) NOT NULL DEFAULT 'Normal'
);

CREATE TABLE GAMES (
    id_Game INTEGER AUTO_INCREMENT PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL,
    Short_name VARCHAR(10) NOT NULL UNIQUE,
    release_date DATE NOT NULL
);

CREATE TABLE Appears_in (
    fk_Pokemon_Id_Pokemon INTEGER NOT NULL,
    fk_GAMES_id_Game INTEGER NOT NULL,
    PRIMARY KEY (fk_Pokemon_Id_Pokemon, fk_GAMES_id_Game)
);

ALTER TABLE Appears_in ADD CONSTRAINT FK_Appears_in_1
    FOREIGN KEY (fk_Pokemon_Id_Pokemon)
    REFERENCES Pokemon (Id_Pokemon)
    ON DELETE RESTRICT;

ALTER TABLE Appears_in ADD CONSTRAINT FK_Appears_in_2
    FOREIGN KEY (fk_GAMES_id_Game)
    REFERENCES GAMES (id_Game)
    ON DELETE RESTRICT;