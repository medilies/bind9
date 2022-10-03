FROM centos:7.9.2009

RUN yum update -y \
    && \
    yum install -y bind-9.11.4 \
    && \
    yum clean all \
    && \
    rm -rf /var/cache/yum

COPY named.conf /etc/named.conf
COPY medilies.db /var/named/medilies.db

RUN chgrp named /etc/named.conf &&\
    chown root /etc/named.conf &&\
    chgrp -R named /var/named/ &&\
    chown -R root /var/named/


EXPOSE 53/udp 53/tcp 953/tcp

ENTRYPOINT ["/usr/sbin/named", "-f"]