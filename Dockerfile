FROM alpine:latest

WORKDIR /tmp
RUN apk add --no-cache python3 libstdc++ python3-dev build-base && \
    pip3 install docker salt && \
    apk del python3-dev build-base && \
    mkdir -p /var/log/salt && \
    mkdir -p /etc/salt/minion.d

ENV MINION_ID ""
ENV MASTER_ADDRESS "salt-master"

CMD echo $MINION_ID > /etc/salt/minion_id ; echo master: $MASTER_ADDRESS > /etc/salt/minion.d/master.conf ; salt-minion --log-level=info
