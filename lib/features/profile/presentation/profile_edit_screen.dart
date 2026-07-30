import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/widgets/app_avatar.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/core/widgets/labeled_field.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
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
    final isSaving = state.value?.isSaving ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profileEditTitle)),
      body: SafeArea(
        child: Column(
          children: [
            // 保存中は上部 2px バー＋主ボタン 30%（DESIGN.md §6）
            SizedBox(
              height: 2,
              child: isSaving ? const LinearProgressIndicator() : null,
            ),
            Expanded(
              child: switch (state) {
                AsyncData(:final value) => _Body(state: value),
                AsyncError(:final error) => ErrorView(
                  error: error,
                  onRetry: () => ref.invalidate(profileEditViewModelProvider),
                ),
                _ => const SkeletonListView(variant: SkeletonVariant.detail),
              },
            ),
          ],
        ),
      ),
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

    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            AppAvatar(
              url: state.profile.avatarUrl,
              size: AppSize.avatar,
              initials: state.avatarInitials,
            ),
            const SizedBox(width: AppSpacing.lg),
            if (state.canChangeAvatar)
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                    onPressed: state.isSaving
                        ? null
                        : viewModel.pickAndUploadAvatar,
                    child: Text(l10n.profileChangeAvatarButton),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        LabeledField(
          label: l10n.profileDisplayNameLabel,
          child: TextField(controller: displayName, enabled: !state.isSaving),
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.item),
          InlineError(message: state.errorMessage!),
        ],
        const SizedBox(height: AppSpacing.xxl),
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
