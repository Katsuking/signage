$ROOTPASS = "C:\Users\oplan\Desktop\signage"

$LOGPASS = "$ROOTPASS\util\log.ps1"
$LOGINPASS = "$ROOTPASS\login.ps1"
$ALLERTDELETEPASS = "$ROOTPASS\allertDelete.ps1"
$GOODBYEUSBPASS = "$ROOTPASS\doodbyeUsb.ps1"
$PLAYPASS = "$ROOTPASS\goodbyeUsbPass"
$mmdd = Get-Date -Format "MMdd"
$LOGFILE = "$ROOTPASS/logs/$mmdd.log"
$EXTS = @('.mp4', '.mkv', '.mov', '.avi', '.wmv')
$VLC = "C:\Program Files\VLC\vlc.exe"
$PLAYLIST = "$ROOTPASS/playlist.m3u"


