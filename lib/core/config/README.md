# core/config（強制アップデート / メンテナンスモード）

サーバー配信の設定で、古いビルドに更新を強制したり、アプリ全体をメンテナンス表示に切り替える仕組み。
`AppConfigGate`（`app/app.dart` の MaterialApp.builder）が全画面をラップして判定する。

- 設定キー: `min_build_number`（これ未満のビルドは強制アップデート画面）/ `maintenance_mode` / `maintenance_message`
- 判定は起動時1回。取得失敗（オフライン等）はデフォルト値で **fail-open**（通常起動）
- ストア誘導 URL は `core/constants/app_links.dart` の `storePage`（要差し替え）

## バックエンド別の設定方法

- **Firebase**: Console > Remote Config でパラメータ `min_build_number` / `maintenance_mode` / `maintenance_message` を作成して公開する（未作成でもデフォルト値で動く）。反映はアプリ再起動時、キャッシュは最大5分
- **Supabase**: `supabase/migrations/20260728000000_app_config.sql` を適用し、ダッシュボードの Table Editor で `app_config` テーブル（1行）を編集する

## 動作確認の手順

1. `maintenance_mode` を true にして公開 → アプリを再起動（Remote Config はキャッシュ5分に注意）→ メンテナンス画面が出る
2. `min_build_number` を現在のビルド番号より大きい値にして公開 → 再起動 → 強制アップデート画面が出る

## この機能を削除する手順

1. `lib/core/config/` を削除する
2. `test/core/config/` を削除する
3. `lib/app/app.dart` から `builder:` の `AppConfigGate` ラップと import を削除する
4. `lib/core/constants/app_links.dart` から `storePage` を削除する
5. pubspec.yaml から `firebase_remote_config` を削除する（`package_info_plus` は他で未使用なら削除可）
6. arb から `appConfig` で始まるキー（ja は `@appConfig...` も）を削除する
7. `supabase/migrations/` の app_config の SQL を削除する（新規プロジェクトに適用しない場合）
8. 再生成: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
9. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
