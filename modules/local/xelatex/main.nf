process XELATEX {
    tag { tex }

    container 'texlive/texlive:latest'

    input:
    path biblio
    path pictures
    path tex

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
