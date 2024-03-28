. ".env.ps1"
. $GOODBYEUSBPASS
. $PLAYPASS
. $LOGPASS

#USBが挿入さえていればplay.ps1を、挿入されていなければgoodbyeUsb.ps1を起動する。
# Does usb exist? -> no: showing a message -> exit 1
function init() {

# create new file if not exists
  if (-not (Test-Path $LOGFILE)) {
    New-Item -Path $LOGFILE -ItemType File
  }


  $usb = (Get-Volume |
    Where-Object drivetype -eq removable).DriveLetter

  if ($null -eq $usb) {
    # add log info to  txt
    Log("USB not found!!!!")

    # show messages->goobyUsb.ps1
    # goodbyeUsb ここにfunctionを入れる
    Add-Type -Assembly System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("
    USB is disconnected. Please insert the USB.", "alert")


    break
  } else {
    Log("USB is connected.")
    Add-Type -Assembly System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("
    USB is connected.", "success")
    # play.ps1のメイン関数を起動
    main

    break
  }
}

init