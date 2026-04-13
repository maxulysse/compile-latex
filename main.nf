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
    - RUNXELATEX
        Run xelatex, optionally biber and xelatex and finally xelatex again
*/

process RUNXELATEX {
    tag tex

    container 'texlive/texlive:latest'

    input:
    path biblio
    path pictures
    path tex

    output:
    path "*.pdf", emit: pdf

    script:
    notes = params.notes ? "\"\\PassOptionsToClass{notes}{beamer}\\input{${tex}}\"" : ""
    notes = params.notes_only ? notes : "\"\\PassOptionsToClass{notes=only}{beamer}\\input{${tex}}\""
    xelatexScript = notes ? "xelatex -shell-escape ${tex}" : "xelatex -shell-escape ${notes}"
    biberScript = biblio.exists() ? "biber ${tex.baseName}.bcf ; ${xelatexScript}" : ""

    """
    ${xelatexScript}
    ${biberScript}
    ${xelatexScript}
    """
}

workflow {

    main:
    if (params.help) {
        log.info(helpmessage())
        exit(0)
    }
    if (!params.tex) {
        log.error('No tex file, see --help for more information')
        exit(1)
    }

    // Display start message
    compilelatex_ascii()
    minimalInformationMessage()

    // Create input channels
    biblio_ch = channel.fromPath(params.biblio)
    pictures_ch = channel.fromPath(params.pictures)
    tex_ch = channel.fromPath(params.tex)

    // Run the main process
    RUNXELATEX(biblio_ch, pictures_ch, tex_ch)

    publish:
    pdf = RUNXELATEX.out.pdf
}

output {
    pdf {
        path { file ->
            file >> (params.outname ? "${params.outname}" : "${file.name}")
        }
    }
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
*/

def compilelatex_ascii() {
    println("")
    println("     _.-´`-._                                 _ _          _       _")
    println(" _.-´  T   X `-._                            (_) |        | |     | |")
    println("|`-._    E   _.-´|   ___ ___  _ __ ___  _ __  _| | ___    | | __ _| |_ _____  __")
    println("| -. `-.__.-´  . |  / __/ _ \\| '_ ` _ \\| '_ \\| | |/ _ \\___| |/ _` | __/ _ \\ \\/ /")
    println("|   \\.-- | . | | | | (_| (_) | | | | | | |_) | | |  __/___| | (_| | ||  __/>  <")
    println("| --´\\   | | | | |  \\___\\___/|_| |_| |_| .__/|_|_|\\___|   |_|\\__,_|\\__\\___/_/\\_\\")
    println(" `-._ `- | | '_.-´                     | |")
    println("     `-._|_.-´                         |_|")
    println("")
    println("compile-latex ~ ${workflow.manifest.version}")
}

def helpmessage() {
    // Display help message
    log.info("    Usage:")
    log.info("      nextflow run maxulysse/compile-latex --tex <input.tex>")
    log.info("    --tex")
    log.info("      Compile the given tex file")
    log.info("    --biblio")
    log.info("      Specify the bibliography")
    log.info("      Default: biblio.bib")
    log.info("    --notes")
    log.info("      Generate notes with presentation")
    log.info("    --pictures")
    log.info("      Specify in which directory are the pictures")
    log.info("      Default: pictures/")
    log.info("    --outname")
    log.info("      Specify output name")
    log.info("    --outdir")
    log.info("      Specify output directory")
    log.info("    --help")
    log.info("      You're reading it")
}

def minimalInformationMessage() {
    // Minimal information message
    log.info("Command Line: " + workflow.commandLine)
    log.info("Launch Dir  : " + workflow.launchDir)
    log.info("Work Dir    : " + workflow.workDir)
    log.info("Tex file(s) : " + params.tex)
    if (file(params.biblio).exists()) {
        log.info("Bibliography: " + params.biblio)
    }
    if (file(params.pictures).exists()) {
        log.info("Pictures in : " + params.pictures)
    }
}
