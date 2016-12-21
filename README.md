# compile-beamer

[![compile-beamer version][version-badge]][version-link] [![MIT License][license-badge]][license-link] [![Nextflow version][nextflow-badge]][nextflow-link] [![works on my machine][works-badge]][works-link] [![CircleCI status][circleci-badge]][circleci-link] [![Travis status][travis-badge]][travis-link] [![Docker status][docker-badge]][docker-link]

Beamer compiler in Nextflow using XeLaTex.
Beamer presentations can be easily compiled with different themes.
A Docker container is provided.
It's an Ubuntu 16.04 image containing texlive-xetex, python-pygments (for minted) and google fonts.

## Usage with Docker:
```bash
nextflow run MaxUlysse/compile-beamer /
-profile docker -with-docker /
--tex <file.tex> /
--theme <BTB||KI||SciLifeLab>
```

## Usage without Docker:
```bash
nextflow run MaxUlysse/compile-beamer /
--tex <file.tex> /
--theme <BTB||KI||SciLifeLab>
```

[version-badge]:    https://img.shields.io/badge/compile--beamer-v1.1.3-green.svg
[version-link]:     https://github.com/MaxUlysse/compile-beamer/releases/tag/v1.1.3
[license-badge]:    https://img.shields.io/badge/license-MIT-blue.svg
[license-link]:     https://github.com/MaxUlysse/compile-beamer/blob/master/LICENSE
[works-badge]:      https://img.shields.io/badge/works-on_my_machine-blue.svg
[works-link]:       https://github.com/nikku/works-on-my-machine
[nextflow-badge]:   https://img.shields.io/badge/nextflow-%E2%89%A50.22.2-brightgreen.svg
[nextflow-link]:    https://www.nextflow.io/
[circleci-badge]:   https://circleci.com/gh/MaxUlysse/compile-beamer.svg?style=shield
[circleci-link]:    https://circleci.com/gh/MaxUlysse/compile-beamer
[travis-badge]:     https://img.shields.io/travis/MaxUlysse/compile-beamer.svg
[travis-link]:      https://travis-ci.org/MaxUlysse/compile-beamer
[docker-badge]:     https://img.shields.io/docker/automated/maxulysse/compile-beamer.svg
[docker-link]:      https://hub.docker.com/r/maxulysse/compile-beamer
