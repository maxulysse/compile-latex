FROM ubuntu:16.04
MAINTAINER Maxime Garcia "max.u.garcia@gmail.com"

# Install pre-requistes and textlive-xetex
RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  texlive-xetex

# Install some Google Web Fonts
CMD wget https://github.com/google/fonts/archive/master.zip
CMD unzip master.zip -d fonts
CMD mkdir -p /usr/share/fonts/truetype/google-fonts
CMD find fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
CMD fc-cache -f -v