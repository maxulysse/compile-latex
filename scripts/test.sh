#!/bin/bash
set -xeuo pipefail

PROFILE=docker
TAG=1.7.1
TEX=sample.tex

while [[ $# -gt 0 ]]
do
  key=$1
  case $key in
    -p|--profile)
    PROFILE=$2
    shift # past argument
    shift # past value
    ;;
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
nextflow run . -profile ${PROFILE} --tag ${tag} --tex ${TEX}
