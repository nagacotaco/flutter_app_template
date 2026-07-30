# flutter_app_template

新規アプリの土台となる Flutter テンプレート。コピーして各アプリの開発を始める。
開発計画・フェーズ管理は `docs/DEVELOPMENT_PLAN.md`。

## 必読ドキュメント

- IMPORTANT: 画面を新規作成・変更する前に `docs/ARCHITECTURE.md` を必ず読む（Screen/ViewModel/State の厳格ルール）
- IMPORTANT: 見た目に関わる変更（`lib/core/theme/` / `lib/core/widgets/` / `*_screen.dart` / 新規文言の追加）の前に `DESIGN.md` を必ず読む（デザイン仕様 Pure Mono の正）
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
- コピー直後のリネーム: `fvm dart run tool/rename.dart --name "MyApp" --bundle-id com.example.myapp`（`--dry-run` で事前確認。アプリ名・Bundle ID の定義元は pubspec.yaml の `flavorizr:`。`flutter_flavorizr -f` は iOS の手動設定を壊すのでリネームでは使わない）

## 構造ルール（要約。正は docs/ARCHITECTURE.md）

- feature-first: `lib/features/<feature>/{domain,data,presentation}`。feature 間の import 禁止
- 1画面 = `xxx_screen.dart`（HookConsumerWidget）+ `xxx_view_model.dart`（@riverpod）+ `xxx_state.dart`（freezed）
- `StatefulWidget` / `setState` 禁止。一時 UI 状態は flutter_hooks
- 文言のコード直書き禁止。`lib/core/l10n/arb/` に追加して `context.l10n.xxx` で参照
- 共通ウィジェット・テーマ・グローバル状態は `lib/core/`

## デザインルール（要約。正は DESIGN.md）

方向性は **Pure Mono**「色を捨てて、字の大小だけで語る」。

- 色は無彩色のみ。有彩色を足すのはコピー先アプリが `seedColor` / `primary` / `onPrimary` を差し替えるときだけ
- カード・境界線・影・Divider で階層を作らない。階層は **余白 × 字の太さ × 字の大きさ** で作る
- 状態を色で表さない（エラー＝太字＋下線＋「！」／無効＝不透明度 30%／選択＝塗り）。SnackBar は使わずインライン表示
- 新規の共通ウィジェットは `lib/core/widgets/` にのみ置く（feature 間 import を作らない）
- 実装ステータスは未着手（仕様のみ）。着手・進捗は `docs/DEVELOPMENT_PLAN.md` の Backlog「UI 刷新（Pure Mono）」で管理

## テンプレート運用の前提

- 全機能入りで実装し、コピー後に不要な feature を削除する方式
- 「1ディレクトリ削除 + router 登録数行削除」で機能を消せる削除容易性を壊さないこと
- 対象プラットフォームは iOS / Android のみ
