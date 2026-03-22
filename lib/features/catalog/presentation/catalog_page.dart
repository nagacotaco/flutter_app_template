import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_colors.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/core/widgets/app_gap.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CatalogScreen();
  }
}

// ---------------------------------------------------------------------------
// データモデル
// ---------------------------------------------------------------------------

class _StyleEntry {
  const _StyleEntry({
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

class _StyleGroup {
  const _StyleGroup(
      {required this.label, required this.desc, required this.entries});
  final String label;
  final String desc;
  final List<_StyleEntry> entries;
}

final List<_StyleGroup> _groups = [
  _StyleGroup(
    label: 'Display',
    desc: 'スプラッシュ・ヒーロー用の超大文字',
    entries: [
      _StyleEntry(
          name: 'displayLarge',
          style: AppTextStyles.displayLarge,
          sample: 'あいう Ag',
          props: '57px · w400 · h1.12'),
      _StyleEntry(
          name: 'displayMedium',
          style: AppTextStyles.displayMedium,
          sample: 'あいう Ag',
          props: '45px · w400 · h1.16'),
      _StyleEntry(
          name: 'displaySmall',
          style: AppTextStyles.displaySmall,
          sample: 'あいう Ag',
          props: '36px · w400 · h1.22'),
    ],
  ),
  _StyleGroup(
    label: 'Headline',
    desc: 'ページ・セクション見出し',
    entries: [
      _StyleEntry(
          name: 'headlineLarge',
          style: AppTextStyles.headlineLarge,
          sample: '設定',
          props: '32px · w400 · h1.25'),
      _StyleEntry(
          name: 'headlineMedium',
          style: AppTextStyles.headlineMedium,
          sample: '通知一覧',
          props: '28px · w400 · h1.29'),
      _StyleEntry(
          name: 'headlineSmall',
          style: AppTextStyles.headlineSmall,
          sample: 'プロフィール',
          props: '24px · w400 · h1.33'),
    ],
  ),
  _StyleGroup(
    label: 'Title',
    desc: 'カード見出し・AppBar・リストタイトル',
    entries: [
      _StyleEntry(
          name: 'titleLarge',
          style: AppTextStyles.titleLarge,
          sample: '最近の注文',
          props: '22px · w500 · h1.27'),
      _StyleEntry(
          name: 'titleMedium',
          style: AppTextStyles.titleMedium,
          sample: '山田商事への請求書',
          props: '16px · w500 · h1.50 · ls0.15'),
      _StyleEntry(
          name: 'titleSmall',
          style: AppTextStyles.titleSmall,
          sample: '2025年3月17日',
          props: '14px · w500 · h1.43 · ls0.1'),
    ],
  ),
  _StyleGroup(
    label: 'Body',
    desc: '本文・説明文。最も出番が多いグループ',
    entries: [
      _StyleEntry(
          name: 'bodyLarge',
          style: AppTextStyles.bodyLarge,
          sample: 'アカウント設定を変更しました。変更内容は次回ログイン時に反映されます。',
          props: '16px · w400 · h1.50 · ls0.5'),
      _StyleEntry(
          name: 'bodyMedium',
          style: AppTextStyles.bodyMedium,
          sample: 'パスワードは8文字以上で、英数字を組み合わせてください。',
          props: '14px · w400 · h1.43 · ls0.25'),
      _StyleEntry(
          name: 'bodySmall',
          style: AppTextStyles.bodySmall,
          sample: '※ 本設定はいつでも変更できます。ご不明な点はサポートまでお問い合わせください。',
          props: '12px · w400 · h1.33 · ls0.4'),
    ],
  ),
  _StyleGroup(
    label: 'Label',
    desc: 'ボタン・タグ・キャプション・ナビゲーション',
    entries: [
      _StyleEntry(
          name: 'labelLarge',
          style: AppTextStyles.labelLarge,
          sample: '保存する　／　キャンセル',
          props: '14px · w500 · h1.43 · ls0.1'),
      _StyleEntry(
          name: 'labelMedium',
          style: AppTextStyles.labelMedium,
          sample: '完了　処理中　エラー',
          props: '12px · w500 · h1.33 · ls0.5'),
      _StyleEntry(
          name: 'labelSmall',
          style: AppTextStyles.labelSmall,
          sample: 'RECENT · FAVORITES · ALL ITEMS',
          props: '11px · w500 · h1.45 · ls0.5'),
    ],
  ),
];

// ---------------------------------------------------------------------------
// メイン画面
// ---------------------------------------------------------------------------

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _tabs = [
    'Display',
    'Headline',
    'Title',
    'Body',
    'Label',
    '使用例',
    'AppGap',
    'Dialog'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.dark,
            foregroundColor: AppColors.cream,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, 0, AppSpacing.lg, 56),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'samples',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.cream.withValues(alpha: 0.5),
                      letterSpacing: AppLetterSpacing.wide,
                    ),
                  ),
                  AppSpacing.gapVXs,
                  Text(
                    'Catalog',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.cream,
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColors.accent,
              labelColor: AppColors.cream,
              unselectedLabelColor: AppColors.cream.withValues(alpha: 0.5),
              labelStyle: AppTextStyles.labelMedium,
              unselectedLabelStyle: AppTextStyles.labelMedium,
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ..._groups.map((g) => _StyleGroupTab(group: g)),
            const _UsageExamplesTab(),
            const _AppGapTab(),
            const _DialogTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// スタイルグループ タブ
// ---------------------------------------------------------------------------

class _StyleGroupTab extends StatelessWidget {
  const _StyleGroupTab({required this.group});
  final _StyleGroup group;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        // セクションヘッダー
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

        // スタイル行
        ...group.entries.map((e) => _StyleRow(entry: e)),
      ],
    );
  }
}

