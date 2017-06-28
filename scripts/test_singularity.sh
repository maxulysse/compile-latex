#!/bin/bash

set -xeuo pipefail

rm -rf container/*
cd container
singularity pull shub://MaxUlysse/compile-beamer
mv *.img compile-beamer-1.5.img
cd ..

nextflow run . -profile singularity
