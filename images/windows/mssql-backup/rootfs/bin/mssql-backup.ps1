While ($true)
{
  $date = Get-Date -Format "yyyyMMddhhmm"

  $databases = & "C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD.EXE" -S ${env:SOURCE_SERVER_NAME} -U ${env:SOURCE_USER} -P ${env:SOURCE_PASSWORD} -Q "SET NOCOUNT ON; SELECT name FROM sys.databases WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')" -h -1

  ForEach ($database In $databases)
  {
    $databaseName = $database.Trim()

    & "C:\Program Files\Microsoft SQL Server\140\DAC\bin\SqlPackage.exe" /a:Export /ssn:${env:SOURCE_SERVER_NAME} /su:${env:SOURCE_USER} /sp:${env:SOURCE_PASSWORD} /sdn:${databaseName} /tf:${databaseName}_${date}.bacpac

    Write-Host
  }

  & "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy\AzCopy.exe" /Source:. /Dest:${env:AZURE_DESTINATION} /DestKey:${env:AZURE_DESTINATION_KEY} /S /XO

  Write-Host

  Remove-Item -Path * -Recurse -Force

  Write-Host

  Start-Sleep -Seconds (60 * ${env:Interval})

  Write-Host
}