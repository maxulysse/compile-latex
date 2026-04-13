# [![compile-latex](https://raw.githubusercontent.com/maxulysse/compile-latex/main/pictures/compile-latex_logo.png "compile-latex")](https://github.com/maxulysse/compile-latex/) compile-latex

[![Version](https://img.shields.io/github/release/maxulysse/compile-latex.svg)](https://github.com/maxulysse/compile-latex/releases/latest)
[![License](https://img.shields.io/github/license/maxulysse/compile-latex.svg)](https://github.com/maxulysse/compile-latex/blob/main/LICENSE)
[![Nextflow needed](https://img.shields.io/badge/nextflow-%E2%89%A525.10.2-brightgreen.svg)](https://nextflow.io/)
[![DOI](https://zenodo.org/badge/70491982.svg)](https://zenodo.org/badge/latestdoi/70491982)

[LaTeX](https://www.latex-project.org) compiler in [Nextflow](https://nextflow.io/) using [XeLaTex](http://xetex.sourceforge.net) within a Docker container.
Made for compiling [Beamer](https://github.com/josephwright/beamer) theme [Metropolis](https://ctan.org/pkg/beamertheme-metropolis), but works also with [moderncv](https://ctan.org/pkg/moderncv).

## Usage

```console
nextflow run maxulysse/compile-latex /
  --tex <file.tex> /
  [--outdir </path>] /
  [--biblio <biblio.bib>] /
  [--outname <file.pdf>] /
  [--pictures </path/folder>] /
  [--tag <tag>]
```

## Options

### --tex

Compile the given tex file

### --biblio

Specify the bibliography

Default: `biblio.bib`

### --pictures

Specify in which directory are the pictures

Default: `pictures/`

### --outname

Specify output name

### --outdir

Specify output directory

### --tag

Specify with tag to use for the docker container

### --help

You're reading it

## Result

- [sample.pdf](https://github.com/maxulysse/compile-latex/blob/main/sample.pdf)
- [Presentations](https://github.com/maxulysse/Presentations)
- [CV](https://github.com/maxulysse/myCV)

## Docker container

Based on `debian:stretch-slim` contain:

- Fonts and LaTeX utilities for themes:
  - [`metropolis`](https://ctan.org/pkg/beamertheme-metropolis)
  - [`moderncv`](https://ctan.org/pkg/moderncv)
