process XELATEX {
    tag { tex }

    container 'docker.io/texlive/texlive:latest'

    input:
    path tex
    path biblio
    path pictures

    output:
    path "*.pdf", emit: pdf

    script:
    biberScript = biblio.exists() ? "biber ${tex.baseName}.bcf ; xelatex -shell-escape ${tex}" : ""

    """
    xelatex -shell-escape ${tex}
    ${biberScript}
    xelatex -shell-escape ${tex}
    """
}
