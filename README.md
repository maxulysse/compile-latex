# compile-beamer

[![Version][version-badge]][version-link] [![Licence][licence-badge]][licence-link] [![Nextflow version][nextflow-badge]][nextflow-link] [![CircleCI status][circleci-badge]][circleci-link] [![Travis status][travis-badge]][travis-link] [![works on my machine][works-badge]][works-link]

Beamer compiler in Nextflow using XeLaTex.

Beamer presentations can be easily compiled with different themes. A Docker container is provided. It's a `debian:8.6` image containing `texlive-xetex`, `mtheme`, `python-pygments` (for `minted`) and `Fira fonts`. A Singularity container based on the Docker container is also available.

## Usage with Docker [![Docker status][docker-badge]][docker-link]

```bash
nextflow run MaxUlysse/compile-beamer /
-profile docker /
--tex <file.tex>
```

## Usage with Singularity [![Singularity status][singularity-badge]][singularity-link]

You need first to download the Singularity container, and specify the path to it (either in the file `conf/singularity.config`, or in command line with parameter `-with-singularity [singularity image file]`) Or you can use the script `scripts/test_singularity.sh` to download and test the container, and then use it for your own project. (this way, tht path to the container is already in the file `conf/singularity.config`)

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
[nextflow-badge]: https://img.shields.io/badge/nextflow-%E2%89%A50.25.0-brightgreen.svg
[nextflow-link]: https://www.nextflow.io/
[singularity-badge]: https://img.shields.io/badge/singularity_hub-automated-blue.svg
[singularity-link]: https://singularity-hub.org/collections/72/
[travis-badge]: https://api.travis-ci.org/MaxUlysse/compile-beamer.svg
[travis-link]: https://travis-ci.org/MaxUlysse/compile-beamer
[version-badge]: https://img.shields.io/github/release/MaxUlysse/compile-beamer.svg
[version-link]: https://github.com/MaxUlysse/compile-beamer/releases/releases/latest
[works-badge]: https://img.shields.io/badge/works-on_my_machine-brightgreen.svg
[works-link]: https://github.com/nikku/works-on-my-machine
