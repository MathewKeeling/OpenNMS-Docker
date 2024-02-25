# Alphabetize Services

**Author:** Mathew Keeling \

**Date:** 6 February 2024

## Overview

This script currently causes OpenNMS to crash. Need to sort it out still.

Probably worth a rewrite using Perl instead of sed.

```sh
#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [INPUT_FILE] [OUTPUT_FILE]"
    exit 1
fi

INPUT_FILE=$1
OUTPUT_FILE=$2

# Extract the lines containing 'monitor service' and sort them
sorted_lines=$(grep '<monitor service' "$INPUT_FILE" | sort -t '"' -k2,2)

# Write the lines before '</poller-configuration>' to a temporary file, excluding the original unsorted 'monitor service' lines
sed '/<monitor service/ d; /<\/poller-configuration>/Q' "$INPUT_FILE" > tmpfile

# Append the sorted lines to the temporary file
echo "$sorted_lines" >> tmpfile

# Append the remaining lines to the temporary file, excluding the original unsorted 'monitor service' lines
sed -n '/<\/poller-configuration>/,$p' "$INPUT_FILE" | sed '/<monitor service/ d' >> tmpfile

# Move the temporary file to the output file
mv tmpfile "$OUTPUT_FILE"
```