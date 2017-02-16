# compile-beamer
[![compile-beamer version][version-badge]][version-link]
[![Licence][licence-badge]][licence-link]
[![Nextflow version][nextflow-badge]][nextflow-link]
[![Docker status][docker-badge]][docker-link]
[![CircleCI status][circleci-badge]][circleci-link]
[![Travis status][travis-badge]][travis-link]
<!-- [![works on my machine][works-badge]][works-link] -->
<!-- [![Singularity status][singularity-badge]][singularity-link] -->

Beamer compiler in Nextflow using XeLaTex.

Beamer presentations can be easily compiled with different themes. A Docker container is provided. It's a `debian:8.6` image containing `texlive-xetex`, `mtheme`, `python-pygments` (for `minted`) and `Fira fonts`. A singularity image based on the docker image can be built using `singularity.sh`.

## Usage with Docker

```bash
nextflow run MaxUlysse/compile-beamer /
-profile docker /
--tex <file.tex>
```

## Usage with Singularity

```bash
nextflow run MaxUlysse/compile-beamer /
-profile singularity /
--tex <file.tex>
```

## Usage without Containers

```bash
nextflow run MaxUlysse/compile-beamer /
--tex <file.tex>
```

[circleci-badge]: https://circleci.com/gh/MaxUlysse/compile-beamer.svg?style=shield
[circleci-link]: https://circleci.com/gh/MaxUlysse/compile-beamer
[docker-badge]: https://img.shields.io/docker/automated/maxulysse/compile-beamer.svg
[docker-link]: https://hub.docker.com/r/maxulysse/compile-beamer
[licence-badge]: https://img.shields.io/github/license/MaxUlysse/compile-beamer.svg
[licence-link]: https://github.com/MaxUlysse/compile-beamer/blob/master/LICENSE
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A50.22.2-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[singularity-badge]: https://img.shields.io/badge/singularity_hub-complete-blue.svg
[singularity-link]: https://singularity-hub.org/collections/46/
[travis-badge]: https://img.shields.io/travis/MaxUlysse/compile-beamer.svg
[travis-link]: https://travis-ci.org/MaxUlysse/compile-beamer
[version-badge]: https://img.shields.io/github/release/maxulysse/compile-beamer.svg
[version-link]: https://github.com/MaxUlysse/compile-beamer/releases/releases/latest
[works-badge]: https://img.shields.io/badge/works-on_my_machine-blue.svg
[works-link]: https://github.com/nikku/works-on-my-machine
