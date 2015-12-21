#!/bin/bash

shellcheck -x ../mockmaker
if [ $? -ne 0 ]; then
    exit 1
fi

