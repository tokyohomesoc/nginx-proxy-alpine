FROM tokyohomesoc/nginx

MAINTAINER HomeSOC Tokyo <github@homesoc.tokyo>

ARG DOCKER_GEN_VERSION=0.7.3
RUN \
       apk add --no-cache \
            bash \
            curl \
    && curl -fSL https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
        -o docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && rm /docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

WORKDIR /app/
COPY nginx.tmpl /app/nginx.tmpl

VOLUME /etc/nginx/certs
VOLUME /etc/nginx/conf.d
VOLUME /etc/nginx/vhost.d
VOLUME /usr/share/nginx/html
VOLUME /app

CMD ["nginx", "-g", "daemon off;"]