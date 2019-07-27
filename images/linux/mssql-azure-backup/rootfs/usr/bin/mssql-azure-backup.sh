while true; do
  date=`date +%Y%m%d%H%M`

  sqlcmd -S $SOURCE_SERVER_NAME -U $SOURCE_USER -P $SOURCE_PASSWORD -Q "SET NOCOUNT ON; SELECT name FROM sys.databases WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')" -h -1 \
  | while read -r line ; do
    databaseName=$(echo $line | awk '{gsub(/^ +| +$/,"")} {print $0}')

    sqlpackage /Action:Export /SourceServerName:$SOURCE_SERVER_NAME /SourceUser:$SOURCE_USER /SourcePassword:$SOURCE_PASSWORD /SourceDatabaseName:$databaseName /TargetFile:./${databaseName}_${date}.bacpac
  done

  azcopy copy . "$AZURE_DESTINATION?$AZURE_SAS_TOKEN"

  rm -rf *

  sleep="sleep ${INTERVAL}m"

  $sleep
done
