#!/bin/bash

bindir="$(dirname "${0}")/bin"
export PATH="${bindir}:${PATH}"

command=( "foo bar" "qux" )

source ./func.sh
check_outputs "${command[@]}"
exit $?
