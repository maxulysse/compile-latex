FROM ubuntu:16.04
MAINTAINER Maxime Garcia "max.u.garcia@gmail.com"

# Install pre-requistes
RUN apt-get update && apt-get install -y \
  git
 
# Install some Google Web Fonts
RUN cp $(ls -1 $(PWD)/fonts/**/*.ttf) /usr/share/fonts/truetype/google-fonts/.
RUN chown /usr/share/fonts/truetype/google-fonts/* 777
RUN fc-cache -f -v

# Install the texlive-xetex package which includes the Xelatex executable.
RUN git clone https://github.com/scottkosty/install-tl-ubuntu.git
RUN cd install-tl-ubuntu; ./install-tl-ubuntu