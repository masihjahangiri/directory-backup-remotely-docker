FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    rsync \
    tar && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# copy crontabs for root user
COPY config/cronjobs /etc/crontabs/root

COPY config/id_rsa /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa

COPY config/backup.sh /root/
RUN chmod u+r+x /root/backup.sh

# start cron with log level 8 in foreground
CMD ["cron", "-f", "-L", "8"]