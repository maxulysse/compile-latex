#!/bin/bash
INSTALL=false
PROFILE="docker"

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -i|--install)
    INSTALL=true
    ;;
    -p|--profile)
    PROFILE="$2"
    shift
    ;;
    *) # unknown option
    ;;
  esac
  shift
done

# Install Singularity
if [[ "$PROFILE" == singularity ]] && [[ "$INSTALL" == true ]]
then
  ./scripts/install.sh -t singularity
fi

# Run test
nextflow run . -profile $PROFILE
