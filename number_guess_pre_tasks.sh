#! /bin/bash

# Requirements:
# username
# games_played
# best_game
# number_of_guesses

# db gesign
# table: users - user_id pk, name varchar(22)
# table: games - game_id pk, user_id fk, game_played int

# Connect to postgres db
PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"
# create number_guess db
echo $($PSQL "DROP DATABASE number_guess")
echo $($PSQL "CREATE DATABASE number_guess")

# Connect to number_guess db
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# create tables
echo $($PSQL "CREATE TABLE games(game_id SERIAL PRIMARY KEY, username VARCHAR(22) NOT NULL UNIQUE, games_played INT, best_game INT)")

# insert test data
echo $($PSQL "INSERT INTO games(username,games_played,best_game) VALUES ('cevor',3,70)")
