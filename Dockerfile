FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  rsync \
  tar

# Copy crontabs for root user
COPY config/cronjobs /etc/cron.d/root

COPY config/id_rsa /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa

COPY config/backup.sh /root/
RUN chmod u+x /root/backup.sh

# Start cron in foreground
CMD ["/usr/sbin/crond", "-f"]