class _StyleRow extends StatelessWidget {
  const _StyleRow({required this.entry});
  final _StyleEntry entry;

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

// ---------------------------------------------------------------------------
// 使用例 タブ
// ---------------------------------------------------------------------------

class _UsageExamplesTab extends StatelessWidget {
  const _UsageExamplesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const _SectionLabel(title: '使用例', desc: '実際の Widget イメージ'),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title, required this.desc});
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: AppLetterSpacing.normal,
          ),
        ),
        AppSpacing.gapHSm,
        Text(
          desc,
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
        ),
      ],
    );
  }
}

// カードの共通ラッパー
class _CatalogCard extends StatelessWidget {
  const _CatalogCard({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.borderLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: const BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: AppLetterSpacing.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ListTile風メッセージ一覧
class _MessageListCard extends StatelessWidget {
  const _MessageListCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('田', '田中 花子', '了解しました。明日の会議は...', '10:32'),
      ('佐', '佐藤 一郎', '資料を送りました', '昨日'),
    ];

    return _CatalogCard(
      label: 'ListTile — メッセージ一覧',
      child: Column(
        children: items.map((item) {
          final (initial, name, preview, time) = item;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              border: item != items.last
                  ? const Border(
                      bottom: BorderSide(color: AppColors.border, width: 0.5))
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: AppSize.avatarXs,
                  backgroundColor: AppColors.avatarBg,
                  child: Text(
                    initial,
                    style: AppTextStyles.labelLarge
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ),
                AppSpacing.gapHSm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.titleMedium),
                      Text(
                        preview,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        time,
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textTertiary),
                      ),
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

// 請求書カード
class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard();

  @override
  Widget build(BuildContext context) {
    return _CatalogCard(
      label: 'Card — 請求書サマリー',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE #0042',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: AppLetterSpacing.normal,
            ),
          ),
          AppSpacing.gapVXs,
          Text('山田商事株式会社', style: AppTextStyles.titleLarge),
          AppSpacing.gapVXs,
          Text(
            '2025年3月17日 発行',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
          ),
          AppSpacing.gapVMd,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatusChip(
                  label: '支払待ち',
                  color: AppColors.warningBg,
                  textColor: AppColors.warningText,
                  dotColor: AppColors.warningDot),
              Text('¥128,000', style: AppTextStyles.titleLarge),
            ],
          ),
        ],
      ),
    );
  }
}

// ボタンカード
class _ButtonCard extends StatelessWidget {
  const _ButtonCard();

