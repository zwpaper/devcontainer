FROM fedora:rawhide
MAINTAINER zwPapEr <zw.paper@gmail.com>

# Env
RUN dnf install -y zsh tmux git openssh-server procps
RUN dnf install -y emacs-nox global
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN echo "root:root" | chpasswd
RUN sed -i 's/#Port/Port/g' /etc/ssh/sshd_config
RUN sed -i 's/#AddressFamily/AddressFamily/g' /etc/ssh/sshd_config
RUN sed -i 's/#ListenAddress/ListenAddress/g' /etc/ssh/sshd_config
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A
RUN usermod -s /usr/bin/zsh root

# Network tools
RUN dnf install -y net-tools iproute

# Dev software
RUN dnf install -y gcc gdb

# Golang
RUN dnf install -y golang
RUN mkdir /root/golang
RUN GOPATH="/root/golang" go get -u github.com/nsf/gocode
RUN GOPATH="/root/golang" go get -u github.com/rogpeppe/godef
RUN GOPATH="/root/golang" go get -u golang.org/x/tools/cmd/goimports

# dot files
RUN dnf install -y unzip
ADD https://github.com/zwpaper/dotfile/archive/master.zip /root/dotfile.zip
RUN cd /root && unzip dotfile.zip && mkdir /root/repo && mv /root/dotfile-master /root/repo/dotfile
RUN sed -i 's/GOROOT=\/usr\/local\/go/GOROOT=\/usr\/lib\/golang/g' ~/repo/dotfile/zshrc
RUN sed -i 's/\/home\/paper/\/root/g' ~/repo/dotfile/zshrc
RUN rm -f ~/.zshrc  && ln -s ~/repo/dotfile/zshrc ~/.zshrc
RUN rm -f ~/.tmux.conf && ln -s ~/repo/dotfile/tmux.conf ~/.tmux.conf
RUN rm -rf ~/.emacs.d && ln -s ~/repo/dotfile/emacs.d ~/.emacs.d
RUN rm -f /root/dotfile.zip

WORKDIR /data

CMD ["/usr/sbin/sshd", "-D"]
