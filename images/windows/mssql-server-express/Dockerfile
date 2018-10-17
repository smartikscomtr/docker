FROM microsoft/windowsservercore:1803
LABEL maintainer="murat.atay@smartiks.com.tr"

ENV sa_password="_" \
    ACCEPT_EULA="_" \
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR /

RUN Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=829176" -OutFile sqlexpress.exe; \
    Start-Process -Wait -FilePath .\sqlexpress.exe -ArgumentList /qs, /x:setup; \
    .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\System' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS /SQLUSERDBDIR=C:\MSSQL\Data /SQLUSERDBLOGDIR=C:\MSSQL\Data /SQLBACKUPDIR=C:\MSSQL\Backup; \
    Remove-Item -Recurse -Force sqlexpress.exe, setup; \
    Stop-Service MSSQL`$SQLEXPRESS

RUN Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value ''; \
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433; \
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\' -name LoginMode -value 2

COPY start.ps1 /

CMD .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -Verbose