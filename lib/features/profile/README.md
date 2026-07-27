# profile

プロフィールの表示・編集（表示名・アバター画像 = Supabase Storage）。
設定画面から `/settings/profile` で遷移する。DB 定義は `supabase/migrations/20260727000000_profiles.sql`（profiles テーブル + avatars バケット）。

- `domain/profile.dart` — profiles テーブルと対応するモデル
- `data/profile_repository.dart` — profiles テーブル / avatars Storage への読み書き
- `presentation/` — 表示画面 + 編集画面（表示名の保存・アバターのアップロード）

## この機能を削除する手順

1. `lib/features/profile/` を削除する
2. `test/features/profile/` を削除する
3. `lib/core/router/routes.dart` から以下を削除する
   - profile 画面2つの import
   - `TypedGoRoute<ProfileRoute>`（`ProfileEditRoute` 含むブロック）
   - `ProfileRoute` / `ProfileEditRoute` クラス
4. `lib/features/settings/presentation/settings_screen.dart` からプロフィールの `ListTile` を削除する
5. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `profile` で始まるキー（ja は `@profile...` も）を削除する
6. pubspec.yaml から `image_picker` を削除し、`ios/Runner/Info.plist` の `NSPhotoLibraryUsageDescription` を削除する
7. `supabase/migrations/` の profiles / avatars 関連 SQL を削除する（新規プロジェクトに適用しない場合）
8. 再生成: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
9. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
