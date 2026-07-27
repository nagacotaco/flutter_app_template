# flutter_app_template

新規アプリの土台となる Flutter テンプレート。コピーして各アプリの開発を始める。
開発計画・フェーズ管理は `docs/DEVELOPMENT_PLAN.md`。

## 必読ドキュメント

- IMPORTANT: 画面を新規作成・変更する前に `docs/ARCHITECTURE.md` を必ず読む（Screen/ViewModel/State の厳格ルール）
- 機能追加・方針変更をしたら `docs/DEVELOPMENT_PLAN.md` を更新する

## コマンド

flutter は必ず fvm 経由で実行する。

- 起動: `fvm flutter run --flavor dev --dart-define-from-file=env/dev.json`（flavor 必須。本番接続は prod）
- flavor 定義の変更: pubspec.yaml の `flavorizr:` を編集 → `fvm dart run flutter_flavorizr -f`
- 静的解析: `fvm flutter analyze` と `fvm dart run custom_lint`（riverpod_lint）
- テスト: `fvm flutter test`
- コード生成（freezed / riverpod / go_router）: `fvm dart run build_runner build --delete-conflicting-outputs`
- 文言生成: `fvm flutter gen-l10n`
- アプリアイコン再生成: `assets/icon/icon.png`（本番）/ `icon_dev.png`（dev）を差し替え → `fvm dart run flutter_launcher_icons`（flavor 別に自動生成）

## 構造ルール（要約。正は docs/ARCHITECTURE.md）

- feature-first: `lib/features/<feature>/{domain,data,presentation}`。feature 間の import 禁止
- 1画面 = `xxx_screen.dart`（HookConsumerWidget）+ `xxx_view_model.dart`（@riverpod）+ `xxx_state.dart`（freezed）
- `StatefulWidget` / `setState` 禁止。一時 UI 状態は flutter_hooks
- 文言のコード直書き禁止。`lib/core/l10n/arb/` に追加して `context.l10n.xxx` で参照
- 共通ウィジェット・テーマ・グローバル状態は `lib/core/`

## テンプレート運用の前提

- 全機能入りで実装し、コピー後に不要な feature を削除する方式
- 「1ディレクトリ削除 + router 登録数行削除」で機能を消せる削除容易性を壊さないこと
- 対象プラットフォームは iOS / Android のみ
