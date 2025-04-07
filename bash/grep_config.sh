#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <config_file>"
    exit 1
fi

config=$1

if [ ! -f "$config" ]; then
    echo "Error: File $config does not exist."
    exit 1
fi

grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$config"
