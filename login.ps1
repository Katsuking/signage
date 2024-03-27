. ".env.ps1"
. $goodbyeUsbPass

#USBが挿入さえていればplay.ps1を、挿入されていなければgoodbyeUsb.ps1を起動する。
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

function getUsbPath() {
  $FlashDrives = (get-volume | Where-Object drivetype -eq removable).DriveLetter
  $usb_root_dir = "$FlashDrives`:\"
  return $usb_root_dir
}

getUsbPath()