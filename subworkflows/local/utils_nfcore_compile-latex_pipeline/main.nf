//
// Subworkflow with functionality specific to the maxulysse/compile-latex pipeline
//

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT FUNCTIONS / MODULES / SUBWORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { checkConfigProvided  } from 'plugin/nf-core-utils'
include { checkProfileProvided } from 'plugin/nf-core-utils'
include { completionSummary    } from 'plugin/nf-core-utils'
include { dumpParametersToJSON } from 'plugin/nf-core-utils'
include { getWorkflowVersion   } from 'plugin/nf-core-utils'

include { paramsHelp           } from 'plugin/nf-schema'
include { paramsSummaryLog     } from 'plugin/nf-schema'
include { validateParameters   } from 'plugin/nf-schema'

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    SUBWORKFLOW TO INITIALISE PIPELINE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow PIPELINE_INITIALISATION {
    take:
    version // boolean: Display version and exit
    validate_params // boolean: Boolean whether to validate parameters against the schema at runtime
    nextflow_cli_args //   array: List of positional nextflow CLI args
    outdir //  string: The output directory where the results will be saved
    _input //  string: Path to input samplesheet
    help // boolean: Display help message and exit
    help_full // boolean: Show the full help message
    show_hidden // boolean: Show hidden parameters in the help message

    main:
    // Print workflow version and exit on --version
    if (version) {
        log.info("${workflow.manifest.name} ${getWorkflowVersion()}")
        System.exit(0)
    }

    // Dump pipeline parameters to a JSON file
    if (outdir) {
        dumpParametersToJSON(outdir, params)
    }

    checkConfigProvided()

    // Validate parameters and generate parameter summary to stdout
    //
    before_text = """
-\033[2m----------------------------------------------------\033[0m-

       _.-´`-._                                 _ _          _       _
   _.-´  T   X `-._                            (_) |        | |     | |
  |`-._    E   _.-´|   ___ ___  _ __ ___  _ __  _| | ___    | | __ _| |_ _____  __
  | -. `-.__.-´  . |  / __/ _ \\| '_ ` _ \\| '_ \\| | |/ _ \\___| |/ _` | __/ _ \\ \\/ /
  |   \\.-- | . | | | | (_| (_) | | | | | | |_) | | |  __/___| | (_| | ||  __/>  <
  | --´\\   | | | | |  \\___\\___/|_| |_| |_| .__/|_|_|\\___|   |_|\\__,_|\\__\\___/_/\\_\\
   `-._ `- | | '_.-´                     | |
       `-._|_.-´                         |_|

  maxulysse/compile-latex ~ ${workflow.manifest.version}
-\033[2m----------------------------------------------------\033[0m-
"""
    after_text = """${workflow.manifest.doi ? "\n* The pipeline\n" : ""}${workflow.manifest.doi.tokenize(",").collect { doi -> "    https://doi.org/${doi.trim().replace('https://doi.org/', '')}" }.join("\n")}${workflow.manifest.doi ? "\n" : ""}
* The nf-core framework
    https://doi.org/10.1038/s41587-020-0439-x
"""
    command = "nextflow run ${workflow.manifest.name} -profile <docker/singularity/.../institute> --tex file.tex --outdir <OUTDIR>"

    if (help || help_full) {
        help_options = [
            beforeText: before_text,
            afterText: after_text,
            command: command,
            showHidden: show_hidden,
            fullHelp: help_full,
        ]
        if (null) {
            help_options << [parametersSchema: null]
        }
        log.info(
            paramsHelp(
                help_options,
                params.help instanceof String && params.help != "true" ? params.help : "",
            )
        )
        exit(0)
    }

    checkProfileProvided(nextflow_cli_args)

    //
    // Print parameter summary to stdout. This will display the parameters
    // that differ from the default given in the JSON schema
    //

    summary_options = [:]
    if (null) {
        summary_options << [parametersSchema: null]
    }
    log.info(before_text)
    log.info(paramsSummaryLog(summary_options, workflow))
    log.info(after_text)

    //
    // Validate the parameters using nextflow_schema.json or the schema
    // given via the validation.parametersSchema configuration option
    //
    if (validate_params) {
        validateOptions = [:]
        if (null) {
            validateOptions << [parametersSchema: null]
        }
        validateParameters(validateOptions)
    }
}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    SUBWORKFLOW FOR PIPELINE COMPLETION
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

workflow PIPELINE_COMPLETION {
    take:
    monochrome_logs // boolean: Disable ANSI colour codes in log output

    main:
    // Completion summary
    workflow.onComplete {
        completionSummary(monochrome_logs)
    }

    workflow.onError {
        log.error("Pipeline failed. Please refer to troubleshooting docs: https://nf-co.re/docs/usage/troubleshooting")
    }
}
