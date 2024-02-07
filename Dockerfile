FROM nginx:1.24-alpine

# Install certbot
RUN apk add --no-cache certbot

# Copy renew cron script
COPY renew /etc/periodic/daily/renew
RUN chmod +x /etc/periodic/daily/renew

RUN mkdir -p /etc/letsencrypt /var/lib/certbot

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80
EXPOSE 443

ENTRYPOINT [ "/entrypoint.sh" ]
