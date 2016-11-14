#!/usr/bin/env nextflow

/*
+vim: syntax=groovy
+-*- mode: groovy;-*-
=====================
=  COMPILE - BEAMER =
=====================
*/

String version = "0.5"

switch (params) {
	case {params.help} :
		help_message("$version")
		exit 1

	case {params.version} :
		version_message("$version")
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
		themeSty  = "beamer-templates/beamerthemeBTB.sty"
		themeLogo = "beamer-templates/Barntumörbanken.pdf"
		break
	case {params.KI} :
		themeSty  = "beamer-templates/beamerthemeKI.sty"
		themeLogo = "beamer-templates/KI.pdf"
		break
	case {params.SLL} :
		themeSty  = "beamer-templates/beamerthemeSciLifeLab.sty"
		themeLogo = "beamer-templates/SciLifeLab.pdf"
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
	ln -s ${themeSty} beamerthemeTheme.sty
	ln -s ${themeLogo} .

	xelatex ${tex}
	xelatex ${tex}
	"""
}

workflow.onComplete {
	log.info "COMPILE-BEAMER ~ version $version"
	log.info "Command line: ${workflow.commandLine}"
	log.info "Completed at: ${workflow.complete}"
	log.info "Duration    : ${workflow.duration}"
	log.info "Success     : ${workflow.success}"
	log.info "workDir     : ${workflow.workDir}"
	log.info "Exit status : ${workflow.exitStatus}"
	log.info "Error report: ${workflow.errorReport ?: '-'}"
}

/*
=====================
=     FUNCTIONS     =
=====================
*/

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