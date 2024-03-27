	# vlcを終了
	Stop-process -name "C:\Program Files\VLC\vlc.exe" >${NULL} 2>&1

	# alertを表示
	Add-Type -Assembly System.Windows.Forms
	[System.Windows.Forms.MessageBox]::Show("
	USB is disconnected. Please insert the USB.", "alert")