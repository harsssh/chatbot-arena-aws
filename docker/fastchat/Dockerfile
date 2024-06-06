FROM python:3.11-bookworm AS builder
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

FROM gcr.io/distroless/python3-debian12
COPY --from=builder /usr/local/lib/python3.11/site-packages /root/.local/lib/python3.11/site-packages
ENV PYTHONPATH=/root/.local/lib/python3.11/site-packages
