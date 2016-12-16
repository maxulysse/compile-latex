FROM ubuntu:16.04
MAINTAINER Maxime Garcia <max@ithake.eu>

# Install pre-requistes
RUN apt-get update && apt-get install -y \
  wget \
  fontconfig \
  texlive-xetex \
  python-pygments

# Download only needed Google Web Fonts
RUN mkdir $PWD/google-fonts/
RUN wget https://github.com/google/fonts/raw/master/apache/droidsans/DroidSans-Bold.ttf -O $PWD/google-fonts/DroidSans-Bold.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidsans/DroidSans.ttf -O $PWD/google-fonts/DroidSans.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidsansmono/DroidSansMono.ttf -O $PWD/google-fonts/DroidSansMono.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-Bold.ttf -O $PWD/google-fonts/DroidSerif-Bold.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-BoldItalic.ttf -O $PWD/google-fonts/DroidSerif-BoldItalic.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-Italic.ttf -O $PWD/google-fonts/DroidSerif-Italic.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif.ttf -O $PWD/google-fonts/DroidSerif.ttf

# Install downloaded fonts
RUN mkdir -p /usr/share/fonts/truetype/google-fonts/
RUN find $PWD/google-fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
RUN rm -rf $PWD/google-fonts

# Update fonts cache
RUN fc-cache -f -v
