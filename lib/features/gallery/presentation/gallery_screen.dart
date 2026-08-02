import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:flutter_app_template/core/widgets/app_avatar.dart';
import 'package:flutter_app_template/core/widgets/app_bottom_sheet.dart';
import 'package:flutter_app_template/core/widgets/app_dialog.dart';
import 'package:flutter_app_template/core/widgets/display_header.dart';
import 'package:flutter_app_template/core/widgets/empty_view.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/core/widgets/label_value.dart';
import 'package:flutter_app_template/core/widgets/labeled_field.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 共通 UI パーツのギャラリー（**デバッグ専用**。DESIGN.md §5 の実物カタログ）。
///
/// `/gallery` で開く（release ビルドではルート側がホームへ逃がす）。
/// テンプレートのデザインを確認・比較する開発者向け画面なので、
/// ここの文言はすべて**サンプルデータ**であり、「文言のコード直書き禁止」
/// ルール（docs/ARCHITECTURE.md）の対象外。ARB に開発専用キーを混ぜない。
///
/// パーツを `lib/core/widgets/` に追加したら、この画面にもサンプルを1つ足すこと。
/// AppNetworkImage だけは通信が必要なため載せていない。
class GalleryScreen extends HookConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ギャラリー')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxxl),
        children: const [
          _Section(title: 'タイポグラフィ', child: _TypographySamples()),
          _Section(title: 'ボタン', child: _ButtonSamples()),
          _Section(title: '入力欄', child: _FieldSamples()),
          _Section(title: 'ラベルと値 / ヘッダー / アバター', child: _DataSamples()),
          _Section(
            title: '状態表示（空 / エラー / ローディング）',
            // EmptyView / ErrorView / SkeletonListView は左右パディングを自分で持つ
            padded: false,
            child: _StateSamples(),
          ),
          _Section(title: 'ダイアログ / ボトムシート', child: _OverlaySamples()),
        ],
      ),
    );
  }
}

/// セクション見出し＋本体。階層は余白と字の大きさだけで作る（枠・面は使わない）。
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
    this.padded = true,
  });

  final String title;
  final Widget child;

  /// 自前で左右パディングを持つ子（EmptyView 等）を入れるときは false。
  final bool padded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.section),
        Padding(
          padding: AppSpacing.screenPadding,
          child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (padded)
          Padding(padding: AppSpacing.screenPadding, child: child)
        else
          child,
      ],
    );
  }
}

/// ロール名（labelSmall）＋そのロールで組んだサンプル文字列。
class _TypeSample extends StatelessWidget {
  const _TypeSample({
    required this.name,
    required this.style,
    required this.sample,
  });

  final String name;
  final TextStyle? style;
  final String sample;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: AppSpacing.labelToValue),
          Text(
            sample,
            style: style,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _TypographySamples extends StatelessWidget {
  const _TypographySamples();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TypeSample(
          name: 'displayLarge（数値専用 / Archivo）',
          style: AppTextTheme.display(textTheme),
          sample: '42',
        ),
        _TypeSample(
          name: 'displayMedium',
          style: textTheme.displayMedium,
          sample: '画面見出し',
        ),
        _TypeSample(
          name: 'headlineSmall',
          style: textTheme.headlineSmall,
          sample: 'セクション見出し',
        ),
        _TypeSample(
          name: 'titleLarge',
          style: textTheme.titleLarge,
          sample: 'ダイアログタイトル',
        ),
        _TypeSample(
          name: 'titleMedium',
          style: textTheme.titleMedium,
          sample: '設定項目の値',
        ),
        _TypeSample(
          name: 'titleMedium.archivo（数値・日付・メール）',
          style: textTheme.titleMedium.archivo,
          sample: 'taro.yamada@example.com',
        ),
        _TypeSample(
          name: 'bodyLarge',
          style: textTheme.bodyLarge,
          sample: '本文。リスト行のタイトルにも使う。',
        ),
        _TypeSample(
          name: 'bodyMedium',
          style: textTheme.bodyMedium,
          sample: '補足的な本文。説明文に使う。',
        ),
        _TypeSample(
          name: 'bodySmall',
          style: textTheme.bodySmall,
          sample: '最小の補足。バージョン表記など。',
        ),
        _TypeSample(
          name: 'labelSmall（外側ラベル）',
          style: textTheme.labelSmall,
          sample: 'メールアドレス',
        ),
      ],
    );
  }
}

