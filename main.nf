#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
=====================
=  COMPILE - BEAMER =
=====================
*/

revision = grab_git_revision() ?: ''
version  = "v0.6"

switch (params) {
	case {params.help} :
		help_message("$version", "$revision")
		exit 1

	case {params.version} :
		version_message("$version", "$revision")
		exit 1
}

if (params.pictures) {
	pictures = file(params.pictures)
} else { pictures = file("pictures") }

if (!params.tex) {
	exit 1, 'You need to specify a tex file, see --help for more information'
} else {
	tex = file(params.tex)
	pdf = "$params.tex".replaceFirst(/.tex/, ".pdf")
}

if (!params.BTB && !params.KI && !params.SLL) {
	exit 1, 'You need to specify a theme, see --help for more information'
} else if ((params.BTB && params.KI) || (params.BTB && params.SLL) || (params.KI && params.SLL)) {
	exit 1, 'You need to specify only one theme, see --help for more information'
}

switch (params) {
	case {params.BTB} :
		themeStyle = "${workflow.projectDir}/" + params.style_BTB
		themeLogo  = "${workflow.projectDir}/" + params.logo_BTB
		break
	case {params.KI} :
		themeStyle = "${workflow.projectDir}/" + params.style_KI
		themeLogo  = "${workflow.projectDir}/" + params.logo_KI
		break
	case {params.SLL} :
		themeStyle = "${workflow.projectDir}/" + params.style_SLL
		themeLogo  = "${workflow.projectDir}/" + params.logo_SLL
		break
}

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

	output:
	file("${pdf}") into pdf_final

	script:
	"""
	ln -s ${themeStyle} beamerthemeTheme.sty
	ln -s ${themeLogo} .

	xelatex ${tex}
	xelatex ${tex}
	"""
}

/*
=====================
=     FUNCTIONS     =
=====================
*/

def grab_git_revision() {
  // Borrowed from https://github.com/NBISweden/wgs-structvar

  if ( workflow.commitId ) { // it's run directly from github
    return workflow.commitId.substring(0,10)
  }
  // Try to find the revision directly from git
  head_pointer_file = file("${baseDir}/.git/HEAD")
  if ( ! head_pointer_file.exists() ) {
    return ''
  }
  ref = head_pointer_file.newReader().readLine().tokenize()[1]
  ref_file = file("${baseDir}/.git/$ref")
  if ( ! ref_file.exists() ) {
    return ''
  }
  revision = ref_file.newReader().readLine()
  return revision.substring(0,10)
}

def help_message(version, revision) {
  log.info "COMPILE-BEAMER ~ $version - revision: $revision"
  log.info "    Usage:"
  log.info "       nextflow run MaxUlysse/compile-beamer --tex <input.tex> (--BTB || --KI || --SLL)"
  log.info "    --help"
  log.info "       you're reading it"
  log.info "    --version"
  log.info "       displays version number"
}

def start_message(version, revision) {
  log.info "COMPILE-BEAMER ~ $version - revision: $revision"
  log.info "Project     : ${workflow.projectDir}"
  log.info "Directory   : ${workflow.launchDir}"
  log.info "workDir     : ${workflow.workDir}"
  log.info "Command line: ${workflow.commandLine}"
}

def version_message(version, revision) {
  log.info "COMPILE-BEAMER"
  log.info "  version $version"
  log.info "  revision: $revision"
  log.info "Git info  : repository - $revision [$workflow.commitId]"
  log.info "Project   : ${workflow.projectDir}"
  log.info "Directory : ${workflow.launchDir}"
}

workflow.onComplete {
  log.info "COMPILE-BEAMER ~ $version - revision: $revision"
  log.info "Project     : ${workflow.projectDir}"
  log.info "workDir     : ${workflow.workDir}"
  log.info "Command line: ${workflow.commandLine}"
  log.info "Completed at: ${workflow.complete}"
  log.info "Duration    : ${workflow.duration}"
  log.info "Success     : ${workflow.success}"
  log.info "Exit status : ${workflow.exitStatus}"
  log.info "Error report: ${workflow.errorReport ?: '-'}"
}

workflow.onError {
  log.info "Workflow execution stopped with the following message: ${workflow.errorMessage}"
}