  @override
  Widget build(BuildContext context) {
    return _CatalogCard(
      label: 'Button — labelLarge 使用',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(backgroundColor: AppColors.dark),
                child: Text('送信する',
                    style: AppTextStyles.labelLarge
                        .copyWith(color: AppColors.textOnDark)),
              ),
              AppSpacing.gapHSm,
              OutlinedButton(
                onPressed: () {},
                child: Text('キャンセル', style: AppTextStyles.labelLarge),
              ),
            ],
          ),
          AppSpacing.gapVSm,
          Text(
            '※ 送信後は取り消しできません',
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ステータスチップカード
class _StatusChipsCard extends StatelessWidget {
  const _StatusChipsCard();

  @override
  Widget build(BuildContext context) {
    return _CatalogCard(
      label: 'Chip — ステータス表示',
      child: Column(
        children: [
          _ChipRow(
              label: '完了',
              orderId: '注文 #1024',
              color: AppColors.successBg,
              textColor: AppColors.successText,
              dotColor: AppColors.successDot),
          AppSpacing.gapVSm,
          _ChipRow(
              label: '処理中',
              orderId: '注文 #1025',
              color: AppColors.warningBg,
              textColor: AppColors.warningText,
              dotColor: AppColors.warningDot),
          AppSpacing.gapVSm,
          _ChipRow(
              label: 'エラー',
              orderId: '注文 #1026',
              color: AppColors.errorBg,
              textColor: AppColors.errorText,
              dotColor: AppColors.errorDot),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow(
      {required this.label,
      required this.orderId,
      required this.color,
      required this.textColor,
      required this.dotColor});
  final String label;
  final String orderId;
  final Color color;
  final Color textColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatusChip(
            label: label,
            color: color,
            textColor: textColor,
            dotColor: dotColor),
        AppSpacing.gapHSm,
        Text(orderId,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(
      {required this.label,
      required this.color,
      required this.textColor,
      required this.dotColor});
  final String label;
  final Color color;
  final Color textColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration:
          BoxDecoration(color: color, borderRadius: AppRadius.borderMax),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: AppSize.dotSm,
              height: AppSize.dotSm,
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle)),
          AppSpacing.gapHXs,
          Text(label,
              style: AppTextStyles.labelMedium.copyWith(color: textColor)),
        ],
      ),
    );
  }
}

// フォームカード
class _FormCard extends StatelessWidget {
  const _FormCard();

  @override
  Widget build(BuildContext context) {
    return _CatalogCard(
      label: 'Form — 入力フォーム',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('新規アカウント作成', style: AppTextStyles.headlineMedium),
          AppSpacing.gapVXs,
          Text(
            'すでにアカウントをお持ちの方はログインしてください。',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
          ),
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
          Text(
            '※ 確認メールが送信されます',
            style:
                AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
          ),
          AppSpacing.gapVMd,
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(backgroundColor: AppColors.dark),
            child: Text('アカウントを作成',
                style: AppTextStyles.labelLarge
                    .copyWith(color: AppColors.textOnDark)),
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
        Text(
          label,
          style: AppTextStyles.labelMedium
              .copyWith(color: AppColors.textSecondary),
        ),
        AppSpacing.gapVXs,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderLight),
            borderRadius: AppRadius.borderMd,
          ),
          child: Text(value,
              style: AppTextStyles.bodyLarge
                  .copyWith(color: AppColors.textTertiary)),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// AppGap ショーケース タブ
// ---------------------------------------------------------------------------

class _AppGapTab extends StatelessWidget {
  const _AppGapTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const _SectionLabel(title: 'AppGap', desc: '親 Flex の方向を自動検出するギャップ'),
        AppSpacing.gapVMd,
        _CatalogCard(
          label: 'Column 内での使用（垂直ギャップ）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GapBox(label: 'Item A'),
              const AppGap.xs(),
              _GapBox(label: 'xs (4dp)'),
              const AppGap.sm(),
              _GapBox(label: 'sm (8dp)'),
              const AppGap.md(),
              _GapBox(label: 'md (16dp)'),
              const AppGap.lg(),
              _GapBox(label: 'lg (24dp)'),
            ],
          ),
        ),
        AppSpacing.gapVMd,
        _CatalogCard(
          label: 'Row 内での使用（水平ギャップ）',
          child: Row(
            children: [
              _GapBox(label: 'A'),
              const AppGap.xs(),
              _GapBox(label: 'xs'),
              const AppGap.sm(),
              _GapBox(label: 'sm'),
              const AppGap.md(),
              _GapBox(label: 'md'),
              const AppGap.lg(),
              _GapBox(label: 'lg'),
            ],
          ),
        ),
        AppSpacing.gapVMd,
        _CatalogCard(
          label: '任意サイズ AppGap(value)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GapBox(label: 'Top'),
              AppGap(AppSpacing.xxl),
              _GapBox(label: 'xxl (40dp) 下'),
            ],
          ),
        ),
        AppSpacing.gapVXl,
      ],
    );
  }
}

class _GapBox extends StatelessWidget {
  const _GapBox({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.borderSm,
      ),
      child: Text(label, style: AppTextStyles.labelSmall),
    );
  }
}

// ---------------------------------------------------------------------------
// Dialog ショーケース タブ
// ---------------------------------------------------------------------------

class _DialogTab extends StatelessWidget {
  const _DialogTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const _SectionLabel(title: 'Dialog', desc: 'AppDialogTheme のサンプル'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,

        // テーマ設定値の一覧
        _CatalogCard(
          label: 'AppDialogTheme — テーマ設定値',
          child: Column(
            children: const [
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

        // ダイアログを開くボタン群
        _CatalogCard(
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
