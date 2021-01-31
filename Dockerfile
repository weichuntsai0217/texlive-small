FROM ubuntu:16.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /
RUN apt-get update
RUN apt-get install -y dpkg make curl wget zip perl ghostscript libfontconfig fontconfig pandoc
RUN wget ftp://tug.org/historic/systems/texlive/2018/install-tl-unx.tar.gz
RUN tar -zxf install-tl-unx.tar.gz; rm install-tl-unx.tar.gz
RUN find ./ -maxdepth 1 -type d -name "install-tl-2*" | sed -r -e 's/^.*-([0-9]*)$/\1/g' -e 's/([0-9]{4})[0-9]{4}/\1/g' > /tex-year.tmp
RUN mv install-tl-2* install-tl

WORKDIR /install-tl
RUN echo "selected_scheme scheme-small" > tl-profile
RUN ./install-tl -repository ftp://tug.org/historic/systems/texlive/2018/tlnet-final -profile tl-profile

WORKDIR /
RUN rm -rf install-tl
COPY install-other-tex-packages.sh /
RUN chmod 755 install-other-tex-packages.sh
RUN ./install-other-tex-packages.sh
RUN rm install-other-tex-packages.sh tex-year.tmp

COPY txrun.sh /usr/local/bin
WORKDIR /usr/local/bin
RUN ln -s txrun.sh txrun

COPY addfont.sh /usr/local/bin
WORKDIR /usr/local/bin
RUN ln -s addfont.sh addfont

WORKDIR /
COPY Roboto /Roboto
COPY Noto_Serif_TC /Noto_Serif_TC
COPY Noto_Sans_TC /Noto_Sans_TC
RUN addfont /Roboto
RUN addfont /Noto_Serif_TC
RUN addfont /Noto_Sans_TC

WORKDIR /
COPY README.md /README-texlive-small.md

WORKDIR /root
RUN sed -i -r -e "s/alias ll='ls -alF'/alias ll='ls -alFh'/g" .bashrc
