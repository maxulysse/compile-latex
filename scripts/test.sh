#!/bin/bash
set -xeuo pipefail

TAG=2.0
TEX=sample.tex

while [[ $# -gt 0 ]]
do
  key=$1
  case $key in
    --tag)
    TAG=$2
    shift # past argument
    shift # past value
    ;;
    --tex)
    TEX=$2
    shift # past argument
    shift # past value
    ;;
    *) # unknown option
    shift # past argument
    ;;
  esac
done

# Run test
nextflow run . --tag ${TAG} --tex ${TEX}
