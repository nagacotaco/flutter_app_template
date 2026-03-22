import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_colors.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/catalog_card.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/section_label.dart';

class DialogTab extends StatelessWidget {
  const DialogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const SectionLabel(title: 'Dialog', desc: 'AppDialogTheme のサンプル'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,
        CatalogCard(
          label: 'AppDialogTheme — テーマ設定値',
          child: const Column(
            children: [
              _ThemePropRow(
                  prop: 'backgroundColor', value: 'AppColors.cardBackground'),
              _ThemePropRow(
                  prop: 'surfaceTintColor', value: 'Colors.transparent'),
              _ThemePropRow(prop: 'elevation', value: 'AppElevation.level2'),
              _ThemePropRow(prop: 'shadowColor', value: 'Colors.black12'),
              _ThemePropRow(
                  prop: 'shape',
                  value: 'RoundedRectangleBorder (AppRadius.borderLg)'),
              _ThemePropRow(
                  prop: 'titleTextStyle',
                  value: '18px · w600 · h1.27 · textPrimary'),
              _ThemePropRow(
                  prop: 'contentTextStyle',
                  value: '14px · w400 · h1.43 · ls0.25 · textSecondary'),
              _ThemePropRow(prop: 'insetPadding', value: 'h: xl, v: xxl'),
              _ThemePropRow(
                  prop: 'actionsPadding',
                  value: 'l:md t:xs r:md b:md',
                  isLast: true),
            ],
          ),
        ),
        AppSpacing.gapVMd,
        CatalogCard(
          label: 'インタラクティブサンプル — タップしてダイアログを表示',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DialogLaunchButton(
                label: '確認ダイアログ',
                desc: 'タイトル + 本文 + 2ボタン',
                onTap: () => _showConfirmDialog(context),
              ),
              AppSpacing.gapVSm,
              _DialogLaunchButton(
                label: '情報ダイアログ',
                desc: '本文のみ + OKボタン',
                onTap: () => _showInfoDialog(context),
              ),
              AppSpacing.gapVSm,
              _DialogLaunchButton(
                label: '警告ダイアログ',
                desc: 'タイトル + 警告文 + 破壊的アクション',
                onTap: () => _showDestructiveDialog(context),
              ),
            ],
          ),
        ),
        AppSpacing.gapVXl,
      ],
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('変更を保存しますか？'),
        content: const Text(
          '未保存の変更があります。このまま続けると変更が失われる可能性があります。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: FilledButton.styleFrom(backgroundColor: AppColors.dark),
            child: Text(
              '保存する',
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textOnDark),
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text(
          'アップデートが完了しました。新しい機能をぜひお試しください。',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: FilledButton.styleFrom(backgroundColor: AppColors.dark),
            child: Text(
              'OK',
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textOnDark),
            ),
          ),
        ],
      ),
    );
  }

  void _showDestructiveDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('アカウントを削除しますか？'),
        content: const Text(
          'この操作は取り消せません。すべてのデータが完全に削除されます。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(foregroundColor: AppColors.errorText),
            child: const Text('削除する'),
          ),
        ],
      ),
    );
  }
}

class _ThemePropRow extends StatelessWidget {
  const _ThemePropRow({
    required this.prop,
    required this.value,
    this.isLast = false,
  });
  final String prop;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.border, width: 0.5),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              prop,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.accent,
                letterSpacing: AppLetterSpacing.tight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogLaunchButton extends StatelessWidget {
  const _DialogLaunchButton({
    required this.label,
    required this.desc,
    required this.onTap,
  });
  final String label;
  final String desc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderMd,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: AppRadius.borderMd,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.titleSmall),
                  Text(
                    desc,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
