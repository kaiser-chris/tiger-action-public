#!/bin/sh

"$2/tiger/vic3-tiger" --game "$2/vic3/" "$GITHUB_WORKSPACE/$1" > result

F_BOLD="\033[1m"
C_RED="\033[38;5;9m"
C_GREEN="\033[38;5;2m"
NO_FORMAT="\033[0m"

tips=$(grep -c tips result)
untidy=$(grep -c untidy result)
warnings=$(grep -c warning result)
errors=$(grep -c error result)
fatal=$(grep -c fatal result)

if [ -s result ]
then
  cat result
  echo " "
  echo "${F_BOLD}Overview:${NO_FORMAT}"

  if [ "$tips" -gt 0 ]
  then
    echo " - ${F_BOLD}$tips${NO_FORMAT} tips"
  else
    echo " - ${F_BOLD}no${NO_FORMAT} tips"
  fi

  if [ "$untidy" -gt 0 ]
  then
    echo " - ${F_BOLD}$untidy${NO_FORMAT} untidy hints"
  else
    echo " - ${F_BOLD}no${NO_FORMAT} untidy hints"
  fi

  if [ "$warnings" -gt 0 ]
  then
    echo " - ${F_BOLD}$warnings${NO_FORMAT} warnings"
  else
    echo " - ${F_BOLD}no${NO_FORMAT} warnings"
  fi

  if [ "$errors" -gt 0 ]
  then
    echo " - ${F_BOLD}$errors${NO_FORMAT} errors"
  else
    echo " - ${F_BOLD}no${NO_FORMAT} errors"
  fi

  if [ "$fatal" -gt 0 ]
  then
    echo " - ${F_BOLD}$fatal${NO_FORMAT} fatal errors"
  else
    echo " - ${F_BOLD}no${NO_FORMAT} errors"
  fi

  if [ "$warnings" -gt 0 ] || [ "$errors" -gt 0 ] || [ "$fatal" -gt 0 ]
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

