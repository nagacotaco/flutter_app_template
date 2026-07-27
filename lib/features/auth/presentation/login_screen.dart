import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/features/auth/presentation/login_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final state = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.loginTitle)),
      body: SafeArea(
        child: ListView(
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
              decoration: InputDecoration(labelText: l10n.authPasswordLabel),
              obscureText: true,
            ),
            if (state.errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                state.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: state.isSubmitting
                  ? null
                  : () => viewModel.signInWithPassword(
                      email: email.text.trim(),
                      password: password.text,
                    ),
              child: Text(l10n.loginButton),
            ),
            TextButton(
              onPressed: () => const SignupRoute().go(context),
              child: Text(l10n.loginToSignup),
            ),
            TextButton(
              onPressed: () => const PasswordResetRoute().go(context),
              child: Text(l10n.loginToPasswordReset),
            ),
            const Divider(height: 32),
            OutlinedButton(
              onPressed: state.isSubmitting ? null : viewModel.signInWithGoogle,
              child: Text(l10n.loginWithGoogle),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: state.isSubmitting ? null : viewModel.signInWithApple,
              child: Text(l10n.loginWithApple),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => const PhoneLoginRoute().go(context),
              child: Text(l10n.loginToPhoneLogin),
            ),
          ],
        ),
      ),
    );
  }
}
