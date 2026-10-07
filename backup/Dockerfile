FROM alpine:3.22

RUN apk add --no-cache \
    postgresql-client \
    aws-cli \
    bash \
    ca-certificates

WORKDIR /app

COPY backup.sh /app/backup.sh

RUN sed -i 's/\r$//' /app/backup.sh && \
    chmod +x /app/backup.sh

ENTRYPOINT ["/app/backup.sh"]