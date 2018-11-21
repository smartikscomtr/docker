ARG WINDOWS_VERSION

FROM microsoft/windowsservercore:${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest -Uri 'https://caddyserver.com/download/windows/amd64?plugins=tls.dns.cloudflare&license=personal&telemetry=off' -OutFile caddy.zip; \
    Expand-Archive -Path caddy.zip -DestinationPath /bin/caddy -Force; \
    Remove-Item caddy.zip

ENTRYPOINT ["/bin/caddy/caddy.exe"]