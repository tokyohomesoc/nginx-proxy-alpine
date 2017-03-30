FROM tokyohomesoc/nginx

MAINTAINER HomeSOC Tokyo <github@homesoc.tokyo>

ARG DOCKER_GEN_VERSION=0.7.3
ARG S6_OVERLAY=1.19.1.1
RUN \
       apk add --no-cache \
            bash \
            curl \
    && curl -fSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY}/s6-overlay-amd64.tar.gz \
        -o /tmp/s6-overlay-amd64.tar.gz \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
    && rm /tmp/s6-overlay-amd64.tar.gz \
    \
    && curl -fSL https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
        -o docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    && rm /docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

WORKDIR /app/
COPY nginx.tmpl /app/nginx.tmpl
COPY services.d /etc/services.d/

VOLUME /etc/nginx/certs
ENTRYPOINT ["/init"]