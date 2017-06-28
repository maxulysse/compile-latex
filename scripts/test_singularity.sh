#!/bin/bash

set -xeuo pipefail

singularity pull --name container/compile-beamer-1.5.img shub://MaxUlysse/compile-beamer

nextflow run . -profile singularity
