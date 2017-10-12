# compile-beamer

[![Version][version-badge]][version-link]
[![License][license-badge]][license-link]
[![Nextflow version][nextflow-badge]][nextflow-link]
[![Travis status][travis-badge]][travis-link]
[![CircleCI status][circleci-badge]][circleci-link]
[![works on my machine][works-badge]][works-link]

[Beamer][beamer-link] compiler in [Nextflow][nextflow-link] using [XeLaTex][xetex-link].

## Options

### --tex
Compile the given tex file.

### --pictures
Specify in which directory are the pictures.
Default is: `pictures/`.

### --tag
Specify with tag to use for the docker container.
Default is current version.

### --help
You're reading it.

### --version
Displays version number.

## Usage with Docker [![Docker status][docker-badge]][docker-link]

```bash
nextflow run MaxUlysse/compile-beamer /
  -profile docker /
  --tex <file.tex>
```

## Docker container
Based on `debian:stretch-slim`.
Contain: `texlive-xetex`, `mtheme`, `python-pygments` (for `minted`) and `Fira fonts`.

## Usage with Singularity [![Singularity status][singularity-badge]][singularity-link]

```bash
nextflow run MaxUlysse/compile-beamer /
  -profile singularity /
  --tex <file.tex>
```

## Singularity container
Based on the Docker container

[beamer-link]: https://github.com/josephwright/beamer
[circleci-badge]: https://circleci.com/gh/MaxUlysse/compile-beamer.svg?style=shield
[circleci-link]: https://circleci.com/gh/MaxUlysse/compile-beamer
[docker-badge]: https://img.shields.io/docker/automated/maxulysse/compile-beamer.svg
[docker-link]: https://hub.docker.com/r/maxulysse/compile-beamer
[license-badge]: https://img.shields.io/github/license/MaxUlysse/compile-beamer.svg
[license-link]: https://github.com/MaxUlysse/compile-beamer/blob/master/LICENSE
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A50.25.0-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[singularity-badge]: https://img.shields.io/badge/singularity_hub-automated-blue.svg
[singularity-link]: https://singularity-hub.org/collections/170/
[travis-badge]: https://api.travis-ci.org/MaxUlysse/compile-beamer.svg
[travis-link]: https://travis-ci.org/MaxUlysse/compile-beamer
[version-badge]: https://img.shields.io/github/release/MaxUlysse/compile-beamer.svg
[version-link]: https://github.com/MaxUlysse/compile-beamer/releases/releases/latest
[works-badge]: https://img.shields.io/badge/works-on_my_machine-brightgreen.svg
[works-link]: https://github.com/nikku/works-on-my-machine
[xetex-link]: http://xetex.sourceforge.net/
