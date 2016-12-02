# Installs Xelatex and all Google Web Fonts. A curated selection of the finest
# open fonts.

FROM ubuntu:latest
MAINTAINER Maxime Garcia "max.u.garcia@gmail.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list
RUN apt-get -y update; apt-get -y upgrade

# Install all Google Web Fonts
RUN apt-get install -y mercurial fontconfig
RUN hg clone https://googlefontdirectory.googlecode.com/hg/ fonts
RUN mkdir -p /usr/share/fonts/truetype/google-fonts/
RUN find $PWD/fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
RUN fc-cache -f -v

# Install the texlive-xetex package which includes the Xelatex executable.
RUN apt-get install -y git wget lsb-release
RUN git clone https://github.com/scottkosty/install-tl-ubuntu.git
RUN cd install-tl-ubuntu; ./install-tl-ubuntu