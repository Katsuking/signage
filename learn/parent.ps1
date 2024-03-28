# $PSScriptRoot は, shell でいうところの $(dirname $0)

. "$PSScriptRoot\child.ps1" # child.ps1 を実行する
write-output $? # child.ps1が異常終了した場合、false
Write-Output $LASTEXITCODE # 1 になるはず
Write-Output "$PSScriptRoot\child.ps1"
