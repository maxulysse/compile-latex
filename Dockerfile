FROM debian:8.6

LABEL author="Maxime Garcia" \
description="Image for compile-beamer" \
maintainer="max@ithake.eu"

# Install pre-requistes
RUN apt-get update && apt-get install -y --no-install-recommends \
ca-certificates \
fontconfig \
git \
latexmk \
lmodern \
make \
python-pygments \
texlive-fonts-recommended \
texlive-generic-recommended \
texlive-latex-base \
texlive-xetex \
unzip \
wget \
&& rm -rf /var/lib/apt/lists/*

# Set up ENV
ENV LANG="C.UTF-8"

# Install Fonts, mtheme and update fonts/Tex cache
RUN mkdir -p /usr/share/fonts/opentype/FiraSans/ \
&& mkdir -p /usr/share/fonts/truetype/FiraSans/ \
&& mkdir -p /usr/share/texmf/fonts/enc/dvips/ccicons \
&& mkdir -p /usr/share/texmf/fonts/map/dvips/ccicons \
&& mkdir -p /usr/share/texmf/fonts/opentype/public/ccicons \
&& mkdir -p /usr/share/texmf/fonts/tfm/public/ccicons \
&& mkdir -p /usr/share/texmf/fonts/type1/public/ccicons \
&& mkdir -p /usr/share/texmf/tex/latex/ccicons \
&& wget \
https://carrois.com/downloads/Fira/Fira_Code_3_2.zip \
https://carrois.com/downloads/Fira/Fira_Mono_3_2.zip \
https://carrois.com/downloads/Fira/Fira_Sans_4_2.zip \
http://mirrors.ctan.org/install/fonts/ccicons.tds.zip \
-P . \
&& unzip ccicons.tds.zip -d ccicons/ \
&& unzip Fira_Code_3_2.zip \
&& unzip Fira_Mono_3_2.zip \
&& unzip Fira_Sans_4_2.zip \
&& cp Fira*/Fonts/*WEB*/*.ttf /usr/share/fonts/truetype/FiraSans/ \
&& cp Fira*/Fonts/*OTF*/*.otf /usr/share/fonts/opentype/FiraSans/ \
&& cp ccicons/fonts/*/*/ccicons/ccicons* ccicons/. \
&& cp ccicons/source/*/ccicons/ccicons.* ccicons/. \
&& cp ccicons/tex/latex/ccicons/ccicons.sty ccicons/. \
&& cd ccicons/ \
&& latex ccicons.ins \
&& cp ccicons-u.enc /usr/share/texmf/fonts/enc/dvips/ccicons \
&& cp ccicons.map /usr/share/texmf/fonts/map/dvips/ccicons \
&& cp ccicons.tfm /usr/share/texmf/fonts/tfm/public/ccicons \
&& cp ccicons.pfb /usr/share/texmf/fonts/type1/public/ccicons \
&& cp ccicons.otf /usr/share/texmf/fonts/opentype/public/ccicons \
&& cp ccicons.sty /usr/share/texmf/tex/latex/ccicons \
&& cd .. \
&& rm -rf ccicons* Fira* __MACOSX \
&& git clone --depth 1 https://github.com/matze/mtheme.git mtheme \
&& cd mtheme \
&& make install \
&& mkdir /usr/share/texmf/tex/latex/mtheme \
&& mv *.sty /usr/share/texmf/tex/latex/mtheme \
&& cd .. \
&& rm -rf mtheme \
&& fc-cache -fv \
&& texhash
