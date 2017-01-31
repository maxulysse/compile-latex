# compile-beamer [![compile-beamer version][version-badge]][version-link]

[![Nextflow version][nextflow-badge]][nextflow-link]
[![works on my machine][works-badge]][works-link]
[![CircleCI status][circleci-badge]][circleci-link]
[![Travis status][travis-badge]][travis-link]
[![Docker status][docker-badge]][docker-link]
[![Singularity status][singularity-badge]][singularity-link]

Beamer compiler in Nextflow using XeLaTex.

Beamer presentations can be easily compiled with different themes. A Docker container is provided. It's a `debian:8.6` image containing `texlive-xetex`, `python-pygments` (for `minted`) and `google fonts`.

## Usage with Docker

```bash
nextflow run MaxUlysse/compile-beamer /
-profile docker -with-docker /
--tex <file.tex> /
--theme <BTB||KI||SciLifeLab>
```

## Usage without Docker

```bash
nextflow run MaxUlysse/compile-beamer /
--tex <file.tex> /
--theme <BTB||KI||SciLifeLab>
```

[circleci-badge]: https://circleci.com/gh/MaxUlysse/compile-beamer.svg?style=shield
[circleci-link]: https://circleci.com/gh/MaxUlysse/compile-beamer
[docker-badge]: https://img.shields.io/docker/automated/maxulysse/compile-beamer.svg
[docker-link]: https://hub.docker.com/r/maxulysse/compile-beamer
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A50.22.2-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[singularity-badge]: https://img.shields.io/badge/singularity_hub-complete-blue.svg
[singularity-link]: https://singularity-hub.org/collections/46/
[travis-badge]: https://img.shields.io/travis/MaxUlysse/compile-beamer.svg
[travis-link]: https://travis-ci.org/MaxUlysse/compile-beamer
[version-badge]: https://img.shields.io/github/release/maxulysse/compile-beamer.svg
[version-link]: https://github.com/MaxUlysse/compile-beamer/releases/tag/1.2.1
[works-badge]: https://img.shields.io/badge/works-on_my_machine-blue.svg
[works-link]: https://github.com/nikku/works-on-my-machine
