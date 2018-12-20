From ubuntu:16.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /
RUN apt-get update
RUN apt-get install -y dpkg make curl wget zip perl ghostscript libfontconfig fontconfig fonts-arphic-uming pandoc
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -zxf install-tl-unx.tar.gz; rm install-tl-unx.tar.gz
RUN find ./ -maxdepth 1 -type d -name "install-tl-2*" | sed -r -e 's/^.*-([0-9]*)$/\1/g' -e 's/([0-9]{4})[0-9]{4}/\1/g' > /tex-year.tmp
RUN mv install-tl-2* install-tl

WORKDIR /install-tl
RUN echo "selected_scheme scheme-small" > tl-profile
RUN ./install-tl -profile tl-profile

WORKDIR /
RUN rm -rf install-tl
COPY install-other-tex-packages.sh /
RUN chmod 755 install-other-tex-packages.sh
RUN ./install-other-tex-packages.sh
RUN rm install-other-tex-packages.sh tex-year.tmp

COPY txrun.sh /usr/local/bin
WORKDIR /usr/local/bin
RUN ln -s txrun.sh txrun

WORKDIR /
COPY README.md /README-texlive-small.md
