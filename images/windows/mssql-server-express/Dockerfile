ARG WINDOWS_VERSION

FROM microsoft/windowsservercore:${WINDOWS_VERSION}

LABEL maintainer="murat.atay@smartiks.com.tr"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=829176 -OutFile sqlexpress.exe -UseBasicParsing; \
    Start-Process -FilePath sqlexpress.exe -ArgumentList /qs, /x:setup -Wait; \
    /setup/setup.exe /q /ACTION=Install /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\\System' /SQLSYSADMINACCOUNTS='BUILTIN\\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS /SQLUSERDBDIR=C:\MSSQL\Data /SQLUSERDBLOGDIR=C:\MSSQL\Data /SQLBACKUPDIR=C:\MSSQL\Backup; \
    Remove-Item -Path setup -Recurse -Force; \
    Remove-Item -Path sqlexpress.exe -Recurse -Force; \
    Stop-Service MSSQL`$SQLEXPRESS

RUN Set-ItemProperty -Path 'HKLM:\\software\\microsoft\\microsoft sql server\\mssql14.SQLEXPRESS\\mssqlserver\\supersocketnetlib\\tcp\\ipall' -Name tcpdynamicports -Value ''; \
    Set-ItemProperty -Path 'HKLM:\\software\\microsoft\\microsoft sql server\\mssql14.SQLEXPRESS\\mssqlserver\\supersocketnetlib\\tcp\\ipall' -Name tcpport -Value 1433; \
    Set-ItemProperty -Path 'HKLM:\\software\\microsoft\\microsoft sql server\\mssql14.SQLEXPRESS\\mssqlserver\\' -Name loginmode -Value 2

COPY rootfs/ /

EXPOSE 1433

CMD /bin/mssql-server-express.ps1