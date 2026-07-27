import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_edit_state.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_edit_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileEditScreen extends HookConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileEditViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profileEditTitle)),
      body: switch (state) {
        AsyncData(:final value) => _Body(state: value),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(profileEditViewModelProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.state});

  final ProfileEditState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = useTextEditingController(
      text: state.profile.displayName ?? '',
    );
    final viewModel = ref.read(profileEditViewModelProvider.notifier);
    final l10n = context.l10n;
    final avatarUrl = state.profile.avatarUrl;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: CircleAvatar(
            radius: 48,
            backgroundImage: avatarUrl == null ? null : NetworkImage(avatarUrl),
            child: avatarUrl == null
                ? const Icon(Icons.person, size: 48)
                : null,
          ),
        ),
        TextButton(
          onPressed: state.isSaving ? null : viewModel.pickAndUploadAvatar,
          child: Text(l10n.profileChangeAvatarButton),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: displayName,
          decoration: InputDecoration(labelText: l10n.profileDisplayNameLabel),
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
          onPressed: state.isSaving
              ? null
              : () async {
                  final saved = await viewModel.saveDisplayName(
                    displayName.text,
                  );
                  if (saved && context.mounted) {
                    context.pop();
                  }
                },
          child: Text(l10n.profileSaveButton),
        ),
      ],
    );
  }
}
