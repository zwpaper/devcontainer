FROM fedora:rawhide
MAINTAINER zwPapEr <zw.paper@gmail.com>

# Env
RUN dnf install -y zsh tmux git
RUN dnf install -y emacs-nox global
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Dev software
RUN dnf install -y gcc gdb

# Golang
RUN dnf install -y golang
RUN mkdir /root/golang
RUN go get -u github.com/nsf/gocode
RUN go get -u github.com/rogpeppe/godef
RUN go get -u golang.org/x/tools/cmd/goimports

RUN dnf install -y unzip
ADD https://github.com/zwpaper/dotfile/archive/master.zip /root/dotfile.zip
RUN cd /root && unzip dotfile.zip && mkdir /root/repo && mv /root/dotfile-master /root/repo/dotfile
RUN sed -i 's/\/local\/go/\/bin/g' ~/repo/dotfile/zshrc && sed -i 's/\/home\/paper/\/root/g' ~/repo/dotfile/zshrc
RUN rm -f ~/.zshrc  && ln -s ~/repo/dotfile/zshrc ~/.zshrc
RUN rm -f ~/.tmux.conf && ln -s ~/repo/dotfile/tmux.conf ~/.tmux.conf
RUN rm -rf ~/.emacs.d && ln -s ~/repo/dotfile/emacs.d ~/.emacs.d
RUN rm -f /root/dotfile.zip

WORKDIR /data

CMD ["tmux"]
