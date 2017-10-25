FROM debian:stretch-slim

LABEL \
  author="Maxime Garcia" \
  description="Image for compile-latex" \
  maintainer="max.u.garcia@gmail.com"

# Set up ENV
ENV LANG=C.UTF-8

# Install pre-requistes
ARG DEBIAN_FRONTEND=noninteractive
RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    biber \
    ca-certificates \
    fontconfig \
    git \
    latexmk \
    lmodern \
    python-pygments \
    texlive-base \
    texlive-fonts-recommended \
    texlive-xetex \
    wget \
    xzdec \
  && rm -rf /var/lib/apt/lists/*

# Install Fonts, mtheme, modernCV
RUN \
  mkdir -p \
    /usr/share/fonts/truetype/academicons \
    /usr/share/fonts/truetype/fontawesome \
  && tlmgr init-usertree \
  && tlmgr install academicons \
  && tlmgr install beamertheme-metropolis \
  && tlmgr install biblatex \
  && tlmgr install ccicons \
  && tlmgr install fontawesome \
  && tlmgr install logreq \
  && tlmgr install moderncv \
  && tlmgr install ulem \
  && git clone https://github.com/jpswalsh/academicons.git \
    academicons \
	&& find academicons/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/academicons/ \; || return 1 \
  && git clone https://github.com/FortAwesome/Font-Awesome/ \
  fontawesome\
	&& find fontawesome/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/fontawesome/ \; || return 1 \
  && rm -rf \
    academicons* \
    fontawesome* \
  && texhash \
  && fc-cache -fv
