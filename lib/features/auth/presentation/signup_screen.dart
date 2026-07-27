import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signupTitle)),
      body: SafeArea(
        child: state.confirmationEmailSent
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Center(child: Text(l10n.signupEmailSent)),
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
                  const SizedBox(height: 12),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: l10n.authPasswordLabel,
                    ),
                    obscureText: true,
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
                        : () => viewModel.signUp(
                            email: email.text.trim(),
                            password: password.text,
                          ),
                    child: Text(l10n.signupButton),
                  ),
                ],
              ),
      ),
    );
  }
}
