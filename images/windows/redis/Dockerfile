FROM microsoft/windowsservercore:1803
LABEL maintainer="murat.atay@smartiks.com.tr"

ENV REDIS_VERSION 3.2.100
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest $('https://github.com/MSOpenTech/redis/releases/download/win-{0}/Redis-x64-{0}.zip' -f $env:REDIS_VERSION) -OutFile 'redis.zip'; \
    Expand-Archive redis.zip -dest /redis; \
    Remove-Item redis.zip -Force

RUN (Get-Content /redis/redis.windows.conf) \
    -Replace '^(bind)\s.*$', '$1 0.0.0.0' \
    -Replace '^(protected-mode)\s.*$', '$1 no' | \
    Set-Content /redis/redis.docker.conf

EXPOSE 6379

ENTRYPOINT ["/redis/redis-server.exe", "/redis/redis.docker.conf"]