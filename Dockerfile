FROM nginx:1.19-alpine

RUN apk add --update bash apache2-utils && rm -rf /var/cache/apk/*

RUN rm -rf /usr/share/nginx/html/*
RUN rm -rf /etc/nginx/conf.d
RUN rm /etc/nginx/nginx.conf

COPY config /config
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /

EXPOSE 8080

CMD [ "./start.sh" ]
