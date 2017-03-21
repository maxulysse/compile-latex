#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
================================================================================
=                   C  O  M  P  I  L  E  -  B  E  A  M  E  R                   =
================================================================================
@Author
Maxime Garcia <max@ithake.eu> [@MaxUlysse]
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

version = '1.5'

switch (params) {
	case {params.help} :
		helpMessage(version, grabRevision())
		exit 1

	case {params.version} :
		versionMessage(version, grabRevision())
		exit 1
}

if (!params.tex) {exit 1, 'No tex file, see --help for more information'}

pictures = file(params.pictures)
tex = file(params.tex)

startMessage(version, grabRevision())

/*
================================================================================
=                                 P R O C E S S                                =
================================================================================
*/

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

def grabRevision() {
	return workflow.commitId ? workflow.revision : workflow.scriptId.substring(0,10)
}

def helpMessage(version, revision) {
	log.info "COMPILE-BEAMER ~ $version - revision: $revision"
	log.info "    Usage:"
	log.info "       nextflow run MaxUlysse/compile-beamer --tex <input.tex> --theme <BTB||KI||SciLifeLab>"
	log.info "    --tex"
	log.info "      Compile the given tex file"
	log.info "    --help"
	log.info "       you're reading it"
	log.info "    --version"
	log.info "       displays version number"
}

def startMessage(version, revision) {
	log.info "COMPILE-BEAMER ~ $version - revision: $revision"
	log.info "Command line: $workflow.commandLine"
	log.info "Project Dir : $workflow.projectDir"
	log.info "Launch Dir  : $workflow.launchDir"
	log.info "Work Dir    : $workflow.workDir"
}

def versionMessage(version, revision) {
	log.info "COMPILE-BEAMER"
	log.info "  version $version"
	log.info ((workflow.commitId) ? "Git info   : $workflow.repository - $workflow.revision [$workflow.commitId]" : "  revision: $revision")
	log.info "Project  : $workflow.projectDir"
	log.info "Directory: $workflow.launchDir"
}

workflow.onComplete {
	log.info "N E X T F L O W ~ $workflow.nextflow.version - $workflow.nextflow.build"
	log.info "COMPILE-BEAMER ~ $version - revision: $revision"
	log.info "Command line: $workflow.commandLine"
	log.info "Project Dir : $workflow.projectDir"
	log.info "Launch Dir  : $workflow.launchDir"
	log.info "Work Dir    : $workflow.workDir"
	log.info "Completed at: $workflow.complete"
	log.info "Duration    : $workflow.duration"
	log.info "Success     : $workflow.success"
	log.info "Exit status : $workflow.exitStatus"
	log.info "Error report:" + (workflow.errorReport ?: '-')
}

workflow.onError {
	log.info "COMPILE-BEAMER"
	log.info "Workflow execution stopped with the following message: $workflow.errorMessage"
}
