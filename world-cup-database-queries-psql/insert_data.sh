#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # if not found
    if [[ -z $TEAM_ID ]]
    then
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")

      if [[ $INSERT_TEAM == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi
    fi

    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # if not found
    if [[ -z $TEAM_ID ]]
    then 
      INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

      if [[ $INSERT_TEAM == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
    fi

    # Insert data to games table
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'");
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'");

    # get game_id
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id=$WINNER_ID AND opponent_id=$OPPONENT_ID")

    # if not found
    if [[ -z $GAME_ID ]]
    then
      INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

      if [[ $INSERT_GAME == "INSERT 0 1" ]]
      then
        echo Inserted into games, $YEAR $ROUND $WINNER
      fi
    fi
  fi
done
