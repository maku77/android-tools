# android-tools

Android アプリ開発者用の簡易ツールです。
このリポジトリを clone して、そのディレクトリに PATH を通せば使用できます。
Python や Ruby を使用しているスクリプトを実行する場合は、あらかじめ実行環境をインストールしておく必要があります。

android-list-components
----

AndroidManifest.xml で定義されている各種コンポーネント (Activity, Service, BroadcastReceiver, ContentProvider) を一覧表示します。

#### 使用方法
```
$ android-list-components YourApp/AndroidManifest.xml
```
