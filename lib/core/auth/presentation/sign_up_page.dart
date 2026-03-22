import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/auth/application/sign_up_page_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final state = ref.watch(signUpPageVMProvider);
    final notifier = ref.read(signUpPageVMProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント作成')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'メールアドレス'),
                  keyboardType: TextInputType.emailAddress,
                  validator: notifier.validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  validator: notifier.validatePassword,
                ),
                if (state.error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    state.error.toString(),
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          if (!formKey.currentState!.validate()) return;
                          notifier.signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                        },
                  child: state.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('アカウントを作成'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('ログイン画面に戻る'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
