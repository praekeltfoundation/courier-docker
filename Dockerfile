FROM scratch

COPY courier/courier /usr/local/bin/

EXPOSE 8080

USER courier

ENTRYPOINT []
CMD ["courier"]
