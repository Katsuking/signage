. "env.ps1"
. $logpass



###############################################
# ENV

$mmdd = Get-Date -Format "MMdd"
$LOGFILE = "$PSScriptRoot/logs/$mmdd.log"
# to show a message
Add-Type -Assembly System.Windows.Forms
$EXTS = @('.mp4', '.mkv', '.mov', '.avi', '.wmv')
$VLC = "C:\Program Files\VLC\vlc.exe"
$PLAYLIST = "$PSScriptRoot/playlist.m3u"

###############################################

# create new file if not exists
if (-not (Test-Path $LOGFILE)) {
  New-Item -Path $LOGFILE -ItemType File
}



# Does usb exist? -> no: showing a message -> exit 1
function init() {
  $usb = (Get-Volume |
    Where-Object drivetype -eq removable).DriveLetter

  if ($null -eq $usb) {
    # add log info to  txt
    Log("USB not found!!!!")
    # show messages
    [System.Windows.Forms.MessageBox]::Show("USB not found!!", "Error Message")
    Write-Error "USB is not found"
    exit 1
  } else {
    Log("USB is connected.")
  }
}

# get the usb path
function getUsbPath() {
  $FlashDrives = (get-volume | Where-Object drivetype -eq removable).DriveLetter
  $usb_root_dir = "$FlashDrives`:\"
  return $usb_root_dir
}

# create a playlist based on usb -> play videos
function playAllInPlayList() {
  # M3U file header
  $header = "#EXTM3U"
  Set-Content -Path $PLAYLIST -Value $header

  # get the usb path
  $usb_root_dir = getusbPath

  # add video paths to playlist.m3u.
  Get-ChildItem $usb_root_dir |
    Where-Object { $EXTS -contains $_.Extension } |
    ForEach-Object { $_.FullName } |
    ForEach-Object {
      Add-Content -Path $PLAYLIST -Value $_ }

  try {
    $proc = Start-Process -FilePath $VLC -ArgumentList $PLAYLIST, "-I dummy", "--fullscreen" ,"--loop" -passthru # , "--loop"

    if ($Null -eq $proc.id) {
      Write-Output $proc.Id
      Log("could not get VLC process id. retry count:$retryCount")
      continue
    } else {
      return $proc.id
      break
    }
  }
  catch {
    Log("Could not play all playlist. retry count: $retryCount ")
  }
}

function main() {
  # Does usb exists? -> no: showing messages
  try {
    init
  }
  catch {
    Log("Excuting init is failed.")
    exit 1
  }

  # try 3 times
  $retryCount = 0
  while ($retryCount -lt 4) {
    # play videos
    $procId = playAllInPlayList
    if ( $null -eq $procId) { # failed
      Log("failed to play. $retryCount")
      $retryCount += 1
    } else {
      return $procId
      break # success
    }
  }
}

# prevent an inflinite loop.
$procId = main
start-sleep -seconds 20 # play for 50 secs
stop-process -id $procId

# an infinite loop
# $threshold = 1073741824  # 1 GB bytes

# while ($true) {
#     $memoryUsage = (Get-Process -Id $procId).WorkingSet
#     if ($memoryUsage -gt $threshold) {
#         Stop-Process -Id $procId
#         break
#     }
#     Start-Sleep -Seconds 5
# }

