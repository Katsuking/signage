## 参考

[USBの抜き差し](https://jo-sys.net/usb-log/)

## シンプルなサイネージを windows で作る

以下は メモ

powershell だけ使ってやってみる
logs はあえて `.gitignore` には入れない

### Todos

- ログを yyyy/mmdd/ に吐くようにしたい
- usb から drive に移したほうがいい
- エラーメッセージが小さい
- プロセスが異常時に再リトライできるか

### 事前作業

ポリシーの変更
`Set-ExecutionPolicy RemoteSigned`

### 要件

- USB 内の動画利用する
- 4k 出力
- USB がない場合は、エラーメッセージを画面に出すこと

などなど

## VLC の設定

- VLC 側で字幕表示をとめる

- 動画再生時に画面を最大にすること

## shell:startup で起動させる

`-WindowStyle Hidden` でコンソールをだしっぱなしにしないようにする
絶対パスを渡す

```bat
powershell -WindowStyle Hidden -ExecutionPolicy Unrestricted -File C:\Users\oplan\Documents\signage\play.ps1
```

### システムアプリを削除

消していいのかは、正直わかりません。

下記の例では、MS store を削除

`Get-appxpackage` を使用すると、パッケージがたくさん取得できます。

```powershell
Get-appxpackage *windowsstore* | Remove-AppxPackage
```

復元する場合、下記の通りです。

```powershell
Get-AppXPackage *WindowsStore* -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
```

### USB log が保存されている場合

管理者権限 で開く

```powershell
Get-WinEvent -path "C:\Windows\System32\winevt\Logs\Microsoft-Windows-DriverFrameworks-UserMode%4Operational.evtx"
```

### schedular から VLC を止める

`-Force` が必須かも

```powershell
Stop-Process -Force -Name "VLC" >$null 2>&1
```
