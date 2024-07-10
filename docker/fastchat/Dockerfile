# syntax=docker/dockerfile:1
FROM python:3.11-bookworm AS builder

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ADD https://api.github.com/repos/harsssh/FastChat/git/refs/heads/main version.json
RUN set -ex; \
    git clone https://github.com/harsssh/FastChat.git; \
    cd FastChat; \
    pip install ".[model_worker,webui]"; \
    cd .. ; \
    rm -rf FastChat

ENTRYPOINT [ "python3" ]