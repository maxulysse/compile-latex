FROM ubuntu:16.04
MAINTAINER Maxime Garcia "max.u.garcia@gmail.com"

# Install pre-requistes
RUN apt-get update && apt-get install -y \
  git \
  texlive-xetex

# Install some Google Web Fonts
CMD cp $(ls -1 ${PWD}/fonts/**/*.ttf) /usr/share/fonts/truetype/google-fonts/.
CMD chown /usr/share/fonts/truetype/google-fonts/* 777
CMD fc-cache -f -v