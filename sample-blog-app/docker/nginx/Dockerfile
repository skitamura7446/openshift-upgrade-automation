FROM registry.access.redhat.com/ubi8/nginx-120

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

USER 1001
EXPOSE 8080

CMD nginx -g "daemon off;"
