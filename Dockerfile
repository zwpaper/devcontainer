FROM fedora:rawhide
MAINTAINER zwPapEr <zw.paper@gmail.com>

# Env
RUN echo "root:root" | chpasswd
RUN dnf install -y zsh mosh tmux openssh-server \
    procps net-tools iproute                    \
    git man &&                                  \
    dnf clean all
RUN ssh-keygen -A
RUN sed -i 's/#Port/Port/g' /etc/ssh/sshd_config                    && \
    sed -i 's/#AddressFamily/AddressFamily/g' /etc/ssh/sshd_config  && \
    sed -i 's/#ListenAddress/ListenAddress/g' /etc/ssh/sshd_config  && \
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN usermod -s /usr/bin/zsh root

RUN dnf install -y emacs-nox global && \
    dnf clean all

# Dev software
## Basic
RUN dnf install -y gcc gdb && \
    dnf clean all

## Golang
RUN dnf install -y golang && \
    dnf clean all

WORKDIR /root

ENV LANG en_US.UTF-8

ADD env.rc /etc/env.rc
RUN chmod +x /etc/env.rc
