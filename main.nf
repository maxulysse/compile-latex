#!/usr/bin/env nextflow

/*
================================================================================
=                     C  O  M  P  I  L  E  -  L  A  T  E  X                    =
================================================================================
  @Author
  Maxime Garcia <max.u.garcia@gmail.com> [@MaxUlysse]
--------------------------------------------------------------------------------
  @Homepage
  https://github.com/MaxUlysse/compile-latex
--------------------------------------------------------------------------------
  @Documentation
  https://github.com/MaxUlysse/compile-latex/blob/master/README.md
--------------------------------------------------------------------------------
  @Licence
  https://github.com/MaxUlysse/compile-latex/blob/master/LICENSE
--------------------------------------------------------------------------------
  Process overview
  - RunXelatex
      Run xelatex, optionally biber and xelatex and finally xelatex again
================================================================================
=                           C O N F I G U R A T I O N                          =
================================================================================
*/

if (params.help) exit 0, helpMessage()
if (!params.tex) exit 1, 'No tex file, see --help for more information'

biblio = file(params.biblio)
pictures = file(params.pictures)
tex = file(params.tex)

/*
================================================================================
=                                 P R O C E S S                                =
================================================================================
*/

startMessage()

process RunXelatex {
  tag {tex}

  publishDir params.outDir, mode: 'link'

  input:
    file biblio
    file pictures
    file tex

  output:
    file("*.pdf") into pdf

  script:
    xelatexScript = "xelatex -shell-escape ${tex}"
    biberScript = biblio.exists() ? "biber ${tex.baseName}.bcf ; ${xelatexScript}" : ""
    renameScript = params.outName == '' ? "" : "cp ${tex.baseName}.pdf ${params.outName}"

  """
  ${xelatexScript}
  ${biberScript}
  ${xelatexScript}
  ${renameScript}
  """
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
*/

def ascii_art() {
  println ""
  println "       _-´`-_"
  println "    _-´      `-_"
  println " _-´   T     X  `-_                             _ _          _       _"
  println "|`-_      E     _-´|                           (_) |        | |     | |"
  println "|__ `-_      _-´   |   ___ ___  _ __ ___  _ __  _| | ___    | | __ _| |_ _____  __"
  println "|  \\   `-__-´    | |  / __/ _ \\| '_ ` _ \\| '_ \\| | |/ _ \\___| |/ _` | __/ _ \\ \\/ /"
  println "|   \\ ____|   ,| | | | (_| (_) | | | | | | |_) | | |  __/___| | (_| | ||  __/>  <"
  println "|____/    | | || | |  \\___\\___/|_| |_| |_| .__/|_|_|\\___|   |_|\\__,_|\\__\\___/_/\\_\\"
  println "|     \\   | | |´   |                     | |"
  println " `-_   \\__| |   _-´                      |_|"
  println "    `-_   |  _-´"
  println "       `-_|-´"
  println ""
}

def compileLatexMessage() {
  // Display compile-latex message
  log.info "compile-latex ~ ${params.version} - " + this.grabRevision() + (workflow.commitId ? " [$workflow.commitId]" : "")
}

def grabRevision() {
  // Return the same string executed from github or not
  return workflow.revision ?: workflow.commitId ?: workflow.scriptId.substring(0,10)
}

def helpMessage() {
  // Display help message
  this.compileLatexMessage()
  log.info "    Usage:"
  log.info "      nextflow run MaxUlysse/compile-latex --tex <input.tex>"
  log.info "    --tex"
  log.info "      Compile the given tex file"
  log.info "    --biblio"
  log.info "      Specify the bibliography"
  log.info "      Default is: biblio.bib"
  log.info "    --pictures"
  log.info "      Specify in which directory are the pictures"
  log.info "      Default is: pictures/"
  log.info "    --tag"
  log.info "      Specify with tag to use for the docker container"
  log.info "    --outName"
  log.info "      Specify output name"
  log.info "    --outDir"
  log.info "      Specify output directory"
  log.info "    --help"
  log.info "      You're reading it"
}

def minimalInformationMessage() {
  // Minimal information message
  log.info "Command Line:" + workflow.commandLine
  log.info "Launch Dir  :" + workflow.launchDir
  log.info "Work Dir    :" + workflow.workDir
  log.info "Container   :" + workflow.container
  log.info "Tex file    :" + tex
  if (biblio.exists()) log.info "Bibliography:" + biblio
  if (pictures.exists()) log.info "Pictures in :" + pictures
}

def nextflowMessage() {
  // Nextflow message (version + build)
  log.info "N E X T F L O W  ~  version" + workflow.nextflow.version + " " + workflow.nextflow.build
}

def startMessage() {
  // Display start message
  this.ascii_art()
  this.compileLatexMessage()
  this.minimalInformationMessage()
}

workflow.onComplete {
  // Display end message
  this.nextflowMessage()
  this.compileLatexMessage()
  this.minimalInformationMessage()
  log.info "Completed at: " + workflow.complete
  log.info "Duration    : " + workflow.duration
  log.info "Success     : " + workflow.success
  log.info "Exit status : " + workflow.exitStatus
  log.info "Error report: " + (workflow.errorReport ?: '-')
}

workflow.onError {
  // Display error message
  this.nextflowMessage()
  this.compileLatexMessage()
  log.info "Workflow execution stopped with the following message: " + $workflow.errorMessage
}
