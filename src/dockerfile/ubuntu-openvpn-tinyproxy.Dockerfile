from ubuntu:noble

ARG OPENVPN_CONFIG_PATH
ARG OPENVPN_ARGS

ENV OPENVPN_CONFIG_PATH=$OPENVPN_CONFIG_PATH
ENV OPENVPN_ARGS=$OPENVPN_ARGS

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y openvpn net-tools iputils-ping curl iproute2 tinyproxy supervisor \
    && rm -rf /var/lib/apt/lists/*

ADD conf/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
ADD conf/tinyproxy.supervisord.conf /etc/supervisor/conf.d/tinyproxy.conf

ADD conf/openvpn.supervisor.conf /etc/supervisor/conf.d/openvpn.conf

CMD ["/usr/bin/supervisord"]