import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/core/widgets/labeled_field.dart';
import 'package:flutter_app_template/features/auth/presentation/signup_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final state = ref.watch(signupViewModelProvider);
    final viewModel = ref.read(signupViewModelProvider.notifier);
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signupTitle)),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 2,
              child: state.isSubmitting
                  ? const LinearProgressIndicator()
                  : null,
            ),
            Expanded(
              child: state.confirmationEmailSent
                  ? const _EmailSent()
                  : ListView(
                      padding: AppSpacing.screenPadding,
                      children: [
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          l10n.signupHeadline,
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
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
                          child: TextField(
                            controller: password,
                            obscureText: true,
                          ),
                        ),
                        if (state.errorMessage != null) ...[
                          const SizedBox(height: AppSpacing.item),
                          InlineError(message: state.errorMessage!),
                        ],
                        const SizedBox(height: AppSpacing.xxl),
                        FilledButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () => viewModel.signUp(
                                  email: email.text.trim(),
                                  password: password.text,
                                ),
                          child: Text(l10n.signupButton),
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

/// 送信後の状態。中央寄せではなく本文と同じ左端に揃える（DESIGN.md §6）。
class _EmailSent extends StatelessWidget {
  const _EmailSent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.signupEmailSentTitle, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.signupEmailSentBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: () => LoginRoute(from: context.routeFrom).go(context),
            child: Text(l10n.authBackToLogin),
          ),
        ],
      ),
    );
  }
}
