.PHONY: clean get refresh format analyze test build-runner run build-apk build-ios

# キャッシュとビルドファイルの削除
clean:
	fvm flutter clean

# パッケージの取得
get:
	fvm flutter pub get

# クリーンアップとパッケージ再取得（よく環境がバグった時に使います）
refresh:
	fvm flutter clean
	fvm flutter pub get

# コードのフォーマット
format:
	dart format .

# 静的解析（Lintエラーのチェック）
analyze:
	fvm flutter analyze

# テストの実行
test:
	fvm flutter test

# build_runnerによるコード自動生成（Freezed, Riverpod, json_serializable等を導入している場合に重宝します）
br:
	dart run build_runner build --delete-conflicting-outputs

# # アプリケーションのデバッグ実行
# run:
# 	flutter run

# # Android (APK) のビルド
# build-apk:
# 	flutter build apk

# # iOSのビルド
# build-ios:
# 	flutter build ios
