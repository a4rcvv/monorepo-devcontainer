# monorepo-devcontainer

モノレポっぽい環境で単一のdevcontainerを作るとどうなるかテスト


## Multi-root workspace

Multi-root workspaceを作るとルートごとに仮想環境の設定などを行えて捗りそう．設定は`monorepo-devcontainer.code-workspace`

[Multi-root Workspaces in Visual Studio Code](https://code.visualstudio.com/docs/editor/multi-root-workspaces)

## .devcontainerの中身

### イメージ
python, nodeの実行環境を準備

supervisord, lefthookなど，devcontaienr featuresでインストールできないツールも仕方がないのでここでインストール

### compose.yml

開発用コンテナのボリュームマウント設定，外部コンテナ(postgresなど)の定義など

ここで開発用コンテナがlaunch.shを起動するように設定

### devcontainer.json

compose.ymlを読み込む

devcontainer features でgitやtaskfileなどをインストール

拡張機能などの設定も追加

### launch.sh

ボリュームマウントしたディレクトリの所有権をrootからvscodeに変更

全パッケージをインストール

supervisordを起動

### supervisord.conf

開発用サーバーを起動

