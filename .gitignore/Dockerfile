FROM centos:7
MAINTAINER "MrWorta <mrworta@nightsky.de>"

ARG SW_VER=tacacs-F4.0.4.28

RUN yum update -y; yum install -y curl flex bison tcp_wrappers-devel perl make gcc gcc-c++

RUN /bin/bash -c 'cd /tmp; curl ftp://ftp.shrubbery.net/pub/tac_plus/$SW_VER.tar.gz > /tmp/work.tar.gz; tar -xzf work.tar.gz;'
WORKDIR /tmp/$SW_VER
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

RUN mkdir /etc/tacacs; touch /etc/tacacs/tacacs.cfg
VOLUME /etc/tacacs
VOLUME /var/log/tacacs

EXPOSE 49/udp

WORKDIR /etc/tacacs
ENTRYPOINT ["/usr/local/sbin/tac_plus", "-G", "-t", "-l", "/var/log/tacacs/tacacs.log", "-C", "/etc/tacacs/tacacs.cfg"]
