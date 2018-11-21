ARG WINDOWS_VERSION

FROM microsoft/windowsservercore:${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -Uri http://aka.ms/downloadazcopy -OutFile azcopy.msi -UseBasicParsing; \
    Start-Process -FilePath msiexec.exe -ArgumentList '/i', 'azcopy.msi', '/quiet', '/norestart' -NoNewWindow -Wait; \
    Remove-Item -Path azcopy.msi -Force

ENTRYPOINT ["\"/Program Files (x86)/Microsoft SDKs/Azure/AzCopy/AzCopy.exe\""]

CMD ["/?"]