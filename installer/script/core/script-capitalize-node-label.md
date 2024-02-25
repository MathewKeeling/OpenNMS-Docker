# OpenNMS-Docker

**Author:** Mathew Keeling \

**Date:** 6 February 2024

## Script
```sh
#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [INPUT_FILE] [OUTPUT_FILE] [upper|lower]"
    exit 1
fi

INPUT_FILE=$1
OUTPUT_FILE=$2
MODE=$3

if [ "$MODE" == "upper" ]; then
    sed 's/node-label="\([^"]*\)"/node-label="\U\1"/g' "$INPUT_FILE" > "$OUTPUT_FILE"
elif [ "$MODE" == "lower" ]; then
    sed 's/node-label="\([^"]*\)"/node-label="\L\1"/g' "$INPUT_FILE" > "$OUTPUT_FILE"
else
    echo "Invalid mode. Please specify either 'upper' or 'lower'."
    exit 1
fi
```