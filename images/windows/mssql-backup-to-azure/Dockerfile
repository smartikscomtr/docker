ARG WINDOWS_VERSION

FROM smartikscomtr/chocolatey:latest-windowsservercore-${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

RUN choco install sqlserver-cmdlineutils

RUN choco install sql2017-dacframework

RUN choco install azcopy

COPY rootfs/ /

WORKDIR /Backup

ENTRYPOINT []

CMD /bin/mssql-backup-to-azure.ps1