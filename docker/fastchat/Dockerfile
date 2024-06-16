FROM python:3.11-bookworm AS builder
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN set -ex; \
    git clone https://github.com/harsssh/FastChat.git; \
    cd FastChat; \
    pip install ".[model_worker,webui]"

FROM gcr.io/distroless/python3-debian12
COPY --from=builder /usr/local/lib/python3.11/site-packages /root/.local/lib/python3.11/site-packages
ENV PYTHONPATH=/root/.local/lib/python3.11/site-packages
