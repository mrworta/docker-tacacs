FROM centos:7
MAINTAINER "MrWorta <mrworta@nightsky.de>"

ARG SW_VER=DEVEL.202104181633
ARG SW_SHA256=5b37aba351f37487752481ee69adbbc5f76eb75e43dda2368a773921de670f73

RUN yum update -y; yum install -y curl flex bison tcp_wrappers-devel perl make gcc gcc-c++ bzip2 perl-Digest-MD5

RUN /bin/bash -c 'cd /tmp; curl http://www.pro-bono-publico.de/projects/src/$SW_VER.tar.bz2 > /tmp/work.tar.gz; tar -xjf work.tar.gz;'
RUN echo "$SW_SHA256 $SW_VER.tar.bz2" | /usr/bin/sha256sum --check || echo CHECKSUM FAILED
WORKDIR /tmp/PROJECTS
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

RUN mkdir /etc/tacacs; touch /etc/tacacs/tacacs.cfg
VOLUME /etc/tacacs
VOLUME /var/log/tacacs

EXPOSE 49/udp

WORKDIR /etc/tacacs
ENTRYPOINT ["/usr/local/sbin/tac_plus", "-f", "/etc/tacacs/tacacs.cfg"]
