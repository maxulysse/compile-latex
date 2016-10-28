#!/usr/bin/env nextflow

/*
+vim: syntax=groovy
+-*- mode: groovy;-*-
========================================================================================
=             C   O   M   P   I   L   E       -      B   E   A   M   E   R             =
========================================================================================
*/

String version = "0.0.5"

switch (params) {
	case {params.help} :
		help_message("$version")
		exit 1

	case {params.version} :
		version_message("$version")
		exit 1
}

if (! params.tex) {
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

if (params.BTB) {
	themeSty  = '~/workspace/beamer-templates/beamerthemeBTB.sty'
	themeLogo = '~/workspace/beamer-templates/Barntumörbanken.pdf'
} else if (params.KI) {
	themeSty  = '~/workspace/beamer-templates/beamerthemeKI.sty'
	themeLogo = '~/workspace/beamer-templates/KI.pdf'
} else if (params.SLL) {
	themeSty  = '~/workspace/beamer-templates/beamerthemeSciLifeLab.sty'
	themeLogo = '~/workspace/beamer-templates/SciLifeLab.pdf'
}

/*
========================================================================================
=                                   P R O C E S S E S                                  =
========================================================================================
*/

process RunXelatex {
	publishDir ".", mode: 'move'

	input:
	file tex

	output:
	file("${pdf}") into pdf_final

	"""
	ln -s ${themeSty} beamerthemeTheme.sty
	ln -s ${themeLogo} .

	xelatex ${tex}
	xelatex ${tex}
	"""
}

workflow.onComplete {
	log.info "COMPILE-BEAMER ~ version $version"
	log.info "Git info    : $workflow.repository - $workflow.revision [$workflow.commitId]"
	log.info "Command line: ${workflow.commandLine}"
	log.info "Completed at: ${workflow.complete}"
	log.info "Duration    : ${workflow.duration}"
	log.info "Success     : ${workflow.success}"
	log.info "workDir     : ${workflow.workDir}"
	log.info "Exit status : ${workflow.exitStatus}"
	log.info "Error report: ${workflow.errorReport ?: '-'}"
}


def help_message(version) {
	log.info "COMPILE-BEAMER ~ version $version"
	log.info "    Usage:"
	log.info "       nextflow run main.nf --tex <file.tex> (--BTB || --KI || --SLL)"
	log.info "    --help"
	log.info "       you're reading it"
	log.info "    --version"
	log.info "       displays version number"
}

def version_message(version) {
	log.info "COMPILE-BEAMER ~ version $version"
	log.info "Project : $workflow.projectDir"
	log.info "Cmd line: $workflow.commandLine"
}