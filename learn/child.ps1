try {
  Write-Output "aaaaaa" >$null 2>&1
  Write-Output "hello world"
  aaaa # 意図的にここでエラー
  exit 0
}
catch {
  Write-Error "Something went wrong!"
  exit 1
}