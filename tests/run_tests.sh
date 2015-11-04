#!/bin/bash

outcome=0

for f in test_*.sh; do
    echo "Running ${f} test suite"
    ./${f}
    if [ $? -ne 0 ]; then
        echo "ERROR: Test failed: ${f}" >&2
        let outcome+=1
    fi
    echo ""
done

exit $outcome
