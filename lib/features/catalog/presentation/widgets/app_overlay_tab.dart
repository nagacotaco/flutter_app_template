import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/core/widgets/app_bottom_sheet.dart';
import 'package:flutter_app_template/core/widgets/app_button.dart';
import 'package:flutter_app_template/core/widgets/app_dialog.dart';
import 'package:flutter_app_template/core/widgets/app_gap.dart';
import 'package:flutter_app_template/core/widgets/app_snack_bar.dart';

import 'catalog_card.dart';
import 'section_label.dart';

class AppOverlayTab extends StatelessWidget {
  const AppOverlayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        // ── AppDialog ──────────────────────────────────────────
        const SectionLabel(
          title: 'AppDialog',
          desc: 'confirm / info / destructive',
        ),
        AppSpacing.gapVSm,
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppDialog — タップしてダイアログを表示',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _LaunchTile(
                label: '確認ダイアログ',
                desc: 'showConfirm — キャンセル + 確定',
                onTap: () async {
                  final result = await AppDialog.showConfirm(
                    context,
                    title: '変更を保存しますか？',
                    message: '未保存の変更があります。このまま続けると変更が失われる可能性があります。',
                    confirmLabel: '保存する',
                  );
                  if (context.mounted && result == true) {
                    AppSnackBar.show(
                      context,
                      message: '保存しました',
                      variant: AppSnackBarVariant.success,
                    );
                  }
                },
              ),
              const AppGap.sm(),
              _LaunchTile(
                label: '情報ダイアログ',
                desc: 'showInfo — OK ボタン 1 つ',
                onTap: () => AppDialog.showInfo(
                  context,
                  title: 'アップデート完了',
                  message: '新しいバージョンが適用されました。新機能をぜひお試しください。',
                ),
              ),
              const AppGap.sm(),
              _LaunchTile(
                label: '破壊的アクションダイアログ',
                desc: 'showDestructive — エラーカラーの確定ボタン',
                onTap: () async {
                  final result = await AppDialog.showDestructive(
                    context,
                    title: 'アカウントを削除しますか？',
                    message: 'この操作は取り消せません。すべてのデータが完全に削除されます。',
                  );
                  if (context.mounted && result == true) {
                    AppSnackBar.show(
                      context,
                      message: '削除しました',
                      variant: AppSnackBarVariant.error,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        AppSpacing.gapVLg,

        // ── AppSnackBar ────────────────────────────────────────
        const SectionLabel(
          title: 'AppSnackBar',
          desc: 'info / success / warning / error',
        ),
        AppSpacing.gapVSm,
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppSnackBar — バリアント',
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppButton.filled(
                label: 'Info',
                onPressed: () => AppSnackBar.show(
                  context,
                  message: '情報メッセージです',
                ),
              ),
              AppButton.filled(
                label: 'Success',
                onPressed: () => AppSnackBar.show(
                  context,
                  message: '保存しました',
                  variant: AppSnackBarVariant.success,
                ),
              ),
              AppButton.filled(
                label: 'Warning',
                onPressed: () => AppSnackBar.show(
                  context,
                  message: 'ネットワークが不安定です',
                  variant: AppSnackBarVariant.warning,
                ),
              ),
              AppButton.filled(
                label: 'Error',
                onPressed: () => AppSnackBar.show(
                  context,
                  message: 'エラーが発生しました',
                  variant: AppSnackBarVariant.error,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppSnackBar — アクション付き',
          child: AppButton.outlined(
            label: 'アクション付きスナックバー',
            onPressed: () => AppSnackBar.show(
              context,
              message: '1件アーカイブしました',
              variant: AppSnackBarVariant.info,
              actionLabel: '元に戻す',
              onAction: () {},
            ),
          ),
        ),
        AppSpacing.gapVLg,

        // ── AppBottomSheet ─────────────────────────────────────
        const SectionLabel(
          title: 'AppBottomSheet',
          desc: 'モーダルボトムシート',
        ),
        AppSpacing.gapVSm,
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppBottomSheet — タップして表示',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton.outlined(
                label: 'タイトルなし',
                onPressed: () => AppBottomSheet.show(
                  context,
                  child: Column(
                    children: [
                      _SheetItem(
                        icon: Icons.share_outlined,
                        label: 'シェアする',
                        onTap: () => Navigator.pop(context),
                      ),
                      _SheetItem(
                        icon: Icons.bookmark_border,
                        label: '保存する',
                        onTap: () => Navigator.pop(context),
                      ),
                      _SheetItem(
                        icon: Icons.flag_outlined,
                        label: '報告する',
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
              const AppGap.sm(),
              AppButton.outlined(
                label: 'タイトルあり',
                onPressed: () => AppBottomSheet.show(
                  context,
                  title: '並び替え',
                  child: Column(
                    children: [
                      _SheetItem(
                        icon: Icons.arrow_upward,
                        label: '新しい順',
                        onTap: () => Navigator.pop(context),
                      ),
                      _SheetItem(
                        icon: Icons.arrow_downward,
                        label: '古い順',
                        onTap: () => Navigator.pop(context),
                      ),
                      _SheetItem(
                        icon: Icons.sort_by_alpha,
                        label: '名前順',
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapVXl,
      ],
    );
  }
}

class _LaunchTile extends StatelessWidget {
  const _LaunchTile({
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetItem extends StatelessWidget {
  const _SheetItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFF2D2926);
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.borderMd,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.xs,
        ),
        child: Row(
          children: [
            const AppGap.md(),
          ],
        ),
      ),
    );
  }
}
