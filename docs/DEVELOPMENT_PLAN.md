# Flutter App Template 開発計画

このドキュメントはテンプレートの「何を入れるか」「どの順で作るか」「どう運用するか」を管理する唯一の計画書。
機能追加・方針変更のたびにこのファイルを更新する（Living Document）。

- 最終更新: 2026-07-27
- ステータス: Phase 0〜5 すべて完了。以降の追加は Backlog から選定する

---

## 1. 目的

新規アプリ開発時にこのリポジトリをコピーし、**序盤の立ち上げ速度を最大化する**こと。

- どのアプリにも存在する画面・仕組み（認証、ナビゲーション、設定、プロフィール等）を実装済みにしておく
- アプリ固有の判断が必要な部分はテンプレートに含めない（過剰設計しない）
- 「全部入り → コピー後に不要機能を削除」方式。Claude Code に「電話番号ログインを削除して」と指示すれば消せる構造を保つ

## 2. 確定した技術スタック

| 項目 | 決定 | 備考 |
|---|---|---|
| バックエンド/認証 | **Supabase / Firebase 切替式** | `lib/core/backend.dart` で切替（現在は firebase）。認証は AuthRepository 抽象の2実装。電話番号認証はどちらもテスト電話番号+固定OTPで確認可能。**profile（DB/Storage）は現状 Supabase 実装のみ**（Firebase 対応は Backlog） |
| 状態管理 | **Riverpod** | riverpod_generator + flutter_hooks（コード生成ベース） |
| ルーティング | **go_router** (Typed Routes) | go_router_builder で型安全。`/items/:id` 形式でディープリンク対応 |
| 機能の取捨選択 | **全部入り + コピー後に削除** | feature 単位でディレクトリ分離し、削除が1ディレクトリ+登録箇所数行で済む構造にする |
| 環境分け | **dev / prod flavor** | Bundle ID・アプリ名・Supabase 接続先を分離 |
| Flutterバージョン管理 | **fvm** | .fvmrc をリポジトリに含める |
| 多言語 | **l10n の下地**（日本語ベース） | arb ファイル構成。文言のコード直書き禁止 |
| CI | **GitHub Actions** | analyze + test の最小構成から |
| 対象プラットフォーム | iOS / Android | web/desktop ディレクトリは削除（必要なら再生成できる） |

## 3. ディレクトリ構成方針（feature-first）

```
lib/
├── app/                  # アプリのルート（MaterialApp, テーマ, 起動処理）
├── core/                 # 全 feature 共通の基盤
│   ├── router/           # go_router 定義（Typed Routes）
│   ├── supabase/         # Supabase クライアント初期化
│   ├── theme/            # ThemeData, カラー, テキストスタイル
│   ├── l10n/             # arb / 生成コード
│   └── widgets/          # 共通ウィジェット
└── features/             # 機能単位。1機能 = 1ディレクトリ
    ├── auth/             # ログイン/サインアップ（メール・電話・Google・Apple）
    ├── home/             # ボトムナビ + ホーム
    ├── items/            # リスト/詳細のサンプル（ディープリンク実証用）
    ├── profile/          # プロフィール表示・編集
    └── settings/         # 設定画面
```

**削除容易性のルール（重要）:**

- feature 間の直接 import 禁止。画面遷移は router 経由、データ共有は core 経由
- 1 feature を消す手順が「`features/xxx/` 削除 + router の登録数行削除 + pubspec の専用パッケージ削除」で完結すること
- 各 feature 直下に `README.md` を置き、「この機能を削除する手順」を書く（AI への削除指示が確実になる）

## 4. フェーズ計画

### Phase 0: プロジェクト基盤（最初にやる）

- [x] ARCHITECTURE.md 作成（画面 = Screen/ViewModel/State 3ファイル構成の厳格ルール。詳細は docs/ARCHITECTURE.md）
- [x] fvm 導入、Flutter バージョン固定（3.44.8、.fvmrc）
- [x] web/linux/macos/windows ディレクトリ削除
- [x] pubspec に基本依存を追加（hooks_riverpod, go_router, supabase_flutter, freezed, l10n ほか）
- [x] analysis_options.yaml 強化（riverpod_lint, custom_lint, strict モード）
- [x] ディレクトリ構成の骨組み作成（app/ core/ features/）
- [x] テーマ（ライト/ダーク、seed カラー方式）+ l10n 下地（ja/en, `context.l10n`）
- [x] .vscode/settings.json, launch.json, extensions.json
- [x] CLAUDE.md 作成（テンプレートの構造・規約を AI に伝える。コピー後のアプリでもそのまま機能する内容にする）

### Phase 1: ナビゲーションとルーティング

- [x] go_router + go_router_builder で Typed Routes 定義（core/router/routes.dart）
- [x] StatefulShellRoute によるボトムナビゲーション（ホーム/アイテム/設定、タブ状態保持）
- [x] サンプルのリスト画面 → 詳細画面（`/items/:id`）。features/items/ が見本実装（正）
- [x] ディープリンク設定手順ドキュメント（docs/DEEP_LINKS.md）。OS 側設定はドメイン確定後にコピー先で実施

