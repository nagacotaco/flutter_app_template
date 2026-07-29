import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/widgets/app_avatar.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_state.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profileTitle)),
      body: switch (state) {
        AsyncData(:final value) => _Body(state: value),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.read(profileViewModelProvider.notifier).refresh(),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.state});

  final ProfileState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final email = ref.watch(currentUserProvider)?.email;
    final avatarUrl = state.profile.avatarUrl;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(child: AppAvatar(url: avatarUrl, radius: 48)),
        const SizedBox(height: 24),
        ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: Text(l10n.profileDisplayNameLabel),
          subtitle: Text(state.profile.displayName ?? l10n.profileNotSet),
        ),
        ListTile(
          leading: const Icon(Icons.mail_outlined),
          title: Text(l10n.authEmailLabel),
          subtitle: Text(email ?? l10n.profileNotSet),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => const ProfileEditRoute().go(context),
          child: Text(l10n.profileEditTitle),
        ),
      ],
    );
  }
}
