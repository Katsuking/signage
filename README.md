# シンプルなサイネージを windows で作る

以下は メモ

powershell だけ使ってやってみる
logs はあえて.gitignore には入れない

### Todos

- ログを yyyy/mmdd/ に吐くようにしたい
- usb から drive に移したほうがいい
- エラーメッセージが小さい
- プロセスが異常時に再リトライできるか

### 事前作業

ポリシーの変更
Set-ExecutionPolicy RemoteSigned

### 要件

- USB 内の動画利用する
- 4k 出力
- USB がない場合は、エラーメッセージを画面に出すこと

などなど

## vlc の設定

- vlc 側で字幕表示をとめる

- 動画再生時に画面を最大にすること

### shell:startup で起動させる

-WindowStyle Hidden でコンソールをだしっぱなしにしないようにする
絶対パスを渡す

```bat
powershell -WindowStyle Hidden -ExecutionPolicy Unrestricted -File C:\Users\oplan\Documents\signage\play.ps1
```
