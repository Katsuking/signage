Add-Type -Assembly System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Good Bye Usb!!", "ハロー")

1	#メモ帳を終了
2	$pro = Get-process notepad
3	if ( $pro -ne $null ) {
4	Stop-process -name notepad
5	}