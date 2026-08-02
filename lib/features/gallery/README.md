# gallery — UI パーツのギャラリー（デバッグ専用）

`DESIGN.md` §5（共通コンポーネント仕様）の実物カタログ。タイポグラフィ・ボタン・
入力欄・共通ウィジェット・状態表示・ダイアログ / ボトムシートを1画面で確認できる。
**release ビルドではルートがホームへリダイレクトする**ので本番には露出しない。

## 開き方

アプリを dev flavor で起動しておく:

```sh
fvm flutter run --flavor dev --dart-define-from-file=env/dev.json
```

### iOS シミュレータ（ディープリンク）

```sh
xcrun simctl openurl booted "tech.tetrabox.flutterAppTemplate.dev:///gallery"
```

- スキームは **iOS の Bundle ID そのもの**（`ios/Runner/Info.plist` の
  `CFBundleURLSchemes` に `$(PRODUCT_BUNDLE_IDENTIFIER)` を登録してあるため、
  flavor 別に自動で変わり、`tool/rename.dart` でのリネームにも追従する）
- パスは `://gallery` ではなく **`:///gallery`**（`//` の直後は host 扱いになり、
  go_router にパスが渡らない）
- 「"アプリ名" で開きますか?」の確認ダイアログが出るので「開く」をタップする
  （カスタムスキームを外部から開くときの iOS 標準挙動）

### Android エミュレータ / 実機（ディープリンク）

intent-filter は不要（コンポーネント直指定なら任意の URI を渡せる）:

```sh
adb shell am start \
  -n tech.tetrabox.flutter_app_template.dev/tech.tetrabox.flutter_app_template.MainActivity \
  -a android.intent.action.VIEW -d "app:///gallery"
```

`-n` は `<applicationId>/<namespace>.MainActivity`。リネーム後は両方読み替える。

### アプリ内から

デバッグ中に任意の画面へ一時的に足す:

```dart
const GalleryRoute().push(context);
```

### 未ログインの場合

認証リダイレクトの対象なのでログイン画面へ飛ぶが、`?from=/gallery` に退避され
ログイン後にギャラリーへ復帰する。

## 運用ルール

`lib/core/widgets/` にパーツを追加したら、`gallery_screen.dart` にもサンプルを
1つ足す（`DESIGN.md` §5）。画面内の文言は開発者向けサンプルデータなので
l10n 対象外（ARB に開発専用キーを混ぜない）。

## コピー先アプリで不要な場合の削除手順

1. `lib/features/gallery/` を削除
2. `lib/core/router/routes.dart` の `GalleryRoute` ブロックと import を削除
3. `fvm dart run build_runner build --delete-conflicting-outputs`
4. `test/design_layout_test.dart` の `gallery` の行（screens と noSettleScreens）を削除
5. `DESIGN.md` §5 の「パーツギャラリー」の項を削除
