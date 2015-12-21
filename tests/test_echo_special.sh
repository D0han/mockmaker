#!/bin/bash

# shellcheck disable=SC2089
command="echo \"\"a\$PWD\\\'\""

source ./func.sh
check_outputs "${command[@]}"
exit $?
