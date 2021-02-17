FROM debian:buster-slim

RUN mkdir -p /var/tmp/dir-with-perms && cd /var/tmp && chown -R www-data dir-with-perms && chmod 777 dir-with-perms
RUN mkdir -p /var/tmp/filebits && cd /var/tmp/filebits && touch setuid zeroes sevens && chmod 4755 setuid && chmod 000 zeroes && chmod 777 sevens
RUN ls -R /var/tmp > /origperms.txt