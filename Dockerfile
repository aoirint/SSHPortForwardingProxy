FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install -y \
        openssh-server

RUN mkdir -p /var/run/sshd
RUN mkdir -p /sshd_log
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config

ADD ./docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
