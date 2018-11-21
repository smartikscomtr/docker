ARG WINDOWS_VERSION

FROM microsoft/windowsservercore:${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

ARG REDIS_VERSION

ENV REDIS_VERSION ${REDIS_VERSION}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest -Uri "https://github.com/MSOpenTech/redis/releases/download/win-${env:REDIS_VERSION}/Redis-x64-${env:REDIS_VERSION}.zip" -OutFile redis.zip -UseBasicParsing; \
    Expand-Archive redis.zip -dest /bin/redis; \
    Remove-Item redis.zip -Force

EXPOSE 6379

ENTRYPOINT ["/bin/redis/redis-server.exe"]

CMD ["--bind", "0.0.0.0", "--protected-mode", "no"]