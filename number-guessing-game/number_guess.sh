#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# initialize secret number
SECRET_NUM=$((1 + RANDOM % 1000))

MAIN () {

	if [[ $1 ]]
	then
		echo -e "\n$1"
	fi

	echo -e "Enter your username:"
	read USERNAME_INPUT
	
	# check player's username input
	if [[ "$USERNAME_INPUT" =~ [\ ] || ! "$USERNAME_INPUT" =~ ^[a-zA-Z0-9_]{5,22}$ ]]
	then
		MAIN "The username can only contains 5-22 characters with no spaces and only consist of alphabets, underscores, and numbers."
	else
		# get player's information from periodic_table database
		PLAYER_INFO=$($PSQL "SELECT COUNT(*), MIN(total_attempt) FROM games INNER JOIN players USING(player_id) WHERE username = '$USERNAME_INPUT' GROUP BY player_id")
		
		# if player's information is empty
		if [[ -z $PLAYER_INFO ]]
		then
			# insert user as a new player to database
			INSERT_PLAYER=$($PSQL "INSERT INTO players(username) VALUES ('$USERNAME_INPUT')")
			echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
		else
			echo "$PLAYER_INFO" | while IFS='|' read TOTAL_GAMES BEST_RECORD
			do
				echo "Welcome back, $USERNAME_INPUT! You have played $TOTAL_GAMES games, and your best game took $BEST_RECORD guesses."
			done
		fi
	fi
	
	echo -e "\nGuess the secret number between 1 and 1000:"
	ATTEMPTS=0

	# initialize the game function
	GAME
	
	exit 0
}

GAME () {
	
	if [[ $1 ]]
	then
		echo -e "\n$1"
	fi
	
	ATTEMPTS=$(($ATTEMPTS + 1))
	read PLAYER_ANSWER
	
	# check if player's answer is not an integer
	if [[ ! $PLAYER_ANSWER =~ ^[0-9]+$ ]]
	then
		GAME "That is not an integer, guess again:"
	else
		# if player's answer is equal to the secret number
		if [[ $PLAYER_ANSWER -eq $SECRET_NUM ]]
		then
			# insert the game's record to the database
			PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username = '$USERNAME_INPUT'")
			INSERT_GAME=$($PSQL "INSERT INTO games(total_attempt, player_id) VALUES ($ATTEMPTS, $PLAYER_ID)")

			echo "You guessed it in $ATTEMPTS tries. The secret number was $SECRET_NUM. Nice job!"

		# if player's answer is less than the secret number
		elif [[ $PLAYER_ANSWER -lt $SECRET_NUM ]]
		then
			GAME "It's higher than that, guess again:"

		# if player's answer is greater than the secret number
		elif [[ $PLAYER_ANSWER -gt $SECRET_NUM ]]
		then
			GAME "It's lower than that, guess again:"
		fi	
	fi
}

MAIN 
