import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_colors.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';

// ---------------------------------------------------------------------------
// データモデル
// ---------------------------------------------------------------------------

class StyleEntry {
  const StyleEntry({
    required this.name,
    required this.style,
    required this.sample,
    required this.props,
  });

  final String name;
  final TextStyle style;
  final String sample;
  final String props;
}

class StyleGroup {
  const StyleGroup(
      {required this.label, required this.desc, required this.entries});
  final String label;
  final String desc;
  final List<StyleEntry> entries;
}

final List<StyleGroup> styleGroups = [
  StyleGroup(
    label: 'Display',
    desc: 'スプラッシュ・ヒーロー用の超大文字',
    entries: [
      StyleEntry(
          name: 'displayLarge',
          style: AppTextStyles.displayLarge,
          sample: 'あいう Ag',
          props: '57px · w400 · h1.12'),
      StyleEntry(
          name: 'displayMedium',
          style: AppTextStyles.displayMedium,
          sample: 'あいう Ag',
          props: '45px · w400 · h1.16'),
      StyleEntry(
          name: 'displaySmall',
          style: AppTextStyles.displaySmall,
          sample: 'あいう Ag',
          props: '36px · w400 · h1.22'),
    ],
  ),
  StyleGroup(
    label: 'Headline',
    desc: 'ページ・セクション見出し',
    entries: [
      StyleEntry(
          name: 'headlineLarge',
          style: AppTextStyles.headlineLarge,
          sample: '設定',
          props: '32px · w400 · h1.25'),
      StyleEntry(
          name: 'headlineMedium',
          style: AppTextStyles.headlineMedium,
          sample: '通知一覧',
          props: '28px · w400 · h1.29'),
      StyleEntry(
          name: 'headlineSmall',
          style: AppTextStyles.headlineSmall,
          sample: 'プロフィール',
          props: '24px · w400 · h1.33'),
    ],
  ),
  StyleGroup(
    label: 'Title',
    desc: 'カード見出し・AppBar・リストタイトル',
    entries: [
      StyleEntry(
          name: 'titleLarge',
          style: AppTextStyles.titleLarge,
          sample: '最近の注文',
          props: '22px · w500 · h1.27'),
      StyleEntry(
          name: 'titleMedium',
          style: AppTextStyles.titleMedium,
          sample: '山田商事への請求書',
          props: '16px · w500 · h1.50 · ls0.15'),
      StyleEntry(
          name: 'titleSmall',
          style: AppTextStyles.titleSmall,
          sample: '2025年3月17日',
          props: '14px · w500 · h1.43 · ls0.1'),
    ],
  ),
  StyleGroup(
    label: 'Body',
    desc: '本文・説明文。最も出番が多いグループ',
    entries: [
      StyleEntry(
          name: 'bodyLarge',
          style: AppTextStyles.bodyLarge,
          sample: 'アカウント設定を変更しました。変更内容は次回ログイン時に反映されます。',
          props: '16px · w400 · h1.50 · ls0.5'),
      StyleEntry(
          name: 'bodyMedium',
          style: AppTextStyles.bodyMedium,
          sample: 'パスワードは8文字以上で、英数字を組み合わせてください。',
          props: '14px · w400 · h1.43 · ls0.25'),
      StyleEntry(
          name: 'bodySmall',
          style: AppTextStyles.bodySmall,
          sample: '※ 本設定はいつでも変更できます。ご不明な点はサポートまでお問い合わせください。',
          props: '12px · w400 · h1.33 · ls0.4'),
    ],
  ),
  StyleGroup(
    label: 'Label',
    desc: 'ボタン・タグ・キャプション・ナビゲーション',
    entries: [
      StyleEntry(
          name: 'labelLarge',
          style: AppTextStyles.labelLarge,
          sample: '保存する　／　キャンセル',
          props: '14px · w500 · h1.43 · ls0.1'),
      StyleEntry(
          name: 'labelMedium',
          style: AppTextStyles.labelMedium,
          sample: '完了　処理中　エラー',
          props: '12px · w500 · h1.33 · ls0.5'),
      StyleEntry(
          name: 'labelSmall',
          style: AppTextStyles.labelSmall,
          sample: 'RECENT · FAVORITES · ALL ITEMS',
          props: '11px · w500 · h1.45 · ls0.5'),
    ],
  ),
];

// ---------------------------------------------------------------------------
// StyleGroupTab
// ---------------------------------------------------------------------------

class StyleGroupTab extends StatelessWidget {
  const StyleGroupTab({super.key, required this.group});
  final StyleGroup group;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              group.label.toUpperCase(),
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: AppLetterSpacing.normal,
              ),
            ),
            AppSpacing.gapHSm,
            Text(
              group.desc,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textTertiary),
            ),
          ],
        ),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVSm,
        ...group.entries.map((e) => _StyleRow(entry: e)),
      ],
    );
  }
}

class _StyleRow extends StatelessWidget {
  const _StyleRow({required this.entry});
  final StyleEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              entry.sample,
              style: entry.style,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AppSpacing.gapHMd,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entry.name,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.accent,
                  letterSpacing: AppLetterSpacing.tight,
                ),
              ),
              AppSpacing.gapVXs,
              Text(
                entry.props,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 10,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
