#!/bin/bash

cd ..
shellcheck ./mockmaker
cd - || exit 64
