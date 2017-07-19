FROM fedora:rawhide
MAINTAINER zwPapEr <zw.paper@gmail.com>

# Env
RUN echo "root:root" | chpasswd
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ENV LANG en_US.UTF-8

RUN dnf install -y zsh mosh tmux openssh-server \
    net-tools iproute iputils telnet            \
    findutils procps                            \
    git man gcc gdb

RUN ssh-keygen -A
RUN sed -i 's/#Port/Port/g' /etc/ssh/sshd_config                    && \
    sed -i 's/#AddressFamily/AddressFamily/g' /etc/ssh/sshd_config  && \
    sed -i 's/#ListenAddress/ListenAddress/g' /etc/ssh/sshd_config  && \
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN usermod -s /usr/bin/zsh root
RUN setcap cap_net_raw+ep /usr/bin/ping

RUN dnf install -y emacs-nox global

# Dev software
## Golang
RUN dnf install -y golang

WORKDIR /root

ADD env.rc /etc/env.rc
RUN chmod +x /etc/env.rc