class _ButtonSamples extends StatelessWidget {
  const _ButtonSamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilledButton(onPressed: () {}, child: const Text('FilledButton（主ボタン）')),
        const SizedBox(height: AppSpacing.md),
        const FilledButton(
          onPressed: null,
          child: Text('FilledButton（無効 = 30%）'),
        ),
        const SizedBox(height: AppSpacing.md),
        OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
        const SizedBox(height: AppSpacing.md),
        TextButton(
          onPressed: () {},
          child: const Text('TextButton（太字＋下線。破壊的操作もこれ）'),
        ),
        TextButton(
          onPressed: () {},
          style: AppButtonStyles.subtleText(context),
          child: const Text('subtleText（主導線でないリンク）'),
        ),
      ],
    );
  }
}

class _FieldSamples extends StatelessWidget {
  const _FieldSamples();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledField(
          label: 'メールアドレス',
          child: TextField(
            decoration: InputDecoration(hintText: 'you@example.com'),
          ),
        ),
        SizedBox(height: AppSpacing.item),
        LabeledField(
          label: '無効な入力欄',
          child: TextField(
            enabled: false,
            decoration: InputDecoration(hintText: '編集できません'),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        InlineError(message: 'メールアドレスの形式が正しくありません'),
      ],
    );
  }
}

class _DataSamples extends StatelessWidget {
  const _DataSamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DisplayHeader(
          title: 'ギャラリー',
          meta: '2026-08-02',
          display: '9',
          displayUnit: '件',
        ),
        const SizedBox(height: AppSpacing.item),
        const LabelValue(label: '表示名', value: '山田 太郎'),
        const SizedBox(height: AppSpacing.item),
        const LabelValue(
          label: 'メールアドレス（mono）',
          value: 'taro.yamada@example.com',
          mono: true,
        ),
        const SizedBox(height: AppSpacing.item),
        LabelValue(
          label: 'テーマ（trailing）',
          value: 'システムに合わせる',
          // 記号なので l10n には置かない
          trailing: Text('▼', style: Theme.of(context).textTheme.bodySmall),
        ),
        const SizedBox(height: AppSpacing.item),
        const Row(
          children: [
            AppAvatar(size: AppSize.avatar, initials: 'TY'),
            SizedBox(width: AppSpacing.lg),
            AppAvatar(size: 40, initials: 'A'),
            SizedBox(width: AppSpacing.lg),
            AppAvatar(size: 40),
          ],
        ),
      ],
    );
  }
}

class _StateSamples extends StatelessWidget {
  const _StateSamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EmptyView(
          title: '表示できる情報がまだありません',
          body: 'アイテムを追加すると、ここに一覧が表示されます。',
        ),
        const SizedBox(height: AppSpacing.section),
        ErrorView(error: Exception('sample'), onRetry: () {}),
        const SizedBox(height: AppSpacing.section),
        const SkeletonListView(itemCount: 3),
        const SizedBox(height: AppSpacing.section),
        const SkeletonListView(variant: SkeletonVariant.detail),
      ],
    );
  }
}

class _OverlaySamples extends StatelessWidget {
  const _OverlaySamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () => AppDialog.show<void>(
            context,
            title: '退会しますか？',
            message: '破壊的操作の例。主ボタン（塗り）をキャンセルに割り当て、実行を TextButton に降格する。',
            actions: (dialogContext) => [
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('退会する'),
              ),
            ],
          ),
          child: const Text('AppDialog を開く'),
        ),
        TextButton(
          onPressed: () => AppBottomSheet.show<void>(
            context,
            title: '他の方法でログイン',
            children: (sheetContext) => [
              ListTile(
                title: const Text('選択肢 A'),
                onTap: () => Navigator.of(sheetContext).pop(),
              ),
              ListTile(
                title: const Text('選択肢 B'),
                onTap: () => Navigator.of(sheetContext).pop(),
              ),
            ],
          ),
          child: const Text('AppBottomSheet を開く'),
        ),
      ],
    );
  }
}
