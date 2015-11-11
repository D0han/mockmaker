#!/bin/bash

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

    echo "Checking stdout.."
    diff "orig_${hashed}_stdout.txt" "mock_${hashed}_stdout.txt"
    if [ $? -ne 0 ]; then
        echo "FAIL: stdouts differ"
        outcome=1
    fi

    echo "Checking stderr.."
    diff "orig_${hashed}_stderr.txt" "mock_${hashed}_stderr.txt"
    if [ $? -ne 0 ]; then
        echo "FAIL: stderrs differ"
        outcome=1
    fi

    echo "Checking exit code.."
    diff "orig_${hashed}_exitcode.txt" "mock_${hashed}_exitcode.txt"
    if [ $? -ne 0 ]; then
        echo "FAIL: exitcodes differ"
        outcome=1
    fi

    rm "orig_${hashed}_stdout.txt"
    rm "orig_${hashed}_stderr.txt"
    rm "orig_${hashed}_exitcode.txt"
    rm "mock_${hashed}_stdout.txt"
    rm "mock_${hashed}_stderr.txt"
    rm "mock_${hashed}_exitcode.txt"

    return $outcome
}

