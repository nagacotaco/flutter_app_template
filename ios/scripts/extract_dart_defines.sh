#!/bin/sh

# 参考:https://zenn.dev/altiveinc/articles/separating-environments-in-flutter#ios%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AB%E5%BF%85%E8%A6%81%E3%81%AA%E5%AF%BE%E5%BF%9C

# Dart defineを書き出すファイルパスを指定します。
# ここでは `Dart-Defines.xcconfig` というファイル名で作成することにします。
OUTPUT_FILE="${SRCROOT}/Flutter/Dart-Defines.xcconfig"
# Dart defineの中身を変更した時に古いプロパティが残らないように、初めにファイルを空にしています。
: > $OUTPUT_FILE

# この関数でDart defineをデコードします。
function decode_url() { echo "${*}" | base64 --decode; }

IFS=',' read -r -a define_items <<<"$DART_DEFINES"

for index in "${!define_items[@]}"
do
    item=$(decode_url "${define_items[$index]}")
    # Dartの定義にはFlutter側で自動定義された項目も含まれます。
    # しかし、それらの定義を書き出してしまうとエラーによりビルドができなくなるので、
    # flutterやFLUTTERで始まる項目は出力しないようにしています。
    lowercase_item=$(echo "$item" | tr '[:upper:]' '[:lower:]')
    if [[ $lowercase_item != flutter* ]]; then
        echo "$item" >> "$OUTPUT_FILE"
    fi
done