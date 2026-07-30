# profile

プロフィールの表示・編集。設定画面から `/settings/profile` で遷移する。
バックエンドは `lib/core/backend.dart` で切り替わる（auth と同じ仕組み）:

- **Supabase**: profiles テーブル + avatars Storage。DB 定義は `supabase/migrations/20260727000000_profiles.sql`。アバター画像のアップロードに対応
- **Firebase**: Firestore は使わず Firebase Auth のユーザープロフィール（displayName / photoURL）に保存。アバター画像は Firebase Storage の `avatars/{uid}/avatar` にアップロードし、ダウンロード URL を photoURL に保存する

## Firebase Storage のセットアップ（コピー先で必要）

Firebase Storage は **Blaze プラン（従量課金）が前提**。アバターアップロードを使う場合のみ:

1. Firebase Console でプロジェクトを Blaze プランに変更する
2. Console の Storage タブから Storage を有効化する（デフォルトバケット作成）
3. セキュリティルールをデプロイする: `firebase deploy --only storage`（ルール本体はリポジトリルートの `storage.rules`。avatars 配下のみ読み取り公開・書き込みは本人限定）

Blaze 化しない場合は `firebase_profile_repository.dart` の `supportsAvatarUpload` を `false` に戻せば、編集画面からアバター変更 UI が消える（Google / Apple ログイン時の自動設定分の表示はそのまま動く）。

動作確認は実機不要で以下で可能（実 Firebase の dev プロジェクトに捨てアカウントを作って upload → 削除する）:

```sh
fvm flutter test integration_test/avatar_upload_test.dart \
  --flavor dev --dart-define-from-file=env/dev.json -d <シミュレータのデバイスID>
```

注意: firebase_storage はネイティブプラグインのため、追加後は hot reload / hot restart では反映されない。アプリを完全に停止して `fvm flutter run` からビルドし直すこと。

ファイル構成:

- `domain/profile.dart` — プロフィールのモデル
- `data/profile_repository.dart` — 抽象インターフェース + 実装切替 provider。`supportsAvatarUpload` でアバター変更 UI の表示を制御
- `data/supabase_profile_repository.dart` / `data/firebase_profile_repository.dart` — 各バックエンド実装
- `presentation/` — 表示画面 + 編集画面（表示名の保存・アバターのアップロード）

## この機能を削除する手順

1. `lib/features/profile/` を削除する
2. `test/features/profile/` と `integration_test/avatar_upload_test.dart` を削除する
3. `lib/core/router/routes.dart` から以下を削除する
   - profile 画面2つの import
   - `TypedGoRoute<ProfileRoute>`（`ProfileEditRoute` 含むブロック）
   - `ProfileRoute` / `ProfileEditRoute` クラス
4. `lib/features/settings/presentation/settings_screen.dart` からプロフィールの `_LinkRow` を削除する
5. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `profile` で始まるキー（ja は `@profile...` も）を削除する。ただし `profileNotSet` は設定画面のアカウント欄でも使っているので残すか差し替える
   `test/design_layout_test.dart` の `screens` から `'profile'` / `'profileEdit'` の行と `profileRepositoryProvider` の override も削除する
6. pubspec.yaml から `image_picker` と `firebase_storage` を削除し、`ios/Runner/Info.plist` の `NSPhotoLibraryUsageDescription` を削除する
7. `supabase/migrations/` の profiles / avatars 関連 SQL を削除する（新規プロジェクトに適用しない場合）。ルートの `storage.rules` と firebase.json の `storage` キーも削除する
8. 再生成: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
9. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
