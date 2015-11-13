#!/bin/bash

compare_values () {
    local hashed
    readonly hashed=$1
    local out_type
    readonly out_type=$2
    echo "Checking ${out_type}.."
    diff "orig_${hashed}_${out_type}.txt" "mock_${hashed}_${out_type}.txt"
    if [ $? -ne 0 ]; then
        echo "FAIL: ${out_type}s differ"
        outcome=1
    fi
}

check_outputs () {
    local command
    readonly command=( "$@" )
    local hashed
    readonly hashed=$(echo -n "${command[@]}" | md5sum | cut -d" " -f1)

    # shellcheck disable=SC2068
    ${command[@]} > "orig_${hashed}_stdout.txt" 2> "orig_${hashed}_stderr.txt"
    echo "$?" > "orig_${hashed}_exitcode.txt"

    # shellcheck disable=SC2068
    ./mockmaker ${command[@]} > /dev/null 2>&1

    cd mocks || exit 1
    # shellcheck disable=SC2086
    ./${command[*]} > "../mock_${hashed}_stdout.txt" 2> "../mock_${hashed}_stderr.txt"
    echo "$?" > "../mock_${hashed}_exitcode.txt"
    cd ..

    local outcome=0

    compare_values ${hashed} "stdout"
    compare_values ${hashed} "stderr"
    compare_values ${hashed} "exitcode"

    rm "orig_${hashed}_stdout.txt"
    rm "orig_${hashed}_stderr.txt"
    rm "orig_${hashed}_exitcode.txt"
    rm "mock_${hashed}_stdout.txt"
    rm "mock_${hashed}_stderr.txt"
    rm "mock_${hashed}_exitcode.txt"

    return $outcome
}

