import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.phoneLoginTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (state.step == PhoneLoginStep.inputPhone) ...[
              TextField(
                controller: phone,
                decoration: InputDecoration(labelText: l10n.authPhoneLabel),
                keyboardType: TextInputType.phone,
              ),
            ] else ...[
              Text(state.phone),
              const SizedBox(height: 12),
              TextField(
                controller: otp,
                decoration: InputDecoration(labelText: l10n.authOtpLabel),
                keyboardType: TextInputType.number,
              ),
            ],
            if (state.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                state.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 24),
            if (state.step == PhoneLoginStep.inputPhone)
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
              TextButton(
                onPressed: viewModel.backToPhoneInput,
                child: Text(l10n.phoneBackToInput),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
