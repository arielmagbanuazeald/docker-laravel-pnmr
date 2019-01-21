FROM nginx:1.15.8-alpine

ADD vhost.conf /etc/nginx/conf.d/default.conf