FROM scratch

RUN set -ex; \
    addgroup --system courier; \
    adduser --system --ingroup courier courier

COPY courier/courier /usr/local/bin/

EXPOSE 8080

USER courier

ENTRYPOINT []
CMD ["courier"]
