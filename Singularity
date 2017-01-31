BootStrap: debootstrap
OSVersion: jessie
MirrorURL: http://ftp.se.debian.org/debian/
Include: apt-get

%inside
	apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	fontconfig \
	lmodern \
	python-pygments \
	texlive-fonts-recommended \
	texlive-xetex \
	wget \
	&& rm -rf /var/lib/apt/lists/*
	mkdir google-fonts/ \
	&& wget \
	https://github.com/google/fonts/raw/master/apache/droidsans/DroidSans-Bold.ttf \
	https://github.com/google/fonts/raw/master/apache/droidsans/DroidSans.ttf \
	https://github.com/google/fonts/raw/master/apache/droidsansmono/DroidSansMono.ttf \
	https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-Bold.ttf \
	https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-BoldItalic.ttf \
	https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-Italic.ttf \
	https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif.ttf \
	-P google-fonts/
	mkdir -p /usr/share/fonts/truetype/google-fonts/ \
	&& find google-fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1 \
	&& rm -rf google-fonts
	fc-cache -f -v
