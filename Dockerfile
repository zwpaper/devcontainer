FROM fedora:rawhide
MAINTAINER zwPapEr <zw.paper@gmail.com>

# Env
RUN dnf install -y zsh tmux git openssh-server procps && \
    dnf clean all
RUN dnf install -y emacs-nox global && \
    dnf clean all
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN sed -i 's/#Port/Port/g' /etc/ssh/sshd_config                    && \
    sed -i 's/#AddressFamily/AddressFamily/g' /etc/ssh/sshd_config  && \
    sed -i 's/#ListenAddress/ListenAddress/g' /etc/ssh/sshd_config  && \
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A
RUN echo "root:root" | chpasswd
RUN usermod -s /usr/bin/zsh root

# Network tools
RUN dnf install -y net-tools iproute && \
    dnf clean all

# Dev software
RUN dnf install -y gcc gdb && \
    dnf clean all

# Golang
RUN dnf install -y golang && \
    dnf clean all
RUN mkdir /root/golang
RUN GOPATH="/root/golang" go get -u github.com/nsf/gocode      && \
    GOPATH="/root/golang" go get -u github.com/rogpeppe/godef  && \
    GOPATH="/root/golang" go get -u golang.org/x/tools/cmd/goimports

# dot files
ADD https://github.com/zwpaper/dotfile/archive/v0.1.tar.gz /root/
RUN cd /root && tar xf v0.1.tar.gz                                     && \
    mkdir /root/repo && mv /root/dotfile-0.1 /root/repo/dotfile         && \
    sed -i 's/GOROOT=\/usr\/local\/go/GOROOT=\/usr\/lib\/golang/g' ~/repo/dotfile/zshrc && \
    sed -i 's/\/home\/paper/\/root/g' ~/repo/dotfile/zshrc                              && \
    rm -f ~/.zshrc  && ln -s ~/repo/dotfile/zshrc ~/.zshrc                              && \
    rm -f ~/.tmux.conf && ln -s ~/repo/dotfile/tmux.conf ~/.tmux.conf                   && \
    rm -rf ~/.emacs.d && ln -s ~/repo/dotfile/emacs.d ~/.emacs.d                        && \
    rm -f /root/v0.1.tar.gz

WORKDIR /data

CMD ["/usr/sbin/sshd", "-D"]
