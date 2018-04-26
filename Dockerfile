FROM alpine:edge

LABEL Description="Eclipse Mosquitto MQTT Broker"
LABEL Maintainer="Aivo Antsman"

# User and group ID, for pi normally 1000
ARG UID=1000
ARG GID=1000

RUN apk --no-cache add mosquitto && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \
#   >> Adjust user and group ID
    apk --no-cache add shadow && \
    usermod -u $UID mosquitto && \
    groupmod -g $GID mosquitto && \
    apk del shadow && \
#   <<
    chown -R mosquitto:mosquitto /mosquitto

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]