### Phase 2: 認証（Supabase）

- [x] Supabase 初期化 + 認証状態を監視する Riverpod プロバイダ（core/supabase, core/auth）
- [x] 認証状態による redirect（未ログイン → ログイン画面。core/router/app_router.dart）
- [x] メール+パスワード: ログイン / サインアップ / パスワードリセット（features/auth）
- [x] 電話番号ログイン（OTP）。SMS プロバイダ未契約でも動作確認できるよう Supabase のテスト OTP を利用
- [x] Google ログイン / Apple ログイン（ネイティブサインイン → signInWithIdToken。設定手順は lib/features/auth/README.md）
- [x] ログアウト / アカウント削除（AuthRepository に実装。画面は Phase 3 の設定画面に配置）

### Phase 3: プロフィール・設定

- [x] profiles テーブル定義（`supabase/migrations/20260727000000_profiles.sql`。RLS・サインアップトリガー・退会 RPC・avatars バケット込み）
- [x] プロフィール画面（表示・編集・アバター画像アップロード = Supabase Storage。features/profile、/settings/profile）
- [x] 設定画面: テーマ切替・言語切替（core/settings、shared_preferences 永続化）
- [x] 設定画面の残り: 利用規約/プライバシーポリシーリンク（core/constants/app_links.dart は要差し替え）、アプリバージョン表示、ログアウト、退会

### Phase 4: flavor と環境変数

- [x] dev / prod flavor（flutter_flavorizr で生成。定義は pubspec.yaml の flavorizr セクションが正。変更時は `fvm dart run flutter_flavorizr -f`）
- [x] Supabase URL / anon key を --dart-define-from-file で切替（env/dev.json, env/prod.json → lib/core/env/app_env.dart）
- [x] launch.json に flavor 別の起動構成を追加
- [x] アプリ名の flavor 別出し分け（Template Dev / Template）
- [x] アプリアイコンの flavor 別出し分け（flutter_launcher_icons。`assets/icon/icon.png`（本番）/ `icon_dev.png`（dev バッジ相当）はプレースホルダー。コピー先で差し替え → `fvm dart run flutter_launcher_icons`）

### Phase 5: CI・品質

- [x] GitHub Actions: format check + analyze + custom_lint + test（.github/workflows/ci.yaml）
- [x] 基本のテスト雛形（widget テスト1本 + ViewModel ユニットテスト見本 `test/features/items/`。書き方は docs/ARCHITECTURE.md §6）
- [x] 各 feature 直下に削除手順 README.md（セクション3の削除容易性ルールの実装）

### Backlog（今後の候補。着手順は都度このドキュメントで決める）

- **profile の Firebase 対応**（ProfileRepository を抽象化し Firestore + Storage 実装を追加。Storage は Blaze プラン必須のためアバターの扱いは要判断）
- Firebase 電話番号認証の iOS 本番設定（APNs / URL scheme）
- プッシュ通知（Supabase + FCM）
- 強制アップデート / メンテナンスモードの仕組み
- Sentry によるクラッシュレポート
- アプリ内課金（RevenueCat）の下地
- オンボーディング（初回起動時のウォークスルー）
- Web View 画面の雛形（利用規約表示等）
- スケルトンローディング・エラー/空状態の共通 UI パターン
- コピー後の初期化スクリプト（アプリ名・Bundle ID 一括リネーム）
- マルチプラットフォーム展開（web / macos / windows）。ディレクトリは `fvm flutter create --platforms=web,macos,windows .` で再生成できる。着手時は flavor・認証リダイレクト・ディープリンクの各プラットフォーム対応もスコープに含めること

## 5. テンプレートのコピー手順（運用）

1. このリポジトリをコピー（`git clone` → `.git` 削除 → 新規リポジトリ化）
2. アプリ名・Bundle ID をリネーム（Backlog のスクリプト完成までは Claude Code に指示）。アプリアイコンは `assets/icon/icon.png`（本番）と `icon_dev.png`（dev）を差し替えて `fvm dart run flutter_launcher_icons` を実行
3. 新規 Supabase プロジェクトを作成し、`supabase/migrations/` を適用、env ファイルにキー設定
4. 不要な機能を削除（例:「電話番号ログインと Apple ログインを削除して」と Claude Code に指示）
5. アプリ固有の開発を開始

## 6. 進め方のルール

- **1 Phase = 1 まとまり**として順番に完了させる。並行着手しない
- 各 Phase 完了時にこのドキュメントのチェックボックスを更新し、コミットする
- 新しい要望が出たらまず Backlog に追記し、着手判断は Phase の区切りで行う（作業の割り込みを防ぐ）
- 完成度は「実案件でコピーして困らない」が基準。テンプレート自体を磨き込みすぎない
