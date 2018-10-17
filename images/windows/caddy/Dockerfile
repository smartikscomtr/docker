FROM microsoft/windowsservercore:1803
LABEL maintainer="murat.atay@smartiks.com.tr"

ENV CADDY_VERSION 0.11.0
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest 'https://caddyserver.com/download/windows/amd64?plugins=tls.dns.cloudflare&license=personal&telemetry=off' -OutFile 'caddy.zip'; \
    Expand-Archive -Path caddy.zip -DestinationPath /caddy -Force; \
    Remove-Item caddy.zip

ENTRYPOINT ["/caddy/caddy.exe"]