FROM alpine:latest

WORKDIR /tmp
RUN apk add --no-cache curl && \
    curl -s -o bootstrap-salt.sh -L https://bootstrap.saltstack.com && \
    sh ./bootstrap-salt.sh -X -d && \
    mkdir -p /etc/salt/minion.d && \
    apk del curl && \
    ln -s /dev/stdout /var/log/salt/minion

ENV MINION_ID ""
ENV MASTER_ADDRESS "salt-master"

CMD echo $MINION_ID > /etc/salt/minion_id ; echo master: $MASTER_ADDRESS > /etc/salt/minion.d/master.conf ; salt-minion --log-level=info
