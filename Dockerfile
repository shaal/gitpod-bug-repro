FROM debian:buster-slim

RUN mkdir -p /var/tmp/dir-with-perms && cd /var/tmp && chown -R www-data dir-with-perms && chmod 777 dir-with-perms
RUN mkdir -p /var/tmp/filebits && cd /var/tmp/filebits && touch setuid && touch zeroes && chmod 4755 setuid && chmod 000 zeroes
RUN ls -R /var/tmp /var/tmp/filebits > /origperms.txt