#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Delete all data from Games and Teams tables
echo -e "$($PSQL "TRUNCATE TABLE teams, games")"

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
# skip first row
if [[ $YEAR != 'year' ]]
then
# Insert Winner & Opponent in teams table if does not exit
  TEAM_INSERT=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER'), ('$OPPONENT') ON CONFLICT DO NOTHING")
# Get Winner & Opponent ID
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
# Insert year, round, winner_goals, opponent_goals, winner_id,opponent_id into games table
  GAME_INSERT=$($PSQL "INSERT INTO games(year,round,winner_goals,opponent_goals,winner_id,opponent_id) VALUES($YEAR, '$ROUND', $WINNER_GOALS, $OPPONENT_GOALS, $WINNER_ID, $OPPONENT_ID)")
# check if works
  echo "Game Insert result - $GAME_INSERT"
fi
done
