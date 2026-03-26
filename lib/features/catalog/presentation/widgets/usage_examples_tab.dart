import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/catalog_card.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/section_label.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/status_chip.dart';

class UsageExamplesTab extends StatelessWidget {
  const UsageExamplesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const SectionLabel(title: '使用例', desc: '実際の Widget イメージ'),
        AppSpacing.gapVMd,
        const _MessageListCard(),
        AppSpacing.gapVMd,
        const _InvoiceCard(),
        AppSpacing.gapVMd,
        const _ButtonCard(),
        AppSpacing.gapVMd,
        const _StatusChipsCard(),
        AppSpacing.gapVMd,
        const _FormCard(),
        AppSpacing.gapVXl,
        const _FormCard(),
        AppSpacing.gapVXl,
      ],
    );
  }
}

class _MessageListCard extends StatelessWidget {
  const _MessageListCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('田', '田中 花子', '了解しました。明日の会議は...', '10:32'),
      ('佐', '佐藤 一郎', '資料を送りました', '昨日'),
    ];

    return CatalogCard(
      label: 'ListTile — メッセージ一覧',
      child: Column(
        children: items.map((item) {
          final (initial, name, preview, time) = item;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              border: item != items.last ? const Border() : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: AppSize.avatarXs,
                  backgroundColor: const Color(0xFFEDE9E4),
                  child: Text(initial, style: AppTextStyles.labelLarge),
                ),
                AppSpacing.gapHSm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.titleMedium),
                      Text(
                        preview,
                        style: AppTextStyles.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(time, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard();

  @override
  Widget build(BuildContext context) {
    return CatalogCard(
      label: 'Card — 請求書サマリー',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE #0042',
            style: AppTextStyles.labelSmall.copyWith(
              letterSpacing: AppLetterSpacing.normal,
            ),
          ),
          AppSpacing.gapVXs,
          Text('山田商事株式会社', style: AppTextStyles.titleLarge),
          AppSpacing.gapVXs,
          Text('2025年3月17日 発行', style: AppTextStyles.bodyMedium),
          AppSpacing.gapVMd,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusChip(
                  label: '支払待ち',
                  textColor: const Color(0xFF9A5F10),
                  color: const Color(0xFFFEF3E2),
                  dotColor: const Color(0xFFE08A1E)),
              Text('¥128,000', style: AppTextStyles.titleLarge),
            ],
          ),
        ],
      ),
    );
  }
}

class _ButtonCard extends StatelessWidget {
  const _ButtonCard();

  @override
  Widget build(BuildContext context) {
    return CatalogCard(
      label: 'Button — labelLarge 使用',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2D2926)),
                child: Text(
                  '送信する',
                  style: AppTextStyles.labelLarge,
                ),
              ),
              AppSpacing.gapHSm,
              OutlinedButton(
                onPressed: () {},
                child: Text('キャンセル', style: AppTextStyles.labelLarge),
              ),
            ],
          ),
          AppSpacing.gapVSm,
          Text('※ 送信後は取り消しできません', style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _StatusChipsCard extends StatelessWidget {
  const _StatusChipsCard();

  @override
  Widget build(BuildContext context) {
    return CatalogCard(
      label: 'Chip — ステータス表示',
      child: Column(
        children: [
          _ChipRow(
              label: '完了',
              orderId: '注文 #1024',
              textColor: const Color(0xFF2A7A3B),
              color: const Color(0xFFEAF5EC),
              dotColor: const Color(0xFF3DA050)),
          AppSpacing.gapVSm,
          _ChipRow(
              label: '処理中',
              orderId: '注文 #1025',
              textColor: const Color(0xFF9A5F10),
              color: const Color(0xFFFEF3E2),
              dotColor: const Color(0xFFE08A1E)),
          AppSpacing.gapVSm,
          _ChipRow(
              label: 'エラー',
              orderId: '注文 #1026',
              textColor: const Color(0xFF9B2B2B),
              color: const Color(0xFFFDECEA),
              dotColor: const Color(0xFFD93535)),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({
    required this.label,
    required this.orderId,
    required this.color,
    required this.textColor,
    required this.dotColor,
  });
  final String label;
  final String orderId;
  final Color color;
  final Color textColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusChip(
            label: label,
            textColor: textColor,
            color: color,
            dotColor: dotColor),
        AppSpacing.gapHSm,
        Text(orderId, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard();

  @override
  Widget build(BuildContext context) {
    return CatalogCard(
      label: 'Form — 入力フォーム',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('新規アカウント作成', style: AppTextStyles.headlineMedium),
          AppSpacing.gapVXs,
          Text('すでにアカウントをお持ちの方はログインしてください。', style: AppTextStyles.bodyMedium),
          AppSpacing.gapVMd,
          Row(
            children: [
              Expanded(child: _FakeField(label: '姓', value: '山田')),
              AppSpacing.gapHSm,
              Expanded(child: _FakeField(label: '名', value: '太郎')),
            ],
          ),
          AppSpacing.gapVSm,
          _FakeField(label: 'メールアドレス', value: 'taro@example.com'),
          AppSpacing.gapVXs,
          Text('※ 確認メールが送信されます', style: AppTextStyles.bodySmall),
          AppSpacing.gapVMd,
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2D2926)),
            child: Text('アカウントを作成', style: AppTextStyles.labelLarge),
          ),
        ],
      ),
    );
  }
}

class _FakeField extends StatelessWidget {
  const _FakeField({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium),
        AppSpacing.gapVXs,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderMd,
          ),
          child: Text(value, style: AppTextStyles.bodyLarge),
        ),
      ],
    );
  }
}
