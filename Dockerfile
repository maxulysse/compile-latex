FROM debian:8.6

LABEL author="Maxime Garcia" \
	description="texlive-xetex image with mtheme and Fira fonts for compile-beamer" \
	maintainer="max@ithake.eu"

# Install pre-requistes
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	fontconfig \
	git \
	make \
	latexmk \
	lmodern \
	python-pygments \
	texlive-fonts-recommended \
	texlive-generic-recommended \
	texlive-latex-base \
	texlive-latex-extra \
	texlive-latex-recommended \
	texlive-xetex \
	unzip \
	wget \
	&& rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Download and install Fira Fonts
ENV FIRA_FONTS_URL https://carrois.com/downloads/Fira
RUN mkdir -p /usr/share/fonts/opentype/ \
	&& wget \
	$FIRA_FONTS_URL/Fira_Sans_4_2.zip \
	$FIRA_FONTS_URL/Fira_Mono_3_2.zip \
	$FIRA_FONTS_URL/Fira_Code_3_2.zip \
	-P . \
	&& unzip Fira_Sans_4_2.zip \
	&& unzip Fira_Mono_3_2.zip \
	&& unzip Fira_Code_3_2.zip \
	&& mkdir -p /usr/share/fonts/truetype/FiraSans/ \
	&& mkdir -p /usr/share/fonts/opentype/FiraSans/ \
	&& cp Fira*/Fonts/*WEB*/*.ttf /usr/share/fonts/truetype/FiraSans/ \
	&& cp Fira*/Fonts/*OTF*/*.otf /usr/share/fonts/opentype/FiraSans/ \
	&& rm -rf Fira* __MACOSX

# Install ccicons
RUN mkdir /usr/share/texmf/fonts/enc/dvips/ccicons \
	&& mkdir /usr/share/texmf/fonts/map/dvips/ccicons \
	&& mkdir /usr/share/texmf/fonts/tfm/public/ccicons \
	&& mkdir /usr/share/texmf/fonts/type1/public/ccicons \
	&& mkdir /usr/share/texmf/fonts/opentype/public/ccicons \
	&& mkdir /usr/share/texmf/tex/latex/ccicons \
	&& wget http://mirrors.ctan.org/install/fonts/ccicons.tds.zip \
	&& unzip ccicons.tds.zip -d ccicons/ \
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
	&& rm -rf ccicons

# Install mtheme
RUN git clone --depth 1 https://github.com/matze/mtheme.git mtheme \
	&& cd mtheme \
	&& make install \
	&& mkdir /usr/share/texmf/tex/latex/mtheme \
	&& mv *.sty /usr/share/texmf/tex/latex/mtheme

# Update fonts cache
RUN fc-cache -fv

# Update TeX cache
RUN texhash
