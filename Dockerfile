FROM postgres
ENV POSTGRES_PASSWORD odin
ENV POSTGRES_USER odin
ENV POSTGRES_DB odin_db

RUN mkdir -p /tmp/psql_data/

COPY db/structure.sql /tmp/psql_data/
COPY db/structure.sql /docker-entrypoint-initdb.d/