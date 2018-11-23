Write-Host "Starting SQL Server"

Start-Service MSSQL`$SQLEXPRESS


Write-Host "Changing SA Password"

$sqlcmd = "ALTER LOGIN sa with password='${env:SA_PASSWORD}'; ALTER LOGIN sa ENABLE"

& sqlcmd -Q $sqlcmd


Write-Host "Attaching Existing Databases"

$mdfFiles = Get-ChildItem -Path C:\MSSQL\Data -Filter *.mdf

ForEach ($mdfFile in $mdfFiles)
{
    $dbName = $mdfFile.BaseName;

    Write-Host "Attaching ${dbName}"

    $sqlcmd = "IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME = '${dbName}') BEGIN EXEC sp_detach_db [${dbName}] END; CREATE DATABASE [${dbName}] ON (FILENAME = N'C:\MSSQL\Data\${dbName}.mdf'), (FILENAME = N'C:\MSSQL\Data\${dbName}_log.ldf') FOR ATTACH"

    & sqlcmd -Q $sqlcmd
}


Write-Host "Started SQL Server"

$eventLastCheckDate = (Get-Date).AddSeconds(-2)

while ($true) 
{ 
    Get-EventLog -LogName Application -Source "MSSQL*" -After ${eventLastCheckDate} | Select-Object TimeGenerated, EntryType, Message

    $eventLastCheckDate = Get-Date 

    Start-Sleep -Seconds 2 
}