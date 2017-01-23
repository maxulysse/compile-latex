FROM debian:8.6

LABEL author="Maxime Garcia" \
	description="FastQC 0.11.5 image for use in CAW" \
	maintainer="max@ithake.eu"

# Install pre-requistes
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	curl \
	fontconfig \
	lmodern \
	python-pygments \
	texlive-fonts-recommended \
	texlive-xetex \
	&& rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
ENV GOOGLE_FONTS_URL https://github.com/google/fonts/raw/master/apache

# Download and install needed Google Fonts
RUN mkdir google-fonts/ \
	&& curl -fsSL $GOOGLE_FONTS_URL/droidsans/DroidSans-Bold.ttf -o google-fonts/DroidSans-Bold.ttf \
	&& curl -fsSL $GOOGLE_FONTS_URL/droidsans/DroidSans.ttf -o google-fonts/DroidSans.ttf \
	&& curl -fsSL $GOOGLE_FONTS_URL/droidsansmono/DroidSansMono.ttf -o google-fonts/DroidSansMono.ttf \
	&& curl -fsSL $GOOGLE_FONTS_URL/droidserif/DroidSerif-Bold.ttf -o google-fonts/DroidSerif-Bold.ttf \
	&& curl -fsSL $GOOGLE_FONTS_URL/droidserif/DroidSerif-BoldItalic.ttf -o google-fonts/DroidSerif-BoldItalic.ttf \
	&& curl -fsSL $GOOGLE_FONTS_URL/droidserif/DroidSerif-Italic.ttf -o google-fonts/DroidSerif-Italic.ttf \
	&& curl -fsSL $GOOGLE_FONTS_URL/droidserif/DroidSerif.ttf -o google-fonts/DroidSerif.ttf
# Install downloaded fonts
RUN mkdir -p /usr/share/fonts/truetype/google-fonts/ \
	&& find google-fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1 \
	&& rm -rf google-fonts

# Update fonts cache
RUN fc-cache -f -v
