
FROM debian:jessie

LABEL maintainer "sfernandez@ironbox.com.ar"

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY main.sh /
RUN mkdir /www

EXPOSE 80

WORKDIR /www

RUN chmod -R 777 $PWD

ENTRYPOINT ["/main.sh"]