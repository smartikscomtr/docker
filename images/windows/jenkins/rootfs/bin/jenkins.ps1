$jenkinsDirectoryInfo = Get-ChildItem -Path /bin/jenkins | Measure-Object

If ($jenkinsDirectoryInfo.Count -eq 0)
{
  Copy-Item -Path /bin/jenkins-init/* -Destination /bin/jenkins -Recurse

  Remove-Item -Path /bin/jenkins-init -Recurse
}

java -jar /bin/jenkins.war