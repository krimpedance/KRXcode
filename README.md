# Krxcode

Xcode 周りの手抜きツール.

+ プロジェクト生成 (MVP|MVVM|CleanArchitecture)
+ モジュールファイル群の生成

## Installation

```ruby
# Gemfile
gem 'KRXcode', git: 'git@github.com:krimpedance/KRXcode.git'
```

もしくは,

```bash
$ gem specific_install git@github.com:krimpedance/KRXcode.git
```

## Usage

`krxcode help` で一覧見れます

### プロジェクト生成

以下のコマンドを実行, 必要な項目を埋めるとプロジェクトが生成されます.

```bash
$ krxcode g project
```

### モジュール（画面）生成

モジュールに必要なファイル群をテンプレートから生成, プロジェクトに追加します.

```bash
$ krxcode g module [モジュール名]
```

設定情報は `KRXcode.yml` を編集します.

+ `TemplateDirectory` : テンプレートディレクトリのパス
+ `ProjectRoot` : プロジェクトのルートディレクトリのパス
+ `ProjectFileName` : プロジェクトファイル名 (`MyProject.xcodeproj`)
+ `Target` : ターゲット名
+ `Organization` : 組織名
+ `GenerateRoot` : 生成したファイルを置くディレクトリのパス（プロジェクト内でもこのパスに生成します）

特定の設定ファイルを読み込ませたいときは以下のようにします.

```bash
$ krxcode g module [モジュール名] --config=MyConfig.yml
```
