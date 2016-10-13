#!/usr/bin/env nextflow

/*
+vim: syntax=groovy
+-*- mode: groovy;-*-
========================================================================================
=             C   O   M   P   I   L   E       -      B   E   A   M   E   R             =
========================================================================================
*/

String version = "0.0.5"
String dateUpdate = "2016-10-10"

switch (params) {
	case {params.help} :
		text = Channel.from(
			"COMPILE-BEAMER ~ version $version",
			"    Usage:",
			"       nextflow run main.nf --tex <file.tex> (--BTB || --KI || --SLL)",
			"    --help",
			"       you're reading it",
			"    --version",
			"       displays version number")
		text.subscribe { println "$it" }
		exit 1

	case {params.version} :
		text = Channel.from(
			"COMPILE-BEAMER ~ version $version",
			"  Last update on $dateUpdate",
			"Project : $workflow.projectDir",
			"Cmd line: $workflow.commandLine")
		text.subscribe { println "$it" }
		exit 1
}

workflow.onComplete {
	text = Channel.from(
		"COMPILE-BEAMER ~ version $version",
		"Git info    : $workflow.repository - $workflow.revision [$workflow.commitId]",
		"Command line: ${workflow.commandLine}",
		"Completed at: ${workflow.complete}",
		"Duration    : ${workflow.duration}",
		"Success     : ${workflow.success}",
		"workDir     : ${workflow.workDir}",
		"Exit status : ${workflow.exitStatus}",
		"Error report: ${workflow.errorReport ?: '-'}")
	text.subscribe { log.info "$it" }
}

if (params.tex) {
	tex = file(params.tex)
	pdf = "$params.tex".replaceFirst(/.tex/, ".pdf")
} else {
	text = Channel.from(
		"COMPILE LATEX BEAMER ~ version $version",
		"No tex input file selected",
		"    Usage:",
		"       nextflow run main.nf --tex <file.tex> (--BTB || --KI || --SLL)")
	text.subscribe { println "$it" }
	exit 1
}

if (!params.BTB && !params.KI && !params.SLL) {
	text = Channel.from(
		"COMPILE LATEX BEAMER ~ version $version",
		"No theme selected (--BTB || --KI || --SLL)",
		"    Usage:",
		"       nextflow run main.nf --tex <file.tex> (--BTB ||--KI || --SLL)")
	text.subscribe { println "$it" }
	exit 1
} else if ((params.BTB && params.KI) || (params.BTB && params.SLL) || (params.KI && params.SLL)) {
	text = Channel.from(
		"COMPILE LATEX BEAMER ~ version $version",
		"Problem with theme selected (--BTB || --KI || --SLL)",
		"    Usage:",
		"       nextflow run main.nf --tex <file.tex> (--KI || --SLL)")
	text.subscribe { println "$it" }
	exit 1
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