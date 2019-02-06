#!/bin/bash

command=( "git" "thiswillfail" )

source ./func.sh
check_outputs "${command[@]}"
exit $?
