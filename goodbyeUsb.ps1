<<<<<<< HEAD
#vlcを終了
=======
	#vlcを終了
>>>>>>> 987f4d5120d80773bc4f885799c303a7c1e3308f
	$pro = Get-process C:\Program Files\VLC\vlc.exe
	if ( $pro -ne $null ) {
	Stop-process -name C:\Program Files\VLC\vlc.exe
	}


Add-Type -Assembly System.Windows.Forms
<<<<<<< HEAD
[System.Windows.Forms.MessageBox]::Show("Good Bye Usb!!", "ハロー")
=======
[System.Windows.Forms.MessageBox]::Show("
USB is disconnected. Please insert the USB.", "alert")
>>>>>>> 987f4d5120d80773bc4f885799c303a7c1e3308f
