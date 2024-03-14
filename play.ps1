
###################################
### 事前作業
# ポリシーの変更
# Set-ExecutionPolicy RemoteSigned

#### vlc 側の設定
# vlc 側で字幕表示をとめる
# 動画再生時に画面を最大にすること
###################################

###############################################
# ENV
$OutputEncoding='utf-8' # 意味ないかも
$mmdd = Get-Date -Format "MMdd"
$LOGFILE = "./logs/$mmdd.log"
# なければ, 202403のようなyyyymd のファイルを作成
# アセンブリの読み込み
Add-Type -Assembly System.Windows.Forms
$EXTS = @('.mp4', '.mkv', '.mov', '.avi', '.wmv')
$VLC = '"C:\Program Files\VLC\vlc.exe"'
$PLAYLIST = "./playlist.m3u"

# 現在のディレクトリのパスを取得
$cwd = (Convert-Path .)
###############################################

# Log の書き込み
function Log($text) {
  $formatted_date = Get-Date -Format "yyyy/MM/dd_HH:mm:ss"
  Write-Output "$formatted_date $text" >> $LOGFILE
}

# usbの存在確認 -> なければメッセージ表示 -> 異常終了
function init() {
  $usb = (Get-Volume |
    Where-Object drivetype -eq removable).DriveLetter

  if ($null -eq $usb) {
    # ログの記録 -> txtファイルに記載
    Log("USB not found!!!!")
    # メッセージボックスの表示
    [System.Windows.Forms.MessageBox]::Show("USB not found!!", "Error Message")
    Write-Error "USB is not found"
    exit 1
  } else {
    Log("USB is connected.")
  }
}

# usb の pathを取得
function getUsbPath() {
  $FlashDrives = (get-volume | Where-Object drivetype -eq removable).DriveLetter
  $usb_root_dir = "$FlashDrives`:\"
  return $usb_root_dir
}

# ログの作成
function Log($text) {
  $formatted_date = Get-Date -Format "yyyy/MM/dd_HH:mm:ss"
  Write-Output "$formatted_date $text" >> $LOGFILE
}

# playlist 作成 -> 動画再生
function playAllInPlayList() {
  # M3Uファイルのヘッダー
  $header = "#EXTM3U"
  Set-Content -Path $PLAYLIST -Value $header

  # usb pathの取得
  $usb_root_dir = getusbPath

  # USBにある各動画をplaylistに追記
  Get-ChildItem $usb_root_dir |
    Where-Object { $EXTS -contains $_.Extension } |
    ForEach-Object { $_.FullName } |
    ForEach-Object {
      Add-Content -Path $PLAYLIST -Value $_ }

  # 3回数リトライ
  $retryCount = 0
  while ($retryCount -lt 4) {
    try {
      $proc = Start-Process -FilePath $VLC -ArgumentList $PLAYLIST, "-I dummy", "--fullscreen" ,"--loop" -passthru # , "--loop"
      # start-sleep -seconds 5 # プロセスIDを取得できるか確認
      # stop-process -id $proc.id #
      if ($Null -eq $proc.id) {
        $retryCount += 1
        Log("could not get VLC process id. retry count:$retryCount")
        continue
      } else {
        return $proc.id
        break
      }
    }
    catch {
      Log("Could not play all playlist. retry count: $retryCount ")
      $retryCount += 1
    }
  }

}

function main() {
  # USBの存在確認と画面の警告表示
  try {
    init
  }
  catch {
    Log("Excuting init is failed.")
    exit 1
  }
  # 動画再生
  $procId = playAllInPlayList
  return $procId
}

# 無限に動くので、一定時間で止まるの
$procId = main
start-sleep -seconds 50 # 50秒だけ 動画を流す
stop-process -id $procId

# 無限ループ
# $threshold = 1073741824  # 1GBをバイトで表した値

# while ($true) {
#     $memoryUsage = (Get-Process -Id $procId).WorkingSet
#     if ($memoryUsage -gt $threshold) {
#         Stop-Process -Id $procId
#         break
#     }
#     Start-Sleep -Seconds 5
# }


