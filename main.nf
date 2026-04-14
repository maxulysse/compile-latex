#!/usr/bin/env nextflow
/*
================================================================================
=                     C  O  M  P  I  L  E  -  L  A  T  E  X                    =
================================================================================
    @Author
    Maxime Garcia <max.u.garcia@gmail.com> [@maxulysse]
--------------------------------------------------------------------------------
    @Homepage
    https://github.com/maxulysse/compile-latex
--------------------------------------------------------------------------------
    @Documentation
    https://github.com/maxulysse/compile-latex/blob/main/README.md
--------------------------------------------------------------------------------
    @Licence
    https://github.com/maxulysse/compile-latex/blob/main/LICENSE
--------------------------------------------------------------------------------
    Process overview
    - XELATEX
        Run xelatex, optionally biber and xelatex and finally xelatex again
*/

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT FUNCTIONS / MODULES / SUBWORKFLOWS / WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { XELATEX                 } from './modules/local/xelatex'
include { PIPELINE_INITIALISATION } from './subworkflows/local/utils_nfcore_compile-latex_pipeline'
include { PIPELINE_COMPLETION     } from './subworkflows/local/utils_nfcore_compile-latex_pipeline'


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow {

    main:
    // SUBWORKFLOW: Run initialisation tasks
    PIPELINE_INITIALISATION(
        params.version,
        params.validate_params,
        args,
        params.outdir,
        params.input,
        params.help,
        params.help_full,
        params.show_hidden,
    )

    // WORKFLOW: Run main workflow
    XELATEX(
        channel.fromPath(params.input, checkIfExists: true),
        channel.fromPath(params.biblio, checkIfExists: true),
        channel.fromPath(params.pictures, checkIfExists: true),
    )

    // SUBWORKFLOW: Run completion tasks
    PIPELINE_COMPLETION(params.monochrome_logs)

    publish:
    pdf = XELATEX.out.pdf
}

output {
    pdf {
        path { file ->
            file >> (params.outname ? "${params.outname}" : "${file.name}")
        }
    }
}
