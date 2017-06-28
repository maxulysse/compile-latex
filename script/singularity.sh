#!/bin/bash

sudo singularity create compile-beamer-1.5.img
sudo singularity import compile-beamer-1.5.img docker://maxulysse/compile-beamer:1.5
