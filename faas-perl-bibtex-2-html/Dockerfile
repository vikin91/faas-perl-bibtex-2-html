FROM perl:5.26

RUN apt-get update -qy \
    && apt-get install -qy --no-install-recommends \
       curl ca-certificates \
       ocaml libbtparse-dev libdbd-mysql-perl \
    && echo "Pulling watchdog binary from Github." \
    && curl -sSL https://github.com/alexellis/faas/releases/download/0.6.13/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog \
    && apt-get -qy remove curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cpanm Carton

WORKDIR /root/

COPY index.pl .
COPY cpanfile .

RUN carton install

COPY function function

WORKDIR /root/function/
COPY function/cpanfile .
RUN carton install

WORKDIR /root/

ENV fprocess="carton exec perl index.pl"

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
