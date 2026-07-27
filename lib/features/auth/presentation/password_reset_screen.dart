import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/features/auth/presentation/password_reset_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordResetScreen extends HookConsumerWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final state = ref.watch(passwordResetViewModelProvider);
    final viewModel = ref.read(passwordResetViewModelProvider.notifier);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.passwordResetTitle)),
      body: SafeArea(
        child: state.emailSent
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Center(child: Text(l10n.passwordResetSent)),
              )
            : ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(labelText: l10n.authEmailLabel),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () => viewModel.sendResetEmail(email.text.trim()),
                    child: Text(l10n.passwordResetButton),
                  ),
                ],
              ),
      ),
    );
  }
}
