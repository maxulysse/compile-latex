# maxulysse/compile-latex: Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased](https://github.com/maxulysse/compile-latex/compare/3.0.1...HEAD)

### Changed

- [#26](https://github.com/maxulysse/compile-latex/pull/26) - Switched to a simplified contributing workflow with PRs directly to `main` (no `dev` branch)
- [#27](https://github.com/maxulysse/compile-latex/pull/27) - Template update for nf-core/tools version 4.2.1
- [#27](https://github.com/maxulysse/compile-latex/pull/27) - Run `nf-core pipelines lint --release` only on release events, not on PRs to `main`

### Removed

- [#26](https://github.com/maxulysse/compile-latex/pull/26) - Removed `.github/workflows/branch.yml` (no longer needed with direct-to-main workflow)
- [#26](https://github.com/maxulysse/compile-latex/pull/26) - Removed singularity from nf-test CI
- [#26](https://github.com/maxulysse/compile-latex/pull/26) - Removed download pipeline test workflow

## v3.0.0 - [date]

Initial release of maxulysse/compile-latex, created with the [nf-core](https://nf-co.re/) template.

### `Added`

### `Fixed`

### `Dependencies`

### `Deprecated`
