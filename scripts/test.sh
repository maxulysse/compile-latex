#!/bin/bash
INSTALL=false
PROFILE="docker"

while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -i|--install)
    INSTALL=true
    shift
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
if [[ "$INSTALL" == true ]] && [[ "$PROFILE" == "singularity" ]]
then
  ./scripts/install.sh --tool singularity
fi

# Run test
nextflow run . -profile $PROFILE
