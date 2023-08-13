FROM ubuntu:20.04
RUN apt update
RUN apt install --no-install-recommends \
  rsync \
  tar

# copy crontabs for root user
COPY config/cronjobs /etc/crontabs/root

COPY config/id_rsa /root/.ssh/
RUN chmod 600 ~/.ssh/id_rsa

COPY config/backup.sh /root/
RUN chmod u+r+x /root/backup.sh



# start crond with log level 8 in foreground, output to stderr
CMD ["crond", "-f", "-d", "8"]