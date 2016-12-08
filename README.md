# [![Version][version-badge]][version-link] [![Works][works-badge]][works-link] [![MIT License][license-badge]](LICENSE) [![CircleCI][circleci-badge]][circleci-link] [![Docker][docker-badge]][docker-link]

Beamer compiler in Nextflow using XeLaTex. Beamer presentations can be easily compiled with different themes. A Docker container can be used, it's an Ubuntu 16.04 image containing texlive-xetex, and google fonts.

Usage with Docker:
    nextflow run MaxUlysse/compile-beamer -profile docker -with-docker --tex <file.tex> --theme <BTB || KI || SLL>
Usage without Docker:
    nextflow run MaxUlysse/compile-beamer --tex <file.tex> --theme <BTB || KI || SLL>

[version-badge]:	https://img.shields.io/badge/compile--beamer-v1.0-green.svg
[version-link]:		https://github.com/MaxUlysse/compile-beamer
[works-badge]:		https://img.shields.io/badge/works_on-my_machine-blue.svg
[works-link]:		https://github.com/nikku/works-on-my-machine
[license-badge]:	https://img.shields.io/badge/license-MIT-blue.svg
[docker-badge]:		https://img.shields.io/docker/automated/maxulysse/compile-beamer.svg
[docker-link]:		http://docker.io/
[circleci-badge]:	https://img.shields.io/circleci/project/github/MaxUlysse/compile-beamer.svg
[circleci-link]:	https://circleci.com/gh/MaxUlysse/compile-beamer