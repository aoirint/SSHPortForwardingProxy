FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
        openssh-server

RUN mkdir -p /var/run/sshd
RUN mkdir -p /sshd_log /authorized_keys
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'AllowTcpForwarding yes' >> /etc/ssh/sshd_config
RUN echo 'GatewayPorts yes' >> /etc/ssh/sshd_config

ADD ./docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
