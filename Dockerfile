FROM python:alpine3.10
LABEL maintainer="henk.wobbes(at)gmail.com"

ENV SOURCE_DIR /root
WORKDIR $SOURCE_DIR

COPY LICENSE requirements.txt config.json package.json frontend.py $SOURCE_DIR/
COPY docker_registry_frontend/ $SOURCE_DIR/docker_registry_frontend
COPY static $SOURCE_DIR/static
COPY templates $SOURCE_DIR/templates

RUN apk update \
    && apk add nodejs-npm git \
    && pip install -r /$SOURCE_DIR/requirements.txt \
    && npm install -g yarn \
    && yarn

EXPOSE 8080

VOLUME ["/opt"]

ENTRYPOINT python3 frontend.py -i 0.0.0.0 -p 8080 config.json
