ARG WINDOWS_VERSION

FROM microsoft/windowsservercore:${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -Uri "https://chocolatey.org/install.ps1" -UseBasicParsing | Invoke-Expression; \
    choco feature enable --name allowGlobalConfirmation; \
    choco feature disable --name showDownloadProgress

ENTRYPOINT ["choco"]