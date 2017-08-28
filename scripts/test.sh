#!/bin/bash
set -xeuo pipefail

PROFILE="docker"

while [[ $# -gt 1 ]]
do
    key="$1"
    case $key in
        -p|--profile)
        PROFILE="$2"
        shift
        ;;
        *) # unknown option
        ;;
    esac
    shift
done

nextflow run . -profile $PROFILE
