#! /bin/bash

# Connect to number_guess db
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# play guess number game
GUESS_NUMBER() {
  echo "Enter your username:"
  read USERNAME
  # check if user exist in db
  GAMES_RESULT=$($PSQL "SELECT games_played,best_game FROM games WHERE username = '$USERNAME'")
  # add user if not exist
  if [[ -z $GAMES_RESULT ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    # insert user
    INSERT_RESULT=$($PSQL "INSERT INTO games(username) VALUES('$USERNAME')")
  else
    echo $GAMES_RESULT | while IFS='|' read GAMES_PLAYED BEST_GAME
    do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    done
  fi

  #  generate a number
  SECRET_NUMBER=$(($RANDOM % 1000 + 1))

  # guess the number
  echo "Guess the secret number between 1 and 1000:"

  NUMBER_OF_GUESSES=0
  
  while read GUESSED_NUMBER
  do
    if [[ $GUESSED_NUMBER =~ ^[0-9]+$ ]]
    then
      (( NUMBER_OF_GUESSES ++ ))
      NUMBER=$(($GUESSED_NUMBER))
      if [[ $GUESSED_NUMBER > $SECRET_NUMBER ]]
      then
        echo "It's lower than that, guess again:"
      elif [[ $NUMBER < $SECRET_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      else
        echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
        GAMES_RESULT=$($PSQL "SELECT games_played,best_game FROM games WHERE username = '$USERNAME'")
        echo $GAMES_RESULT | while IFS='|' read GAMES_PLAYED BEST_GAME
        do
          if [[ -z $GAMES_PLAYED ]]
          then
            UPDATE_RESULT=$($PSQL "UPDATE games SET games_played = 1, best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
          else
            (( GAMES_PLAYED ++ ))
            if [[ $BEST_GAME < $NUMBER_OF_GUESSES ]]
            then
              UPDATE_RESULT=$($PSQL "UPDATE games SET games_played = $GAMES_PLAYED WHERE username = '$USERNAME'")
            else
              UPDATE_RESULT=$($PSQL "UPDATE games SET games_played = $GAMES_PLAYED, best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
            fi
          fi
        done
        exit
      fi
    else
      echo "That is not an integer, guess again:"
    fi
  done
}

GUESS_NUMBER
