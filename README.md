# issues_viewer

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# issues_viewer

# フォルダ構成
flutter_issues_viewer/
├── lib/
│   ├── models/
│   │   ├── issue.dart
│   │   └── label.dart
│   ├── repositories/
│   │   ├── github_api.dart
│   │   ├── github_repository.dart
│   │   └── issues_repository.dart
│   ├── ui/
│   │   ├── issue_list/
│   │   │   ├── issue_list.dart
│   │   │   └── issue_tile.dart
│   │   ├── label_tab/
│   │   │   ├── label_tab.dart
│   │   │   └── label_tile.dart
│   │   ├── loading_indicator.dart
│   │   ├── main_page.dart
│   │   └── my_app.dart
│   └── utils/
│       ├── constants.dart
│       ├── enums/
│       │   └── issue_state.dart
│       └── strings.dart
├── test/
│   ├── models/
│   │   ├── issue_test.dart
│   │   └── label_test.dart
│   └── repositories/
│       ├── github_api_test.dart
│       ├── github_repository_test.dart
│       └── issues_repository_test.dart
├── pubspec.yaml
└── README.md
```

- `services`フォルダは削除し、`repositories`フォルダにAPI通信を行うためのファイルをまとめます。
- `github_api.dart`は、API通信に関する処理をまとめたクラスです。
- `github_repository.dart`は、`GithubApi`クラスを利用してAPI通信を行い、レスポンスを`Issue`モデルに変換する処理をまとめたクラスです。
- `issue_repository.dart`は、各種ラベルに対応する`GithubRepository`をまとめたクラスであり、`GithubRepository`クラスを利用してAPI通信を行います。

ファイル名は以下のようになると良いでしょう。

- `issue.dart`: Issueモデルの定義
- `label.dart`: Labelモデルの定義
- `github_service.dart`: Github APIを扱うサービスの定義
- `issue_list.dart`: Issueリストを表示するウィジェットの定義
- `issue_tile.dart`: Issueを表示するウィジェットの定義
- `label_tab.dart`: ラベルごとのIssueリストを表示するタブの定義
- `label_tile.dart`: ラベルを表示するウィジェットの定義
- `loading_indicator.dart`: 読み込み中である旨のUI表示を行うウィジェットの定義
- `main_page.dart`: アプリのメインページの定義
- `my_app.dart`: アプリのエントリーポイントの定義
- `constants.dart`: 定数の定義（例えばGithub APIのURLなど）
- `issue_test.dart`: Issueモデルのテストの定義
- `label_test.dart`: Labelモデルのテストの定義
- `github_service_test.dart`: Github APIを扱うサービスのテストの定義
