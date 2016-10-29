FROM opensuse:42.1
MAINTAINER Alex Geer <monoflash@gmail.com>

RUN zypper --non-interactive --quiet --gpg-auto-import-keys ref
RUN zypper --non-interactive --quiet up

RUN zypper --non-interactive --quiet in tar curl net-tools ca-certificates postfix git fontconfig fontconfig-devel
RUN zypper --non-interactive --quiet in yast2-fonts paratype-pt-mono-fonts paratype-pt-sans-fonts paratype-pt-serif-fonts sil-charis-fonts terminus-bitmap-fonts thessalonica-oldstandard-otf-fonts thessalonica-theano-otf-fonts thryomanes-fonts google-symbolneu-fonts google-tinos-fonts google-opensans-fonts google-croscore-fonts google-cousine-fonts google-arimo-fonts gnu-free-fonts fonts-config fontconfig dejavu-fonts cyreal-lobster-cyrillic-fonts cm-unicode-fonts cantarell-fonts
RUN zypper clean --all

# Nodejs
RUN curl --insecure --silent https://nodejs.org/dist/v7.0.0/node-v7.0.0-linux-x64.tar.xz | xz -d | tar x -C /usr/local
RUN ln -s --directory -v /usr/local/node-v7.0.0-linux-x64 /usr/local/nodejs
RUN echo "export PATH=\$PATH:/usr/local/nodejs/bin" >> /etc/bash.bashrc
RUN cp -v /etc/login.defs /etc/login.defs.origin && cat /etc/login.defs.origin | grep -v ENV_PATH > /etc/login.defs.tmp
RUN cat /etc/login.defs.tmp | grep -v ENV_ROOTPATH > /etc/login.defs && rm /etc/login.defs.tmp
RUN echo "ENV_PATH		PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/nodejs/bin" >> /etc/login.defs
RUN echo "ENV_ROOTPATH		PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/nodejs/bin" >> /etc/login.defs

ENV PATH /usr/local/nodejs/bin:$PATH

RUN update-ca-certificates
RUN npm install -g gulp
RUN npm install -g phantomjs
RUN npm install -g webshot-cli
RUN npm cache clean

WORKDIR /home
VOLUME ["/home"]
ENTRYPOINT ["webshot"]
CMD ["--help"]
