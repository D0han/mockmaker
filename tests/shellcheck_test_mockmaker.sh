#!/bin/bash

shellcheck ../mockmaker
if [ $? -ne 0 ]; then
    exit 1
fi

