FROM debian:bullseye-slim as build

ARG COURIER_REPO
ENV COURIER_REPO=${COURIER_REPO:-nyaruka/courier}
ARG COURIER_VERSION
ENV COURIER_VERSION=${COURIER_VERSION:-1.2.84}

RUN apt update && apt install -y wget
RUN wget -O courier.tar.gz "https://github.com/$COURIER_REPO/releases/download/v${COURIER_VERSION}/courier_${COURIER_VERSION}_linux_amd64.tar.gz"
RUN mkdir courier
RUN tar -xzC courier -f courier.tar.gz


FROM debian:bullseye-slim

RUN set -ex; \
    addgroup --system courier; \
    adduser --system --ingroup courier courier

# Install ca-certificates so HTTPS works in general
RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates && \
  rm -rf /var/lib/apt/lists/*

COPY --from=build courier/courier /usr/local/bin

EXPOSE 8080

RUN mkdir _storage && chown courier _storage
RUN mkdir /var/spool/courier && chown courier /var/spool/courier
USER courier

ENTRYPOINT []
CMD ["courier"]
