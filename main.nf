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
 - RunXelatex - Run xelatex twice on given tex file
================================================================================
=                           C O N F I G U R A T I O N                          =
================================================================================
*/

if (!nextflow.version.matches('>= 0.25.3')) exit 1, "Nextflow version 0.25.3 or greater is needed to run this workflow"

version = '2.0.2'

params.help = false
params.version = false
params.outDir = baseDir
params.name = ''

if (params.help) exit 0, helpMessage()
if (params.version) exit 0, versionMessage()

params.biblio = 'biblio.bib'
biblio = file(params.biblio)

params.pictures = 'pictures'
pictures = file(params.pictures)
if (!params.tex) exit 1, 'No tex file, see --help for more information'
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
    biblioScript = biblio.exists() ? "biber ${tex.baseName}.bcf ; ${xelatexScript}" : ""
    nameScript = params.name == '' ? "" : "cp ${tex.baseName}.pdf ${params.name}"

  """
  ${xelatexScript}
  ${biblioScript}
  ${xelatexScript}
  ${nameScript}
  """
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
*/

def compileLatexMessage() {
  // Display COMPILE-LATEX message
  log.info "COMPILE-LATEX ~ $version - " + this.grabRevision() + (workflow.commitId ? " [$workflow.commitId]" : "")
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
  log.info "    --pictures"
  log.info "      Specify in which directory are the pictures"
  log.info "      Default is: pictures/"
  log.info "    --tag"
  log.info "      Specify with tag to use for the docker container"
  log.info "      Default is current version: $version"
  log.info "    --help"
  log.info "      You're reading it"
  log.info "    --version"
  log.info "      Displays version number"
}

def minimalInformationMessage() {
  // Minimal information message
  log.info "Command Line: $workflow.commandLine"
  log.info "Launch Dir  : $workflow.launchDir"
  log.info "Work Dir    : $workflow.workDir"
  log.info "Container   : $workflow.container"
  log.info "Tex file    : $tex"
  if (biblio.exists()) log.info "Bibliography: $biblio"
  log.info "Pictures in : $pictures"
}

def nextflowMessage() {
  // Nextflow message (version + build)
  log.info "N E X T F L O W  ~  version $workflow.nextflow.version $workflow.nextflow.build"
}

def startMessage() {
  // Display start message
  this.compileLatexMessage()
  this.minimalInformationMessage()
}

def versionMessage() {
  // Display version message
  log.info "COMPILE-LATEX"
  log.info "  version $version"
  log.info workflow.commitId ? "Git info    : $workflow.repository - $workflow.revision [$workflow.commitId]" : "  revision  : " + this.grabRevision()
}

workflow.onComplete {
  // Display end message
  this.nextflowMessage()
  this.compileLatexMessage()
  this.minimalInformationMessage()
  log.info "Completed at: $workflow.complete"
  log.info "Duration    : $workflow.duration"
  log.info "Success     : $workflow.success"
  log.info "Exit status : $workflow.exitStatus"
  log.info "Error report: " + (workflow.errorReport ?: '-')
}

workflow.onError {
  // Display error message
  this.nextflowMessage()
  this.compileLatexMessage()
  log.info "Workflow execution stopped with the following message: $workflow.errorMessage"
}
