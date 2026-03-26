import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/widgets/app_button.dart';
import 'package:flutter_app_template/core/widgets/app_gap.dart';

import 'catalog_card.dart';
import 'section_label.dart';

class AppButtonTab extends StatefulWidget {
  const AppButtonTab({super.key});

  @override
  State<AppButtonTab> createState() => _AppButtonTabState();
}

class _AppButtonTabState extends State<AppButtonTab> {
  bool _isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const SectionLabel(title: 'AppButton', desc: 'filled / outlined / text'),
        AppSpacing.gapVSm,
        AppSpacing.gapVMd,

        // filled
        CatalogCard(
          label: 'AppButton.filled — 塗りつぶしボタン',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton.filled(
                label: 'Primary Action',
                onPressed: () {},
              ),
              const AppGap.sm(),
              AppButton.filled(
                label: 'With Icon',
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
              ),
              const AppGap.sm(),
              AppButton.filled(
                label: 'Disabled',
                onPressed: null,
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        // outlined
        CatalogCard(
          label: 'AppButton.outlined — 枠線ボタン',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton.outlined(
                label: 'Secondary Action',
                onPressed: () {},
              ),
              const AppGap.sm(),
              AppButton.outlined(
                label: 'With Icon',
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, size: 18),
              ),
              const AppGap.sm(),
              AppButton.outlined(
                label: 'Disabled',
                onPressed: null,
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        // text
        CatalogCard(
          label: 'AppButton.text — テキストボタン',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton.text(
                label: 'Text Action',
                onPressed: () {},
              ),
              const AppGap.sm(),
              AppButton.text(
                label: 'Disabled',
                onPressed: null,
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        // loading
        CatalogCard(
          label: 'isLoading — ローディング状態（タップして確認）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton.filled(
                label: 'ローディングをシミュレート',
                onPressed: _isLoading ? null : _simulateLoading,
                isLoading: _isLoading,
              ),
              const AppGap.sm(),
              AppButton.outlined(
                label: 'ローディングをシミュレート',
                onPressed: _isLoading ? null : _simulateLoading,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
        AppSpacing.gapVXl,
      ],
    );
  }
}
