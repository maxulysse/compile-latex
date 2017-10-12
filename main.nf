#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
================================================================================
=                   C  O  M  P  I  L  E  -  B  E  A  M  E  R                   =
================================================================================
@Author
Maxime Garcia <max.u.garcia@gmail.com> [@MaxUlysse]
--------------------------------------------------------------------------------
 @Homepage
 https://github.com/MaxUlysse/compile-beamer
--------------------------------------------------------------------------------
 @Documentation
 https://github.com/MaxUlysse/compile-beamer/blob/master/README.md
--------------------------------------------------------------------------------
@Licence
 https://github.com/MaxUlysse/compile-beamer/blob/master/LICENSE
--------------------------------------------------------------------------------
 Process overview
 - RunXelatex - Run xelatex twice on given tex file
================================================================================
=                           C O N F I G U R A T I O N                          =
================================================================================
*/

if (!nextflow.version.matches('>= 0.25.3')) exit 1, "Nextflow version 0.25.3 or greater is needed to run this workflow"

version = '1.7.1'

params.help = false
params.version = false

if (params.help) exit 0, helpMessage()
if (params.version) exit 0, versionMessage()

params.pictures = 'pictures'
pictures = file(params.pictures)
params.tex = 'sample.tex'
tex = file(params.tex)

/*
================================================================================
=                                 P R O C E S S                                =
================================================================================
*/

startMessage()

process RunXelatex {
  tag {tex}

  publishDir ".", mode: 'move'

  input:
  file tex
  file pictures

  output:
  file("${tex.baseName}.pdf") into pdf

  script:
  """
  xelatex -shell-escape ${tex.baseName}
  xelatex -shell-escape ${tex.baseName}
  """
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
*/

def compileBeamerMessage() {
  // Display COMPILE-BEAMER message
  log.info "COMPILE-BEAMER ~ $version - " + this.grabRevision() + (workflow.commitId ? " [$workflow.commitId]" : "")
}

def grabRevision() {
  // Return the same string executed from github or not
  return workflow.revision ?: workflow.commitId ?: workflow.scriptId.substring(0,10)
}

def helpMessage() {
  // Display help message
  this.compileBeamerMessage()
  log.info "    Usage:"
  log.info "       nextflow run MaxUlysse/compile-beamer --tex <input.tex>"
  log.info "    --tex"
  log.info "      Compile the given tex file"
  log.info "    --help"
  log.info "       you're reading it"
  log.info "    --version"
  log.info "       displays version number"
}

def minimalInformationMessage() {
  // Minimal information message
  log.info "Command Line: $workflow.commandLine"
  log.info "Launch Dir  : $workflow.launchDir"
  log.info "Work Dir    : $workflow.workDir"
  log.info "Profile     : $workflow.profile"
  log.info "Container   : $workflow.container"
  log.info "Tex file    : $tex"
  log.info "Pictures in : $pictures"
}

def nextflowMessage() {
  // Nextflow message (version + build)
  log.info "N E X T F L O W  ~  version $workflow.nextflow.version $workflow.nextflow.build"
}

def startMessage() {
  // Display start message
  this.compileBeamerMessage()
  this.minimalInformationMessage()
}

def versionMessage() {
  // Display version message
  log.info "COMPILE-BEAMER"
  log.info "  version $version"
  log.info workflow.commitId ? "Git info    : $workflow.repository - $workflow.revision [$workflow.commitId]" : "  revision  : " + this.grabRevision()
}

workflow.onComplete {
  // Display end message
  this.nextflowMessage()
  this.compileBeamerMessage()
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
  this.compileBeamerMessage()
  log.info "Workflow execution stopped with the following message: $workflow.errorMessage"
}
