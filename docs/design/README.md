# docs/design — デザインカンプの版管理

Claude Design（claude.ai/design）で作成したデザインカンプの実体をここに置く。
**このディレクトリのファイルが「カンプの現物」、`DESIGN.md` が「そこから抽出した仕様の正」。**

## ファイル

| ファイル | 中身 |
| --- | --- |
| `Screens Pure Mono.dc.html` | 採用案（Pure Mono）の全画面カンプ。00 トークン → 07 ゲート画面 → 08 Flutter 実装者向け引き継ぎ |
| `Design Directions.dc.html` | 方向性の比較検討（採用案 = 3a Pure Mono）。採用理由をたどるための履歴 |
| `support.js` | 上記 `.dc.html` を単体のブラウザで開くためのランタイム。Claude Design が生成したもので**手で編集しない** |

## 見る

```
open "docs/design/Screens Pure Mono.dc.html"
```

`support.js` を同じディレクトリに置いてあるので、ローカルで開けばそのまま描画される
（Web フォントの取得にのみネットワークを使う）。

## 更新する

カンプは Claude Design 側が原本。ローカルの HTML を手で直さず、次の順で回す。

1. Claude Design のプロジェクトでカンプを更新する
   （プロジェクト URL: `https://claude.ai/design/p/b48105bd-c5a9-4de6-991a-334b49e74b03`）
2. Claude Code で `claude_design` MCP の `DesignSync` を使って `get_file` し、このディレクトリへ上書きする
3. 変わった仕様を `DESIGN.md`（§2〜§7）へ反映する
4. コードを直す

**HTML を直したのに `DESIGN.md` を直していない状態を作らないこと。** 実装が参照するのは `DESIGN.md` であり、
このディレクトリの HTML は「なぜそうなっているか」を確認するための一次資料として使う。

## 版管理の方針

- `.dc.html` / `support.js` はテキストなので Git で差分が追える。バイナリの書き出し（PNG 等）はコミットしない
- 1回のデザイン変更 = 1コミットにまとめ、コミットメッセージに変更した画面名を書く
- 過去案（`Design Directions.dc.html`）は消さない。「なぜ Pure Mono を選んだか」の根拠が失われるため
