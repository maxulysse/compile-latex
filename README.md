# [![compile-beamer version][version-badge]][version-link] [![MIT License][license-badge]](LICENSE) [![Nextflow version][nextflow-badge]][nextflow-link] [![works on my machine][works-badge]][works-link] [![CircleCI status][circleci-badge]][circleci-link] [![Docker status][docker-badge]][docker-link]

Beamer compiler in Nextflow using XeLaTex. Beamer presentations can be easily compiled with different themes. A Docker container can be used, it's an Ubuntu 16.04 image containing texlive-xetex, and google fonts.

Usage with Docker:
    nextflow run MaxUlysse/compile-beamer -profile docker -with-docker --tex <file.tex> --theme <BTB || KI || SLL>
Usage without Docker:
    nextflow run MaxUlysse/compile-beamer --tex <file.tex> --theme <BTB || KI || SLL>

[version-badge]:	https://img.shields.io/badge/compile--beamer-v1.0-green.svg
[version-link]:     https://github.com/MaxUlysse/compile-beamer/releases/tag/v1.0
[license-badge]:	https://img.shields.io/badge/license-MIT-blue.svg
[works-badge]:		https://img.shields.io/badge/works_on-my_machine-blue.svg
[works-link]:		https://github.com/nikku/works-on-my-machine
[nextflow-badge]:	https://img.shields.io/badge/nextflow-%E2%89%A50.22.2-brightgreen.svg
[nextflow-link]:	https://nextflow.io/
[circleci-badge]:	https://circleci.com/gh/MaxUlysse/compile-beamer.svg?style=shield
[circleci-link]:	https://circleci.com/gh/MaxUlysse/compile-beamer
[docker-badge]:		https://img.shields.io/docker/automated/maxulysse/compile-beamer.svg
[docker-link]:		https://cloud.docker.com/app/maxulysse/repository/docker/maxulysse/compile-beamer