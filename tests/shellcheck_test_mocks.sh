#!/bin/bash

shellcheck mocks/*
if [ $? -ne 0 ]; then
    exit 1
fi

