# compile-latex

[![Version][version-badge]][version-link]
[![License][license-badge]][license-link]
[![Nextflow needed][nextflow-badge]][nextflow-link]
[![Travis status][travis-badge]][travis-link]
[![works on my machine][works-badge]][works-link]
[![Docker status][docker-badge]][docker-link]

[LaTeX][latex-link] compiler in [Nextflow][nextflow-link] using [XeLaTex][xetex-link] within a Docker container. Made for compiling [Beamer][beamer-link] theme [Metropolis][metropolis-link], but works also with [moderncv][moderncv-link].

## Options

### --tex
Compile the given tex file.

### --biblio
Specify the `bib` file for the bibliography.
Default is: `biblio.bib`.

### --pictures
Specify path to pictures directory.
Default is: `pictures/`.

### --tag
Specify with tag to use for the docker container.
Default is current version.

### --help
You're reading it.

### --version
Displays version number.

## Usage
```bash
nextflow run MaxUlysse/compile-latex /
  --tex <file.tex>
```

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
[circleci-badge]: https://circleci.com/gh/MaxUlysse/compile-latex.svg?style=shield
[circleci-link]: https://circleci.com/gh/MaxUlysse/compile-latex
[docker-badge]: https://img.shields.io/docker/automated/maxulysse/compile-latex.svg
[docker-link]: https://hub.docker.com/r/maxulysse/compile-latex
[latex-link]: https://www.latex-project.org
[license-badge]: https://img.shields.io/github/license/MaxUlysse/compile-latex.svg
[license-link]: https://github.com/MaxUlysse/compile-latex/blob/master/LICENSE
[metropolis-link]: https://ctan.org/pkg/beamertheme-metropolis
[moderncv-link]: https://ctan.org/pkg/moderncv
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A50.25.0-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[travis-badge]: https://api.travis-ci.org/MaxUlysse/compile-latex.svg
[travis-link]: https://travis-ci.org/MaxUlysse/compile-latex
[version-badge]: https://img.shields.io/github/release/MaxUlysse/compile-latex.svg
[version-link]: https://github.com/MaxUlysse/compile-latex/releases/latest
[works-badge]: https://img.shields.io/badge/works-on_my_machine-brightgreen.svg
[works-link]: https://github.com/nikku/works-on-my-machine
[xetex-link]: http://xetex.sourceforge.net
