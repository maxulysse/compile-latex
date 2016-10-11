#!/usr/bin/env nextflow

/*
========================================================================================
=                     C O M P I L E      L A T E X      B E A M E R                    =
========================================================================================
*/

String version = "0.0.5"
String dateUpdate = "2016-10-10"

switch (params) {
	case {params.help} :
		text = Channel.from(
			"COMPILE LATEX BEAMER ~ version $version",
			"    Usage:",
			"       nextflow run main.nf --tex <file.tex>",
			"    --help",
			"       you're reading it",
			"    --version",
			"       displays version number")
		text.subscribe { println "$it" }
		exit 1

	case {params.version} :
		text = Channel.from(
			"COMPILE LATEX BEAMER",
			"  Version $version",
			"  Last update on $dateUpdate",
			"Project : $workflow.projectDir",
			"Cmd line: $workflow.commandLine")
		text.subscribe { println "$it" }
		exit 1
}

workflow.onComplete {
	text = Channel.from(
		"COMPILE LATEX BEAMER",
		"Version     : $version",
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
		"       nextflow run main.nf --tex <file.tex>")
	text.subscribe { println "$it" }
	exit 1
}

themeDir = '~/workspace/beamer-templates'

/*
========================================================================================
=                                   P R O C E S S E S                                  =
========================================================================================
*/

process RunXelatex {
	publishDir ".", mode: 'move'

	input:
	file tex from tex

	output:
	file("${pdf}") into pdf_final

	"""
	ln -s ${themeDir}/* .

	xelatex ${tex}
	xelatex ${tex}
	"""
}