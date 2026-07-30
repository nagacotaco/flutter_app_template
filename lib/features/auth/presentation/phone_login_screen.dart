import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/core/widgets/labeled_field.dart';
import 'package:flutter_app_template/features/auth/presentation/phone_login_state.dart';
import 'package:flutter_app_template/features/auth/presentation/phone_login_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhoneLoginScreen extends HookConsumerWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = useTextEditingController();
    final otp = useTextEditingController();
    final state = ref.watch(phoneLoginViewModelProvider);
    final viewModel = ref.read(phoneLoginViewModelProvider.notifier);
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isStep1 = state.step == PhoneLoginStep.inputPhone;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.phoneLoginTitle)),
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
              child: ListView(
                padding: AppSpacing.screenPadding,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // 2段階であることを最初に見せる（DESIGN.md §6）
                  _StepIndicator(currentStep: isStep1 ? 1 : 2),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    isStep1 ? l10n.phoneStep1Headline : l10n.phoneStep2Headline,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  if (isStep1)
                    LabeledField(
                      label: l10n.authPhoneLabel,
                      child: TextField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        style: theme.textTheme.bodyLarge.archivo,
                      ),
                    )
                  else ...[
                    Text(state.phone, style: theme.textTheme.bodySmall.archivo),
                    const SizedBox(height: AppSpacing.md),
                    LabeledField(
                      label: l10n.authOtpLabel,
                      child: TextField(
                        controller: otp,
                        keyboardType: TextInputType.number,
                        // 桁を数えやすいように大きく開ける（DESIGN.md §6）
                        style: theme.textTheme.titleLarge.archivo?.copyWith(
                          letterSpacing: 20 * 0.42,
                        ),
                      ),
                    ),
                  ],
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: AppSpacing.item),
                    InlineError(message: state.errorMessage!),
                  ],
                  const SizedBox(height: AppSpacing.xxl),
                  if (isStep1)
                    FilledButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () => viewModel.sendOtp(phone.text.trim()),
                      child: Text(l10n.phoneSendOtpButton),
                    )
                  else ...[
                    FilledButton(
                      onPressed: state.isSubmitting
                          ? null
                          : () => viewModel.verifyOtp(otp.text.trim()),
                      child: Text(l10n.phoneVerifyButton),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: TextButton(
                        onPressed: viewModel.backToPhoneInput,
                        child: Text(l10n.phoneBackToInput),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// `STEP 1 — STEP 2` のテキストインジケータ。
/// 現在のステップだけ onSurface、もう一方は onSurfaceVariant にして
/// **色ではなく濃度差**で進捗を示す。
class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final base = theme.textTheme.labelSmall.archivo;

    Widget step(int n) => Text(
      l10n.phoneStepLabel(n),
      style: base?.copyWith(
        color: n == currentStep
            ? theme.colorScheme.onSurface
            : theme.colorScheme.onSurfaceVariant,
      ),
    );

    return Row(
      children: [
        step(1),
        Container(
          width: 18,
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          color: theme.colorScheme.outline,
        ),
        step(2),
      ],
    );
  }
}
