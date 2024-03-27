#vlcを終了
	$pro = Get-process C:\Program Files\VLC\vlc.exe
	if ( $pro -ne $null ) {
	Stop-process -name C:\Program Files\VLC\vlc.exe
	}


Add-Type -Assembly System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Good Bye Usb!!", "ハロー")