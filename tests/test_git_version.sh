#!/bin/bash

command=( "git" "version" )

source ./func.sh
check_outputs "${command[@]}"
exit $?
