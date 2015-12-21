#!/bin/bash

command="cat mockmaker"

source ./func.sh
check_outputs "${command[@]}"
exit $?
