ARG WINDOWS_VERSION

FROM smartikscomtr/chocolatey:latest-windowsservercore-${WINDOWS_VERSION} as stage-1

ARG DOCKER_DISTRIBUTION_VERSION

ARG DOCKER_BUILDTAGS="include_oss include_gcs"

ENV DOCKER_DISTRIBUTION_VERSION ${DOCKER_DISTRIBUTION_VERSION}

ENV DOCKER_BUILDTAGS ${DOCKER_BUILDTAGS}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN choco install golang

RUN choco install git

WORKDIR /Users/ContainerAdministrator/go/src/github.com/docker/distribution

RUN git clone -q https://github.com/docker/distribution .; \
    git checkout -q v${env:DOCKER_DISTRIBUTION_VERSION}; \
    go get github.com/tools/godep 2>&1; \
    Start-Process -FilePath godep.exe -ArgumentList go, build, ./cmd/registry -Wait


FROM microsoft/windowsservercore:${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

COPY --from=stage-1 /Users/ContainerAdministrator/go/src/github.com/docker/distribution/registry.exe /bin/registry.exe

ENTRYPOINT ["/bin/registry.exe"]