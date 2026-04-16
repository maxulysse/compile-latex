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
    """
    xelatex -shell-escape ${tex}

    if [[ -f ${biblio} ]]; then
        biber ${tex.baseName}.bcf
        xelatex -shell-escape ${tex}
    fi

    xelatex -shell-escape ${tex}
    """
}
