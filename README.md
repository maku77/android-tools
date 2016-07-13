# android-tools

Android アプリ開発者用の簡易ツールです。
このリポジトリを clone して、そのディレクトリに PATH を通せば使用できます。
Python や Ruby を使用しているスクリプトを実行する場合は、あらかじめ実行環境をインストールしておく必要があります。


logcat-elapsed-time
----

Android の logcat 出力のタイムスタンプを経過時間に変換するスクリプトです。

logcat 出力におけるタイムスタンプは、`07-11 21:59:30.567` といった日時表示になっていますが、プログラムの実行速度などを計測したい場合などは、単純な経過時間になっていた方が便利だったりします。
そのような場合にこのスクリプトを使用すると、時刻表示部分を `1.234` のような相対的な経過秒数に変換してくれます。
相対時間のベースとなる時間は、logcat ログの中で最初に登場した日時です。

例えば、通常の logcat の時刻表示は下記のような感じですが、

```
07-13 12:33:50.639  2136  2151 E GmsClient: Calling connect() while still connected, missing ...
07-13 12:33:50.640   486   614 W ActivityManager: Unable to start service Intent { act=com.g ...
07-13 12:33:50.641   486  1830 W ActivityManager: Unbind failed: could not find connection f ...
07-13 12:33:50.641  2136  2151 E GmsClient: unable to connect to service: com.google.android ...
07-13 12:33:50.641  2136  2151 E .AppDataSearchProvider: Could not connect to AppDataSearchC ...
07-13 12:33:50.643  2136  2151 E GmsClient: Calling connect() while still connected, missing ...
```

このスクリプトを通すと、下記のように先頭時間を `0.000` 秒とした経過秒数に変換してくれます。

```
$ logcat-elapsed-time log.txt

0.000  2136  2151 E GmsClient: Calling connect() while still connected, missing disconnect() ...
0.001   486   614 W ActivityManager: Unable to start service Intent { act=com.google.android ...
0.002   486  1830 W ActivityManager: Unbind failed: could not find connection for android.os ...
0.002  2136  2151 E GmsClient: unable to connect to service: com.google.android.gms.icing.IN ...
0.002  2136  2151 E .AppDataSearchProvider: Could not connect to AppDataSearchClient for onT ...
0.004  2136  2151 E GmsClient: Calling connect() while still connected, missing disconnect() ...
```

logcat の出力をリアルタイム変換しながら出力することもできます。

```
$ adb logcat | logcat-elapsed-time
```


android-list-components
----

AndroidManifest.xml で定義されている各種コンポーネント (Activity, Service, BroadcastReceiver, ContentProvider) を一覧表示します。

#### 使用方法
```
$ android-list-components YourApp/AndroidManifest.xml
```

