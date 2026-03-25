import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_colors.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/widgets/app_gap.dart';
import 'package:flutter_app_template/core/widgets/app_text_field.dart';

import 'catalog_card.dart';
import 'section_label.dart';

class AppTextFieldTab extends StatefulWidget {
  const AppTextFieldTab({super.key});

  @override
  State<AppTextFieldTab> createState() => _AppTextFieldTabState();
}

class _AppTextFieldTabState extends State<AppTextFieldTab> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const SectionLabel(title: 'AppTextField', desc: 'TextFormField ラッパー'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,

        // basic
        CatalogCard(
          label: '基本 — label / hint',
          child: Column(
            children: [
              const AppTextField(
                label: 'メールアドレス',
                hint: 'example@mail.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const AppGap.md(),
              const AppTextField(
                label: 'ユーザー名',
                hint: '半角英数字で入力',
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        // with icons
        CatalogCard(
          label: 'prefixIcon / suffixIcon',
          child: Column(
            children: [
              const AppTextField(
                label: '検索',
                hint: 'キーワードを入力',
                prefixIcon: Icon(Icons.search),
              ),
              const AppGap.md(),
              AppTextField(
                label: 'パスワード',
                hint: '8文字以上',
                obscureText: _obscure,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        // states
        CatalogCard(
          label: 'errorText / helperText / disabled',
          child: const Column(
            children: [
              AppTextField(
                label: 'エラー状態',
                errorText: '有効なメールアドレスを入力してください',
              ),
              AppGap.md(),
              AppTextField(
                label: 'ヘルパーテキスト',
                helperText: 'パスワードは8文字以上にしてください',
              ),
              AppGap.md(),
              AppTextField(
                label: '無効状態',
                hint: '入力できません',
                enabled: false,
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        // multiline
        CatalogCard(
          label: 'maxLines — 複数行入力',
          child: const AppTextField(
            label: '本文',
            hint: 'テキストを入力してください',
            maxLines: 4,
          ),
        ),
        AppSpacing.gapVXl,
      ],
    );
  }
}
