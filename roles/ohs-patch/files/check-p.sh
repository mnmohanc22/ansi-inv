#!/bin/bash

INPUT_FILE="servers.txt"
TIMEOUT=5

while IFS=: read -r HOST PORT
do
    [[ -z "$HOST" || -z "$PORT" ]] && continue

    echo "Checking $HOST:$PORT ..."

    OUTPUT=$(timeout $TIMEOUT telnet "$HOST" "$PORT" </dev/null 2>&1)

    if echo "$OUTPUT" | grep -q "Connected to"; then
        echo "SUCCESS - $HOST:$PORT is reachable"
    else
        echo "FAILED  - $HOST:$PORT is NOT reachable"
    fi

    echo "-----------------------------------"

done < "$INPUT_FILE"