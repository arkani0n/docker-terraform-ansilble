FROM nginx

USER nonroot
COPY ./index.html /data/www/index.html
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80