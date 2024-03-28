. ".env.ps1"
. $goodbyeUsbPass
. $PLAYPASS
. $LOGPASS

#USBが挿入さえていればplay.ps1を、挿入されていなければgoodbyeUsb.ps1を起動する。
# Does usb exist? -> no: showing a message -> exit 1
function init() {
  $usb = (Get-Volume |
    Where-Object drivetype -eq removable).DriveLetter

  if ($null -eq $usb) {
    # add log info to  txt
    Log("USB not found!!!!")
    # show messages->goobyUsb.ps1
    return # goodbyeUsbPass ここにfunctionを入れる
    break
  } else {
    Log("USB is connected.")
    return main
  }
}



getUsbPath()