#!/bin/bash
PROFILE="docker"

while [[ $# -gt 0 ]]
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

# Run test
nextflow run . -profile $PROFILE
