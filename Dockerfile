FROM debian:8.6

LABEL author="Maxime Garcia" \
	description="FastQC 0.11.5 image for use in CAW" \
	maintainer="max@ithake.eu"

# Install pre-requistes
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	fontconfig \
	lmodern \
	python-pygments \
	texlive-fonts-recommended \
	texlive-xetex \
	wget \
	&& rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
ENV GOOGLE_FONTS_URL https://github.com/google/fonts/raw/master/apache

# Download and install needed Google Fonts
RUN mkdir google-fonts/
WORKDIR google-fonts/
RUN wget $GOOGLE_FONTS_URL/droidsans/DroidSans-Bold.ttf \
	$GOOGLE_FONTS_URL/droidsans/DroidSans.ttf \
	$GOOGLE_FONTS_URL/droidsansmono/DroidSansMono.ttf \
	$GOOGLE_FONTS_URL/droidserif/DroidSerif-Bold.ttf \
	$GOOGLE_FONTS_URL/droidserif/DroidSerif-BoldItalic.ttf \
	$GOOGLE_FONTS_URL/droidserif/DroidSerif-Italic.ttf \
	$GOOGLE_FONTS_URL/droidserif/DroidSerif.ttf \
	-P google-fonts/

# Install downloaded fonts
RUN mkdir -p /usr/share/fonts/truetype/google-fonts/ \
	&& find google-fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1 \
	&& rm -rf google-fonts

# Update fonts cache
RUN fc-cache -f -v
