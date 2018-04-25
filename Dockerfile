FROM alpine:edge

LABEL Description="Eclipse Mosquitto MQTT Broker"
LABEL Maintainer="Aivo Antsman"

# RUN apk --no-cache add mosquitto=1.4.15-r0 && \
RUN apk --no-cache add mosquitto && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \
    chown -R mosquitto:mosquitto /mosquitto

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"] 
