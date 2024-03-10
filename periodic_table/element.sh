#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  # check if it's a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # query the database using atomic_number
    RESULT=$($PSQL "SELECT atomic_number, name,
                          symbol, 
                          type, 
                          atomic_mass, 
                          melting_point_celsius, 
                          boiling_point_celsius
                          FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING(type_id)
                          WHERE atomic_number = $1")
  else
    # check if it contains 2 letters
    if [[ $(echo "$1" | grep "^.\{1,2\}$") ]]
    then
      # query the database using symbol
      RESULT=$($PSQL "SELECT atomic_number, name,
                           symbol, 
                           type, 
                           atomic_mass, 
                           melting_point_celsius, 
                           boiling_point_celsius 
                           FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING(type_id)
                           WHERE symbol ILIKE '$1'")
    else
      # query the database using name
      RESULT=$($PSQL "SELECT atomic_number, name,
                           symbol, 
                           type, 
                           atomic_mass, 
                           melting_point_celsius, 
                           boiling_point_celsius 
                           FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING(type_id)
                           WHERE name ILIKE '$1'")
    fi
  fi

  # check if result's empty
  if [[ -z $RESULT ]]
  then
    echo I could not find that element in the database.
  else
    # format the result
    echo "$RESULT" | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi
