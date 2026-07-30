# DESIGN.md — flutter_app_template UI 刷新仕様（Pure Mono）

Flutter / Material 3 / iOS・Android のみ。ライト・ダーク両対応、日本語・英語両対応。
既存13画面の見た目のみを刷新し、画面・機能は追加しない。

デザインカンプ: `Screens Pure Mono.dc.html`（00 トークン → 07 ゲート画面 → 08 引き継ぎ）
方向性比較の経緯: `Design Directions.dc.html`（採用案 = 3a Pure Mono）

---

## 0. この文書の使い方（Claude Code 向け）

- **参照タイミング** — 次のいずれかに触れる作業の前に、このファイル全体を読む。
  - `lib/core/theme/`（ThemeData / ColorScheme / TextTheme）
  - `lib/core/widgets/`（共通ウィジェット）
  - `lib/features/**/presentation/*_screen.dart`（画面の見た目・レイアウト）
  - `lib/core/l10n/arb/`（文言の新規追加。§7 のキーと重複させない）
- **他ドキュメントとの優先順位** — 構造ルール（`docs/ARCHITECTURE.md`）が上位。衝突したら ARCHITECTURE を守り、この文書側を直す。この文書が正なのは「見た目」だけ。
- **更新ルール** — 実装がこの仕様とズレたら、コードを黙って通すのではなく先にこの文書を直す（Living Document）。トークン・タイポグラフィ・コンポーネント仕様を変えたら §2〜§5 を必ず更新する。
- **実装ステータス** — **未着手（仕様のみ）**。現状の `app_theme.dart` は seed `#2962FF` の Material 3 デフォルトで、Noto Sans JP / Archivo も未導入。進捗は `docs/DEVELOPMENT_PLAN.md` の Backlog「UI 刷新（Pure Mono）」で管理する。
- **カンプの所在** — 上記2つの `.dc.html` はリポジトリに未コミット。手元にあれば `docs/design/` に置く。無くてもこの文書だけで実装できる粒度で書いてある。
- **絶対に崩さない3点**（詳細を読む前でもこれだけは守る）— ①無彩色のみ（有彩色は seed 差し替え時のみ）②カード・境界線・影・Divider で階層を作らない ③状態を色で表現しない（エラー＝太字＋下線＋「！」）。

---

## 1. 方向性

**Pure Mono** — 「色を捨てて、字の大小だけで語る」

- カード・境界線・影・Divider を使わない。階層は **余白 × 字の太さ × 字の大きさ** だけで作る
- 色は原則無彩色。エラーは色ではなく **太字＋下線＋「！」** で示す
- 特定業種に寄らない中立な骨格。コピー先アプリは seed カラーを差し替えるだけで着色できる
- Material 3 デフォルトの「トーナル面が多用された無個性さ」を、面の廃止によって脱する

---

## 2. カラートークン

`ColorScheme.fromSeed(seedColor: #111111)` の結果を `copyWith` で上書きする。**dynamicColor（Material You）は使わない。**

### ライト

| ロール | 値 |
| --- | --- |
| surface | `#F1F1EF` |
| onSurface | `#111111` |
| onSurfaceVariant | `#6E6E6B` |
| primary | `#111111` |
| onPrimary | `#F1F1EF` |
| outline | `#B5B5B1` |
| outlineVariant | `#D8D8D4` |
| error / onErrorContainer | `#111111` |
| surfaceContainer / -Low / -High / -Highest | すべて `#F1F1EF`（＝面を作らない） |

### ダーク

| ロール | 値 |
| --- | --- |
| surface | `#1C1C1C` |
| onSurface | `#F2F2F0` |
| onSurfaceVariant | `#9A9A97` |
| primary | `#F2F2F0` |
| onPrimary | `#1C1C1C` |
| outline | `#5A5A58` |
| outlineVariant | `#333331` |
| error / onErrorContainer | `#F2F2F0` |
| surfaceContainer 系 | すべて `#1C1C1C` |

補助値（スケルトン用）: ライト `#DEDEDA` / `#E8E8E4`、ダーク `#2C2C2A` / `#333331`

---

## 3. タイポグラフィ

- 和文: **Noto Sans JP**（400 / 500 / 700 / 800）
- 欧文・数字・日付・メール・バージョン: **Archivo**（400 / 500 / 600 / 700 / 800、tabular）
- 日本語は line-height を欧文より +0.15 確保する

| ロール | サイズ / ウェイト / 行間 / 字間 |
| --- | --- |
| displayLarge | 68 / w800 / 1.0 / -0.05em |
| displayMedium | 32 / w800 / 1.2 / -0.04em |
| headlineSmall | 27 / w800 / 1.25 / -0.035em |
| titleLarge | 20 / w700 / 1.3 / -0.02em |
| titleMedium | 14 / w700 / 1.4 |
| titleSmall | 12.5 / w500 / 1.4 |
| bodyLarge | 14 / w400 / 1.7 |
| bodyMedium | 13 / w400 / 1.65 |
| bodySmall | 11 / w400 / 1.6（onSurfaceVariant） |
| labelLarge（ボタン） | 13 / w600 |
| labelSmall（ラベル） | 10 / w400（onSurfaceVariant） |

displayLarge は「件数・ステップ番号」などの数値専用。画面見出しは displayMedium / headlineSmall。

---

## 4. スペーシング / 角丸 / エレベーション

```
space              4 / 8 / 12 / 16 / 24 / 32 / 48
画面左右パディング   24
ラベル→値           2
項目間              20
セクション間         32

radius  ボタン 8 ／ アバター full
radius  ダイアログ 12 ／ ボトムシート 16（上端のみ）
radius  その他（面・入力）すべて 0

入力欄  下線 1px（focus 2px）
elevation  全要素 0（AppBar scrolledUnderElevation も 0）
Divider    使用しない
hit target 最小 48
```

状態表現: エラー＝太字＋下線／無効＝不透明度 30%／選択＝塗り。**色に依存した表現は一切しない。**

---

## 5. 共通コンポーネント仕様（素の Material から変える点）

| コンポーネント | 変更内容 |
| --- | --- |
| FilledButton | radius 8 / 高さ 48 / labelLarge 13 w600 / elevation 0。disabled は onPrimary 30% |
| OutlinedButton | 同寸法、1px outline。ログイン手段の並列表示には使わない |
| TextButton | 太字＋下線（text-underline-offset 3〜4）。破壊的操作にも使う |
| TextField | `filled: false`、UnderlineInputBorder 1px（focus 2px）。floatingLabel は使わず、外側に labelSmall を置く |
| ListTile 行 | contentPadding 水平 0 / minVerticalPadding 0。leading アイコンと trailing chevron を削除。行間 20 |
| AppBar | elevation 0 / scrolledUnderElevation 0 / centerTitle **false**（左寄せ）。タイトルは titleSmall。長い日本語は body 側で再掲する |
| NavigationBar | `labelBehavior: alwaysHide`（**ラベルなし・アイコンのみ**）／indicatorColor transparent／選択＝塗りアイコン、非選択＝outlined／icon 22 / height 64 |
| Dialog | radius 12 / elevation 0 / 背景 surface / 1px outlineVariant 枠。ボタンは縦積み |
| BottomSheet | 上端 radius 16 / elevation 0 / ハンドル 34×3 |
| 円形アバター | AppAvatar に size 引数を追加し 64px。未設定は 20px の円アイコン、または頭文字を Archivo w700 |
| EmptyView | アイコン廃止。見出し（headlineSmall）＋説明（bodyMedium, variant）＋任意 CTA。左寄せ |
| ErrorView | 「！」（Archivo 大）＋下線付き見出し＋説明＋再試行 FilledButton。左寄せ |
| SkeletonListView | 無彩色バーのみ 6件。明度差は 8% → 3% に抑える |
| SnackBar | 使用しない。エラーは画面内インライン表示 |

### 新規コンポーネント（2件のみ）

- **LabelValue** `lib/core/widgets/label_value.dart`
  `LabelValue({required String label, required String value, Widget? trailing, bool mono = false})`
  labelSmall（onSurfaceVariant）＋間隔 2 ＋ titleMedium（onSurface）。`mono: true` で値を Archivo tabular に。値は maxLines 1 + ellipsis。
  *理由*: ラベル＋値の2段ペアが設定・プロフィール・ホーム・詳細の4画面で20箇所以上に出る。

- **DisplayHeader** `lib/core/widgets/display_header.dart`
  `DisplayHeader({required String title, String? meta, String? display, String? displayUnit})`
  title は titleSmall、meta は Archivo 10、display は displayLarge、unit は bodySmall をベースライン揃え。
  *理由*: 「小見出し＋日付＋大型数値」の画面冒頭パターンをホーム・アイテム一覧・設定で共通化。

これ以外は既存の EmptyView / ErrorView / SkeletonListView / AppAvatar / AppNetworkImage を流用する。

---

## 6. 画面ごとの変更点

- **ログイン** — Google / Apple / 電話番号の3つの OutlinedButton を画面から外し、TextButton「他の方法でログイン」→ `showModalBottomSheet` 内の ListTile 3行に移動。**ボタン数 5 → 1**。エラーは入力欄直下にインライン。送信中は主ボタン 30% ＋上部 2px LinearProgressIndicator。
- **アカウント登録 / パスワード再設定** — 送信後状態を「見出し（headlineSmall）＋説明（bodyMedium）＋『ログインに戻る』TextButton」に統一。中央寄せ → 左寄せ。
- **電話番号ログイン** — 上部に `STEP 1 — STEP 2` のテキストインジケータを追加。OTP 欄は Archivo、letterSpacing 0.42em。
- **アイテム一覧** — body 冒頭に件数の displayLarge を追加（既存の件数から算出）。Divider と trailing chevron を削除、行間 20。RefreshIndicator の色は onSurface。スケルトンは色を固定し 6件。空＝EmptyView、エラー＝ErrorView。
- **アイテム詳細** — body 冒頭にタイトル再掲（headlineSmall）＋メタ行（Updated / ID）。ローディングは CircularProgressIndicator → スケルトン（SkeletonListView のバリアント引数で対応）。
- **設定** — leading アイコンを全廃。テーマ・言語・アカウント・バージョンを2列グリッドの LabelValue に、プロフィール・規約・ポリシーはテキスト行に分離。DropdownButton は値のテキスト＋▼のみ（枠・下線なし）。退会は最下部に太字＋下線。エラーはインライン。
- **退会ダイアログ** — radius 12。**主ボタン（FilledButton）を「キャンセル」に割り当て**、「退会する」を TextButton（太字＋下線）に降格。ボタンは縦積み。モノクロでは色で危険を示せないため、誤タップ防止をボタンの階層で担保する。
- **オンボーディング** — 96px アイコン → 「01 / 02 / 03」の displayLarge。中央に差し替え用の空き領域（AspectRatio で確保）。インジケータのドット → 幅 26 / 12 の下線バー。文言は既存のまま。
- **プロフィール / プロフィール編集** — 中央 radius48 アバター → 左寄せ 64px、隣に表示名を headlineSmall。項目は LabelValue。編集は下線入力＋保存中 30% ＋上部 2px バー。
- **ホーム** — 中央のアプリ名テキストを廃止し、**差し替え前提の雛形**として「主数値（displayLarge）＋ LabelValue 2個＋直近3件＋差し替え領域の Placeholder（コメント付き）」を配置。データ源は既存の items プロバイダのみで、新規の集計ロジックは持たない。空状態は EmptyView を再利用。
- **メンテナンス / 強制アップデート** — 64px アイコン廃止、左寄せの大型見出し＋本文。見出しは2行想定、本文は最大6行で折り返す。強制アップデートに「現在 → 最新」バージョンのメタ行を追加（既存の取得値の表示のみ）。

---

## 7. 新規に必要な文言キー（全7件）

| KEY | JA | EN |
| --- | --- | --- |
| authOtherMethods | 他の方法でログイン | Other sign-in options |
| authBackToLogin | ログインに戻る | Back to sign in |
| phoneStepLabel | STEP {n} | STEP {n} |
| itemsCountUnit | 件 | items |
| itemsEmptyBody | 最初のアイテムを追加すると、ここに一覧が表示されます。 | Add your first item and it will appear here. |
| errorRetryBody | 通信状況を確認して、もう一度お試しください。 | Check your connection and try again. |
| homeEmptyTitle | 表示できる情報がまだありません | Nothing to show yet |

- ホームの「件の未対応」「今週の完了」「最終同期」「最近のアイテム」「アイテムを見る」は**雛形のダミー**。`homePlaceholder*` 系5キーとしてまとめ、ARB 上も1ブロックに固めて削除しやすくすることを推奨。
- 既存キー（ようこそ／自分好みに／準備完了／退会しますか？ 等）は文言変更なし。

---

## 8. 実装上の注意

- テンプレートの削除容易性を壊さない: 新規ウィジェットは `lib/core/widgets/` にのみ置き、feature 間 import を作らない。
- 状態管理・構造ルール（Riverpod + freezed、`xxx_screen.dart` / `xxx_view_model.dart` / `xxx_state.dart`、feature-first）は現状のまま。今回の変更は theme と widget レイヤに限定する。
- コピー先アプリの着色は `seedColor` と `primary` / `onPrimary` の3値差し替えで完了する設計。surface 系を有彩色にすると設計意図（面を作らない）が崩れるので変更しない。
- 日本語の長文（サーバー配信のメンテナンス文言、20文字以上の表示名）は `text-wrap: pretty` 相当の折り返し前提。値は原則 maxLines 1 + ellipsis、本文は最大6行。
- 英語表示でも同じ余白で収まることをカンプの EN 版（設定 / オンボーディング / 強制アップデート）で確認済み。
