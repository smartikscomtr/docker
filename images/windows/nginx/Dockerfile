ARG WINDOWS_VERSION

FROM microsoft/windowsservercore:${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

ARG NGINX_VERSION

ENV NGINX_VERSION ${NGINX_VERSION}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN Invoke-WebRequest -Uri "https://nginx.org/download/nginx-${env:NGINX_VERSION}.zip" -OutFile nginx.zip -UseBasicParsing; \
    Expand-Archive nginx.zip -dest /; \
    New-Item -Type Directory -Path /bin; \
    Move-Item -Path "/nginx-${env:NGINX_VERSION}" -Destination /bin/nginx; \
    Remove-Item nginx.zip -Force

EXPOSE 80 443

WORKDIR /bin/nginx

ENTRYPOINT ["/bin/nginx/nginx.exe"]

CMD ["-g", "\"daemon off; worker_processes 1; error_log stderr info;\""]