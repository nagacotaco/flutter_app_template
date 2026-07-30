import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/core/widgets/labeled_field.dart';
import 'package:flutter_app_template/features/auth/presentation/login_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ログイン画面。
///
/// 主手段（メール＋パスワード）だけを画面に残し、Google / Apple / 電話番号は
/// 「他の方法でログイン」1行に畳んでボトムシートへ逃がしている（DESIGN.md §6）。
/// 並列に並ぶボタン5個を主ボタン1個＋テキスト3行にするための構成なので、
/// **ここに新しいログイン手段のボタンを平置きで足さないこと。**
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final state = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 送信中は画面上部の 2px バーだけで示す（ボタンは 30% に落とす）
            SizedBox(
              height: 2,
              child: state.isSubmitting
                  ? const LinearProgressIndicator()
                  : null,
            ),
            Expanded(
              child: ListView(
                padding: AppSpacing.screenPadding,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Text(l10n.loginTitle, style: textTheme.displayMedium),
                  const SizedBox(height: AppSpacing.xxxl),
                  LabeledField(
                    label: l10n.authEmailLabel,
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  LabeledField(
                    label: l10n.authPasswordLabel,
                    child: TextField(controller: password, obscureText: true),
                  ),
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: AppSpacing.item),
                    InlineError(message: state.errorMessage!),
                  ],
                  const SizedBox(height: AppSpacing.xxl),
                  FilledButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () => viewModel.signInWithPassword(
                            email: email.text.trim(),
                            password: password.text,
                          ),
                    child: Text(l10n.loginButton),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // 英語だと文言が長くなるので Flexible で折り返させる
                  // （はみ出させるくらいなら2行にする）
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () => const SignupRoute().go(context),
                          child: Text(l10n.loginToSignup),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Flexible(
                        child: TextButton(
                          style: AppButtonStyles.subtleText(context),
                          onPressed: state.isSubmitting
                              ? null
                              : () => const PasswordResetRoute().go(context),
                          child: Text(
                            l10n.loginToPasswordReset,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: TextButton(
                onPressed: state.isSubmitting
                    ? null
                    : () => _showOtherMethods(context, ref),
                child: Text(l10n.authOtherMethods),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Google / Apple / 電話番号をまとめて出すボトムシート。
  /// ログイン手段を増やすときはここに1行足す（画面本体には足さない）。
  Future<void> _showOtherMethods(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(loginViewModelProvider.notifier);
    return showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        final l10n = sheetContext.l10n;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              0,
              AppSpacing.screenHorizontal,
              AppSpacing.xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.authOtherMethods,
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                ListTile(
                  title: Text(l10n.loginWithGoogle),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    viewModel.signInWithGoogle();
                  },
                ),
                ListTile(
                  title: Text(l10n.loginWithApple),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    viewModel.signInWithApple();
                  },
                ),
                ListTile(
                  title: Text(l10n.loginToPhoneLogin),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    const PhoneLoginRoute().go(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
