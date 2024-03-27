# log
function Log($text) {
  $formatted_date = Get-Date -Format "yyyy/MM/dd_HH:mm:ss"
  Write-Output "$formatted_date $text" >> $LOGFILE
}