# [![compile-latex](https://raw.githubusercontent.com/MaxUlysse/compile-latex/master/pictures/compile-latex_logo.png "compile-latex")](https://github.com/MaxUlysse/compile-latex/) compile-latex

[![Version][version-badge]][version-link]
[![License][license-badge]][license-link]
[![Nextflow needed][nextflow-badge]][nextflow-link]
[![Travis status][travis-badge]][travis-link]
[![Docker status][docker-badge]][docker-link]
[![DOI][zenodo-badge]][zenodo-link]

[LaTeX][latex-link] compiler in [Nextflow][nextflow-link] using [XeLaTex][xetex-link] within a Docker container. Made for compiling [Beamer][beamer-link] theme [Metropolis][metropolis-link], but works also with [moderncv][moderncv-link].

## Usage
```bash
nextflow run MaxUlysse/compile-latex /
  --tex <file.tex> /
  [--biblio <biblio.bib>] /
  [--notes|--notesOnly] /
  [--outDir </path>] /
  [--outName <file.pdf>] /
  [--pictures </path/folder>] /
  [--tag <tag>]
```

## Options

### --tex
Compile the given tex file

### --biblio
Specify the bibliography

Default: `biblio.bib`

### --notes
Generate notes with presentation

### --notesOnly
Generate only the notes

### --pictures
Specify in which directory are the pictures

Default: `pictures/`

### --outName
Specify output name

### --outDir
Specify output directory

### --tag
Specify with tag to use for the docker container

### --help
You're reading it

## Result
- [sample.pdf](https://github.com/MaxUlysse/compile-latex/blob/master/sample.pdf)
- [Presentations](https://github.com/MaxUlysse/Presentations)
- [CV](https://github.com/MaxUlysse/myCV)

## Docker container
Based on `debian:stretch-slim` contain:
- Fonts and LaTeX utilities for themes:
  - [`metropolis`][metropolis-link]
  - [`moderncv`][moderncv-link]

[beamer-link]: https://github.com/josephwright/beamer
[docker-badge]: https://img.shields.io/docker/automated/maxulysse/compile-latex.svg
[docker-link]: https://hub.docker.com/r/maxulysse/compile-latex
[latex-link]: https://www.latex-project.org
[license-badge]: https://img.shields.io/github/license/MaxUlysse/compile-latex.svg
[license-link]: https://github.com/MaxUlysse/compile-latex/blob/master/LICENSE
[metropolis-link]: https://ctan.org/pkg/beamertheme-metropolis
[moderncv-link]: https://ctan.org/pkg/moderncv
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A518.10.1-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[travis-badge]: https://api.travis-ci.org/MaxUlysse/compile-latex.svg
[travis-link]: https://travis-ci.org/MaxUlysse/compile-latex
[version-badge]: https://img.shields.io/github/release/MaxUlysse/compile-latex.svg
[version-link]: https://github.com/MaxUlysse/compile-latex/releases/latest
[xetex-link]: http://xetex.sourceforge.net
[zenodo-badge]: https://zenodo.org/badge/70491982.svg
[zenodo-link]: https://zenodo.org/badge/latestdoi/70491982
