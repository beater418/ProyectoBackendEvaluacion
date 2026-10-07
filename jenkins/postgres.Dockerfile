FROM postgres:16-alpine

COPY data/postgres_data.sql /docker-entrypoint-initdb.d/postgres_data.sql