<h1>
  <picture>
    <img alt="compile-latex" src="assets/pictures/compile-latex_logo.png">
  </picture>
</h1>

# maxulysse/compile-latex

[![Open in GitHub Codespaces](https://img.shields.io/badge/Open_In_GitHub_Codespaces-black?labelColor=grey&logo=github)](https://github.com/codespaces/new/maxulysse/compile-latex)
[![GitHub Actions CI Status](https://github.com/maxulysse/compile-latex/actions/workflows/nf-test.yml/badge.svg)](https://github.com/maxulysse/compile-latex/actions/workflows/nf-test.yml)
[![GitHub Actions Linting Status](https://github.com/maxulysse/compile-latex/actions/workflows/linting.yml/badge.svg)](https://github.com/maxulysse/compile-latex/actions/workflows/linting.yml)[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.1155669-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.1155669)
[![nf-test](https://img.shields.io/badge/unit_tests-nf--test-337ab7.svg)](https://www.nf-test.com)

[![Nextflow](https://img.shields.io/badge/version-%E2%89%A525.10.4-green?style=flat&logo=nextflow&logoColor=white&color=%230DC09D&link=https%3A%2F%2Fnextflow.io)](https://www.nextflow.io/)
[![nf-core template version](https://img.shields.io/badge/nf--core_template-3.5.2-green?style=flat&logo=nfcore&logoColor=white&color=%2324B064&link=https%3A%2F%2Fnf-co.re)](https://github.com/nf-core/tools/releases/tag/3.5.2)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![Launch on Seqera Platform](https://img.shields.io/badge/Launch%20%F0%9F%9A%80-Seqera%20Platform-%234256e7)](https://cloud.seqera.io/launch?pipeline=https://github.com/maxulysse/compile-latex)

## Introduction

**maxulysse/compile-latex** is a lightweight Nextflow pipeline that compiles LaTeX documents into PDF using XeLaTeX.

## Usage

> [!NOTE]
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. Make sure to [test your setup](https://nf-co.re/docs/usage/introduction#how-to-run-a-pipeline) with `-profile test` before running the workflow on actual data.

Provide the input tex file with the `--input` parameter.

Run the pipeline using:

```bash
nextflow run maxulysse/compile-latex \
   -profile <docker/singularity/.../institute> \
   --input file.tex \
   --outdir <OUTDIR>
```

> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_; see [docs](https://nf-co.re/docs/usage/getting_started/configuration#custom-configuration-files).

## Main parameters

- `--input`: Path to the input `.tex` file.
- `--outdir`: Output directory for results and reports.
- `--outname`: Optional output PDF filename.
- `--biblio`: Path to bibliography file (default: `assets/biblio.bib`).
- `--pictures`: Path to image folder (default: `assets/pictures`).

## Output

After completion, the output directory contains:

- Compiled PDF file (`<FILE>.pdf` or `--outname` if provided)
- `pipeline_info/` with execution reports (`execution_report`, `execution_timeline`, `execution_trace`, `pipeline_dag`) and run parameters (`params.json`)

Example: [example.pdf](https://github.com/maxulysse/compile-latex/blob/main/example.pdf)

## Credits

maxulysse/compile-latex was originally written by Maxime U Garcia for his own usage.
And testing around things with Nextflow and nf-core.

## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

## Citations

If you use maxulysse/compile-latex for your analysis, please cite it using the following doi: [10.5281/zenodo.1155669](https://doi.org/10.5281/zenodo.1155669)

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
