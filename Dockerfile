ARG CARDIGANN_VER=1.10.1

FROM spritsail/alpine:3.7 as builder

ARG CARDIGANN_VER
ARG REPO=github.com/cardigann/cardigann

ARG GOPATH=/tmp/go
ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64

WORKDIR $GOPATH/src/$REPO

RUN apk --no-cache add curl g++ gcc git go make nodejs \
    \
 && curl -fsSL "https://$REPO/tarball/v$CARDIGANN_VER" \
        | tar xz --strip-components=1 \
    \
    # setting ARG does not work
 && export PATH=$GOPATH/bin:$PATH \
 && make setup \
 && (cd web && npm install) \
 && make statics \
 && make test \
 && go build -o /cardigann -ldflags="-X main.Version=v$CARDIGANN_VER -w -s" *.go

# ~~~~~~~~~~~~~~~~~~~~~~

FROM spritsail/alpine:3.7

ARG CARDIGANN_VER
ENV SUID=913 \
    SGID=900 \
    CONFIG_DIR=/config

LABEL maintainer="Spritsail <cardigann@spritsail.io>" \
      org.label-schema.vendor="Spritsail" \
      org.label-schema.name="Cardigann" \
      org.label-schema.url="https://github.com/cardigann/cardigann" \
      org.label-schema.description="A proxy server for adding new indexers to Sonarr, SickRage and other media managers" \
      org.label-schema.version=${CARDIGANN_VER} \
      io.spritsail.version.cardigann=${CARDIGANN_VER}

COPY --from=builder /cardigann /usr/bin/
RUN apk --no-cache add ca-certificates

VOLUME $CONFIG_DIR
EXPOSE 5060

ENTRYPOINT ["/sbin/tini", "--", "su-exec", "--env"]
CMD ["/usr/bin/cardigann", "server"]
