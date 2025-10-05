#!/bin/sh

if [ 'vic3' = "$3" ]
then
  "$2/tiger/vic3-tiger" --game "$2/vic3/" "$GITHUB_WORKSPACE/$1" > result 2> result-error
fi

if [ 'ck3' = "$3" ]
then
  "$2/tiger/ck3-tiger" --game "$2/ck3/" "$GITHUB_WORKSPACE/$1" > result 2> result-error
fi

cat result-error

base=$(grep -c Error result-error)

F_BOLD="\033[1m"
C_RED="\033[38;5;9m"
C_GREEN="\033[38;5;2m"
NO_FORMAT="\033[0m"

tips=$(grep -c tips result)
untidy=$(grep -c untidy result)
warnings=$(grep -c warning result)
errors=$(grep -c error result)
fatal=$(grep -c fatal result)

if [ "$base" -gt 0 ]
then
  echo " "
  echo "${F_BOLD}${C_RED}The validator could not be initialized!${NO_FORMAT}"
  set -e
  exit 1
fi

if [ -s result ]
then
  cat result

  if [ "$warnings" -gt 1 ] || [ "$errors" -gt 1 ] || [ "$fatal" -gt 1 ]
  then
    echo " "
    echo "${F_BOLD}${C_RED}There are warnings or errors. The validation failed!${NO_FORMAT}"
    set -e
    exit 1
  fi
else
  echo " "
  echo "${F_BOLD}${C_GREEN}Successfully validated!${NO_FORMAT}"
fi

