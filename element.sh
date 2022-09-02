#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -At -c"

FORMAT_OUTPUT() {
  if [[ -z $1 ]]
    then
      echo "I could not find that element in the database."
    else
      echo $1 | while IFS='|' read NUMBER NAME SYMBOL TYPE MASS M_POINT B_POINT
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
      done
  fi
}

ATOMIC_NUMBER_INPUT() {
  RESULT=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius FROM elements inner join properties USING(atomic_number) inner join types USING(type_id) WHERE atomic_number = $1")
  FORMAT_OUTPUT $RESULT
}

SYMBOL_INPUT() {
  RESULT=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius FROM elements inner join properties USING(atomic_number) inner join types USING(type_id) WHERE symbol = '$1'")
  FORMAT_OUTPUT $RESULT
}

NAME_INPUT() {
  RESULT=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius, boiling_point_celsius FROM elements inner join properties USING(atomic_number) inner join types USING(type_id) WHERE name = '$1'")
  FORMAT_OUTPUT $RESULT
}

CHECK_INPUT() {
  # check if number
  if [[ $1 =~ ^[0-9]+$ ]]
    then
      ATOMIC_NUMBER_INPUT $1
    # check if symbol - <=2 chars
    elif [[ ${#1} -le 2 ]]
    then
      SYMBOL_INPUT $1
    # check if Name - >2 chars
    else
      NAME_INPUT $1
  fi
}

# check if there an argument
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  CHECK_INPUT $1
fi
