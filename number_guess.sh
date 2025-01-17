#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_INFO=$($PSQL "SELECT user_id, username, games_played, best_game FROM users WHERE username = '$USERNAME'")

if [[ -z $USER_INFO ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
  IFS="|" read USER_ID USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

SECRET_NUMBER=$(($RANDOM % 1000 + 1))

echo "Guess the secret number between 1 and 1000:"

NUM_OF_GUESSES=0

while true
do
  read GUESS

  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi

  NUM_OF_GUESSES=$(( $NUM_OF_GUESSES + 1 ))
  
  if [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
  elif [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo "You guessed it in $NUM_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    break
  fi
done

INSERT_GAME=$($PSQL "UPDATE users SET games_played = games_played + 1, best_game = COALESCE(LEAST(best_game, $NUM_OF_GUESSES), $NUM_OF_GUESSES) WHERE username = '$USERNAME';")

