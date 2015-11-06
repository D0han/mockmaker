#!/bin/bash

command="unknown_command"

cd ..
./mock ${command} > /dev/null 2>&1
if [ $? -ne 2 ]; then
    exit 1
fi
exit 0
