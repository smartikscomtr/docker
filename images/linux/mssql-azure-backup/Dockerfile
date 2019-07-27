FROM golang:alpine as builder

RUN apk add --no-cache git && rm -rf /var/cache/apk/*

RUN go get -u github.com/Azure/azure-storage-azcopy

WORKDIR /go/src/github.com/Azure/azure-storage-azcopy

ENV GOOS linux
ENV GARCH amd64
ENV CGO_ENABLED 0

RUN go install -v -a -installsuffix cgo

FROM ubuntu:16.04

LABEL maintainer="yasin.akar@smartiks.com.tr"

COPY --from=builder /go/bin/azure-storage-azcopy /usr/bin/azcopy

RUN apt-get update && \
    apt-get install -y ca-certificates curl apt-transport-https debconf-utils locales unzip && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql mssql-tools && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/sqlpackage/bin && \
    curl -L https://go.microsoft.com/fwlink/?linkid=2087431 -o /tmp/sqlpackage.zip &&  \
    unzip /tmp/sqlpackage.zip -d /opt/sqlpackage/bin &&  \
    chmod +x /opt/sqlpackage/bin/sqlpackage &&  \
    rm -f /tmp/sqlpackage.zip

RUN echo '{'                                                  >  /opt/sqlpackage/bin/sqlpackage.runtimeconfig.json
RUN echo '    "runtimeOptions": {'                            >> /opt/sqlpackage/bin/sqlpackage.runtimeconfig.json
RUN echo '        "configProperties": {'                      >> /opt/sqlpackage/bin/sqlpackage.runtimeconfig.json
RUN echo '            "System.Globalization.Invariant": true' >> /opt/sqlpackage/bin/sqlpackage.runtimeconfig.json
RUN echo '        }'                                          >> /opt/sqlpackage/bin/sqlpackage.runtimeconfig.json
RUN echo '    }'                                              >> /opt/sqlpackage/bin/sqlpackage.runtimeconfig.json
RUN echo '}'                                                  >> /opt/sqlpackage/bin/sqlpackage.runtimeconfig.json

ENV PATH="${PATH}:/opt/mssql-tools/bin:/opt/sqlpackage/bin"

RUN locale-gen en_US.UTF-8

RUN update-locale LANG=en_US.UTF-8

COPY rootfs/ /

WORKDIR /backup

ENTRYPOINT ["/bin/bash"]

CMD ["/usr/bin/mssql-azure-backup.sh"]
