#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Script that accepts an argument from an element and outputs info about given element.
# can accept atomic number, symbol or name

# Check if argument exists
if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
# get argument type
if [[ $1 =~ [0-9] ]]
then
  ENUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
  if [[ -z $ENUM ]]
  then 
   echo "I could not find that element in the database."
  else
    ENAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$ENUM'")
    ESYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$ENUM'")
    ETYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) WHERE atomic_number = '$ENUM'")
    EMASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$ENUM'")
    EMPC=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$ENUM'")
    EBPC=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$ENUM'")
 
    echo "The element with atomic number $ENUM is $ENAME ($ESYMBOL). It's a $ETYPE, with a mass of $EMASS amu. $ENAME has a melting point of $EMPC celsius and a boiling point of $EBPC celsius."
  fi
else
  n=`echo -n "$1" | wc -c`
  if [[ n -le 2 ]]
  then
    ENUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    
    if [[ -z $ENUM ]]
  then 
   echo "I could not find that element in the database."
  else
    ENAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$ENUM'")
    ESYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$ENUM'")
    ETYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) WHERE atomic_number = '$ENUM'")
    EMASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$ENUM'")
    EMPC=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$ENUM'")
    EBPC=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$ENUM'")
 
    echo "The element with atomic number $ENUM is $ENAME ($ESYMBOL). It's a $ETYPE, with a mass of $EMASS amu. $ENAME has a melting point of $EMPC celsius and a boiling point of $EBPC celsius."
  fi
  else
    ENUM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
    
    if [[ -z $ENUM ]]
  then 
   echo "I could not find that element in the database."
  else
    ENAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$ENUM'")
    ESYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$ENUM'")
    ETYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) WHERE atomic_number = '$ENUM'")
    EMASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$ENUM'")
    EMPC=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$ENUM'")
    EBPC=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$ENUM'")
 
    echo "The element with atomic number $ENUM is $ENAME ($ESYMBOL). It's a $ETYPE, with a mass of $EMASS amu. $ENAME has a melting point of $EMPC celsius and a boiling point of $EBPC celsius."
  fi
  fi
fi
fi
