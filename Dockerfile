FROM opensuse:latest
MAINTAINER Alex Geer <monoflash@gmail.com>

RUN zypper --non-interactive --quiet --gpg-auto-import-keys ref
RUN zypper --non-interactive --quiet up

RUN zypper --non-interactive --quiet in tar curl net-tools ca-certificates postfix git fontconfig fontconfig-devel bzip2
RUN zypper --non-interactive --quiet in yast2-fonts paratype-pt-mono-fonts paratype-pt-sans-fonts paratype-pt-serif-fonts sil-charis-fonts terminus-bitmap-fonts thessalonica-oldstandard-otf-fonts thessalonica-theano-otf-fonts thryomanes-fonts google-symbolneu-fonts google-tinos-fonts google-opensans-fonts google-croscore-fonts google-cousine-fonts google-arimo-fonts gnu-free-fonts fonts-config fontconfig dejavu-fonts cyreal-lobster-cyrillic-fonts cm-unicode-fonts cantarell-fonts
RUN zypper --non-interactive --quiet in git gmake gcc-c++
RUN zypper clean --all
RUN update-ca-certificates

## Nodejs
RUN curl --insecure --silent https://nodejs.org/dist/v9.0.0/node-v9.0.0-linux-x64.tar.xz | xz -d | tar x -C /usr/local
RUN ln -s --directory -v /usr/local/node-v9.0.0-linux-x64 /usr/local/nodejs
RUN echo "export PATH=\$PATH:/usr/local/nodejs/bin" >> /etc/bash.bashrc
RUN cp -v /etc/login.defs /etc/login.defs.origin && cat /etc/login.defs.origin | grep -v ENV_PATH > /etc/login.defs.tmp
RUN cat /etc/login.defs.tmp | grep -v ENV_ROOTPATH > /etc/login.defs && rm /etc/login.defs.tmp
RUN echo "ENV_PATH		PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/nodejs/bin" >> /etc/login.defs
RUN echo "ENV_ROOTPATH		PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/nodejs/bin" >> /etc/login.defs
ENV PATH /usr/local/nodejs/bin:$PATH

## PhantomJS
RUN curl -L 'https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2' \
  -H 'Host: bitbucket.org' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:56.0) Gecko/20100101 Firefox/56.0' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
  -H 'Accept-Language: ru-RU,ru;q=0.91,en;q=0.82,zh-CN;q=0.73,ar-SY;q=0.64,hi;q=0.55,es-ES;q=0.45,bn;q=0.36,pt;q=0.27,ja;q=0.18,de;q=0.09' \
  -H 'Referer: http://phantomjs.org/download.html' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' | bzip2 -d - | tar x -C /usr/local
RUN ln -s --directory -v /usr/local/phantomjs-2.1.1-linux-x86_64 /usr/local/phantomjs
RUN ln -s --directory -v /usr/local/phantomjs/bin/phantomjs /usr/local/bin/phantomjs

## WebshotCli
RUN npm install -g webshot-cli@latest
RUN npm -g update
RUN npm --force cache clean

WORKDIR /home
VOLUME ["/home"]
ENTRYPOINT ["webshot"]
CMD ["--help"]
