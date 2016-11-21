#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
=====================
=  COMPILE - BEAMER =
=====================
*/

revision = grabGitRevision() ?: ''
version  = "v0.7"

switch (params) {
	case {params.help} :
		help_message(version, revision)
		exit 1

	case {params.version} :
		version_message(version, revision)
		exit 1
}

if (!params.tex) {
	exit 1, 'You need to specify a tex file, see --help for more information'
}

if (!params.theme) {
	exit 1, 'You need to specify a theme, see --help for more information'
}

if (params.theme == "BTB") {
	themeStyle = workflow.projectDir + params.style_BTB
	themeLogo  = workflow.projectDir + params.logo_BTB
} else if (params.theme == "KI") {
	themeStyle = workflow.projectDir + params.style_KI
	themeLogo  = workflow.projectDir + params.logo_KI
} else if (params.theme == "SLL") {
	themeStyle = workflow.projectDir + params.style_SLL
	themeLogo  = workflow.projectDir + params.logo_SLL
} else {
	exit 1, "Theme $params.theme unknown, see --help for more information"
}

pictures = file(params.pictures)
tex = file(params.tex)

/*
=====================
=     PROCESSES     =
=====================
*/

process RunXelatex {
	publishDir ".", mode: 'move'

	input:
	file tex
	file pictures
  file 'beamerthemeTheme.sty' from themeStyle
  file 'beamertheme.pdf' from themeLogo

	output:
	file("*.pdf") into pdf

	script:
	"""
	xelatex ${tex}
	xelatex ${tex}
	"""
}

/*
=====================
=     FUNCTIONS     =
=====================
*/

def grabGitRevision() { // Borrowed from https://github.com/NBISweden/wgs-structvar
  if (workflow.commitId) { // it's run directly from github
    return workflow.commitId.substring(0,10)
  }
  // Try to find the revision directly from git
  headPointerFile = file("${baseDir}/.git/HEAD")
  if (!headPointerFile.exists()) {
    return ''
  }
  ref = headPointerFile.newReader().readLine().tokenize()[1]
  refFile = file("${baseDir}/.git/$ref")
  if (!refFile.exists()) {
    return ''
  }
  revision = refFile.newReader().readLine()
  return revision.substring(0,10)
}

def help_message(version, revision) {
  log.info "COMPILE-BEAMER ~ $version - revision: $revision"
  log.info "    Usage:"
  log.info "       nextflow run MaxUlysse/compile-beamer --tex <input.tex> --theme <BTB || KI || SLL>"
  log.info "    --help"
  log.info "       you're reading it"
  log.info "    --version"
  log.info "       displays version number"
}

def start_message(version, revision) {
  log.info "COMPILE-BEAMER ~ $version - revision: $revision"
  log.info "Project     : $workflow.projectDir"
  log.info "Directory   : $workflow.launchDir"
  log.info "workDir     : $workflow.workDir"
  log.info "Command line: $workflow.commandLine"
}

def version_message(version, revision) {
  log.info "COMPILE-BEAMER"
  log.info "  version $version"
  log.info "  revision: $revision"
  log.info "Git info  : repository - $revision [$workflow.commitId]"
  log.info "Project   : $workflow.projectDir"
  log.info "Directory : $workflow.launchDir"
}

workflow.onComplete {
  log.info "COMPILE-BEAMER ~ $version - revision: $revision"
  log.info "Project     : $workflow.projectDir"
  log.info "workDir     : $workflow.workDir"
  log.info "Command line: $workflow.commandLine"
  log.info "Theme used  : $params.theme"
  log.info "Completed at: $workflow.complete"
  log.info "Duration    : $workflow.duration"
  log.info "Success     : $workflow.success"
  log.info "Exit status : $workflow.exitStatus"
  log.info "Error report: ${workflow.errorReport ?: '-'}"
}

workflow.onError {
  log.info "COMPILE-BEAMER"
  log.info "Workflow execution stopped with the following message: $workflow.errorMessage"
}