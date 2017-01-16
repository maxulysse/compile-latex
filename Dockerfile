FROM debian:8.6

MAINTAINER Maxime Garcia <max@ithake.eu>

# Install pre-requistes
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  fontconfig \
  texlive-xetex \
  texlive-fonts-recommended \
  lmodern \
  python-pygments

# Download needed Google Fonts
RUN mkdir google-fonts/
RUN wget https://github.com/google/fonts/raw/master/apache/droidsans/DroidSans-Bold.ttf -O google-fonts/DroidSans-Bold.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidsans/DroidSans.ttf -O google-fonts/DroidSans.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidsansmono/DroidSansMono.ttf -O google-fonts/DroidSansMono.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-Bold.ttf -O google-fonts/DroidSerif-Bold.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-BoldItalic.ttf -O google-fonts/DroidSerif-BoldItalic.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif-Italic.ttf -O google-fonts/DroidSerif-Italic.ttf
RUN wget https://github.com/google/fonts/raw/master/apache/droidserif/DroidSerif.ttf -O google-fonts/DroidSerif.ttf

# Install downloaded fonts
RUN mkdir -p /usr/share/fonts/truetype/google-fonts/
RUN find google-fonts/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
RUN rm -rf google-fonts

# Update fonts cache
RUN fc-cache -f -v
