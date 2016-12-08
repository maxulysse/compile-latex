FROM ubuntu:16.04
MAINTAINER Maxime Garcia <max@ithake.eu>

# Install pre-requistes and textlive-xetex
RUN apt-get update && apt-get install -y \
  git \
  texlive-xetex

# Install Google Web Fonts
RUN git clone --depth 1 https://github.com/google/fonts.git google-fonts
RUN mkdir -p /usr/share/fonts/truetype/google-fonts/
RUN find $PWD/google-fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
RUN rm -rf $PWD/google-fonts
RUN fc-cache -f -v