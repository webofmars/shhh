# -*- coding: utf-8 -*-
# File     : Dockerfile
# Date     : 12.01.2020
# Authors  : Austin Schaffer <schaffer.austin.t@gmail.com>
#            Matthieu Petiteau <mpetiteau.pro@gmail.com>

FROM alpine:3.11.0

RUN apk update && \
    apk add build-base python3 python3-dev libffi-dev libressl-dev && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 usr/bin/pip && \
    pip install --upgrade pip

RUN mkdir -p /var/log/celery/ /var/run/celery/ /var/log/shhh/
RUN addgroup app && \
    adduser --disabled-password --gecos "" --ingroup app --no-create-home app && \
    chown app:app /var/run/celery/ && \
    chown app:app /var/log/celery/ && \
    chown app:app /var/log/shhh/

WORKDIR app/

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY shhh shhh

ENV FLASK_APP=shhh

USER app
