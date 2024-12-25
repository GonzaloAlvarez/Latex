FROM debian:stretch

RUN echo "deb http://archive.debian.org/debian stretch main non-free contrib" > /etc/apt/sources.list
RUN echo "deb http://archive.debian.org/debian stretch-backports main" >> /etc/apt/sources.list
RUN echo  "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list

# Latex packages
RUN apt-get update && \
    apt-get install -y texlive-full texlive-latex-extra texlive-latex-recommended \
    texlive-xetex texlive-extra-utils texlive-fonts-recommended \
    wget unzip && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://mirrors.ctan.org/macros/latex/contrib/moderncv.zip \
    && unzip moderncv.zip \
    && mv moderncv /usr/share/texlive/texmf-dist/

WORKDIR /root

# Default command
CMD ["bash"]
