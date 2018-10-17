# The script sets the sa password and start the SQL Service

param(
[Parameter(Mandatory=$false)]
[string]$sa_password,

[Parameter(Mandatory=$false)]
[string]$ACCEPT_EULA
)

if ($ACCEPT_EULA -ne "Y" -And $ACCEPT_EULA -ne "y")
{
    Write-Verbose "ERROR: You must accept the End User License Agreement before this container can start."
    Write-Verbose "Set the environment variable ACCEPT_EULA to 'Y' if you accept the agreement."
    exit 1 
}

Write-Verbose "Starting SQL Server"
Start-Service MSSQL`$SQLEXPRESS

if ($sa_password -eq "_") {
    $secretPath = $env:sa_password_path
    if (Test-Path $secretPath) {
        $sa_password = Get-Content -Raw $secretPath
    }
    else {
        Write-Verbose "WARN: Using default SA password, secret file not found at: $secretPath"
    }
}

if ($sa_password -ne "_")
{
    Write-Verbose "Changing SA login credentials"
    $sqlcmd = "ALTER LOGIN sa with password='$($sa_password)'; ALTER LOGIN sa ENABLE"
    & sqlcmd -Q $sqlcmd
}

Write-Verbose "Attaching Existing Databases"
$mdfFiles = Get-ChildItem -Path "C:\MSSQL\Data" -Filter *.mdf
ForEach ($mdfFile in $mdfFiles)
{
    $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '$($mdfFile.BaseName)') BEGIN EXEC sp_detach_db [$($mdfFile.BaseName)] END; CREATE DATABASE [$($mdfFile.BaseName)] ON (FILENAME = N'C:\MSSQL\Data\$($mdfFile.BaseName).mdf'), (FILENAME = N'C:\MSSQL\Data\$($mdfFile.BaseName)_log.ldf') FOR ATTACH"
    Write-Verbose $sqlcmd
    & sqlcmd -Q $sqlcmd
}

Write-Verbose "Started SQL Server"

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) 
{ 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}
