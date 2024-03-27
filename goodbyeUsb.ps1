	# # vlcを終了
	Get-process "C:\Program Files\VLC\vlc.exe" | 2> Out-Null
	if ( $pro -ne $null ) {
	Stop-process -name "C:\Program Files\VLC\vlc.exe" | 2> Out-Null
	}


	Add-Type -Assembly System.Windows.Forms
	[System.Windows.Forms.MessageBox]::Show("
	USB is disconnected. Please insert the USB.", "alert")