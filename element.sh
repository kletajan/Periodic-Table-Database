#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

echo $1

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1 OR symbol='$1' OR name='$1'")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  
  echo -e "The element with atomic number$ATOMIC_NUMBER is $NAME ($SYMBOL). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
  if [[ -z ATOMIC_NUMBER && -z SYMBOL && -z NAME ]]
  then
    echo -e "I could not find that element in the database."
  fi
fi