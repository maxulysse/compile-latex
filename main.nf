#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
================================================================================
=                   C  O  M  P  I  L  E  -  B  E  A  M  E  R                   =
================================================================================
@Author
Maxime Garcia <maxime.garcia@scilifelab.se> [@MaxUlysse]
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
 Processes overview
 - RunXelatex - Run xelatex twice on given tex file
================================================================================
=                           C O N F I G U R A T I O N                          =
================================================================================
*/

revision = grabGitRevision() ?: ''
version = 'v1.1.3'

switch (params) {
	case {params.help} :
		helpMessage(version, revision)
		exit 1

	case {params.version} :
		versionMessage(version, revision)
		exit 1
}

if (!params.tex) {exit 1, 'No tex file, see --help for more information'}
if (!params.theme) {exit 1, 'No theme selected, see --help for more information'}

(themeStyle, themeLogo) = defineTheme(params.theme)

pictures = file(params.pictures)
tex = file(params.tex)

startMessage(version, revision)

/*
================================================================================
=                                 P R O C E S S                                =
================================================================================
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
	xelatex -shell-escape ${tex}
	xelatex -shell-escape ${tex}
	"""
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
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

def defineTheme(theme) {
	if (theme == 'BTB') { return [
		workflow.projectDir + params.style_BTB,
		workflow.projectDir + params.logo_BTB
		]
	} else if (theme == 'KI') { return [
		workflow.projectDir + params.style_KI,
		workflow.projectDir + params.logo_KI
		]
	} else if (theme == 'SciLifeLab') { return [
		workflow.projectDir + params.style_SciLifeLab,
		workflow.projectDir + params.logo_SciLifeLab
		]
	} else {
		exit 1, "Theme $theme unknown, see --help for more information"
	}
}

def helpMessage(version, revision) {
	log.info "COMPILE-BEAMER ~ $version - revision: $revision"
	log.info "    Usage:"
	log.info "       nextflow run MaxUlysse/compile-beamer --tex <input.tex> --theme <BTB||KI||SciLifeLab>"
	log.info "    --tex"
	log.info "      Compile the given tex file"
	log.info "    --theme"
	log.info "      Compile using given theme. Default is ScilifeLab."
	log.info "        Also available are KI and BTB."
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
	if (workflow.commitId) {
		log.info "Git info    : $workflow.repository - $workflow.revision [$workflow.commitId]"
	} else {
		log.info "  revision  : $revision"
	}
	log.info "Project   : $workflow.projectDir"
	log.info "Directory : $workflow.launchDir"
}

workflow.onComplete {
	log.info "N E X T F L O W ~ $workflow.nextflow.version - $workflow.nextflow.build"
	log.info "COMPILE-BEAMER ~ $version - revision: $revision"
	log.info "Command line: $workflow.commandLine"
	log.info "Project Dir : $workflow.projectDir"
	log.info "Launch Dir  : $workflow.launchDir"
	log.info "Work Dir    : $workflow.workDir"
	log.info "Theme used  : $params.theme"
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
