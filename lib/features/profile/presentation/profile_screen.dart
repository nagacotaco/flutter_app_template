import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/widgets/app_avatar.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/label_value.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_state.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// プロフィール画面。
///
/// アバターは中央の大きな円ではなく**左寄せ 64px**にして、隣に表示名を大型タイポで置く
/// （無彩色の大きな円は存在感が出ず、ただの余白に見えてしまうため。DESIGN.md §6）。
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profileTitle)),
      body: SafeArea(
        child: switch (state) {
          AsyncData(:final value) => _Body(state: value),
          AsyncError(:final error) => ErrorView(
            error: error,
            onRetry: () =>
                ref.read(profileViewModelProvider.notifier).refresh(),
          ),
          _ => const SkeletonListView(variant: SkeletonVariant.detail),
        },
      ),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.state});

  final ProfileState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final email = ref.watch(currentUserProvider)?.email;
    final displayName = state.profile.displayName;

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.profileDisplayNameLabel,
                    style: theme.textTheme.labelSmall,
                  ),
                  const SizedBox(height: AppSpacing.labelToValue),
                  Text(
                    displayName ?? l10n.profileNotSet,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      // 未設定は色ではなく濃度差で示す
                      color: displayName == null
                          ? theme.colorScheme.onSurfaceVariant
                          : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        LabelValue(
          label: l10n.authEmailLabel,
          value: email ?? l10n.profileNotSet,
          mono: true,
        ),
        const SizedBox(height: AppSpacing.section),
        FilledButton(
          onPressed: () => const ProfileEditRoute().go(context),
          child: Text(l10n.profileEditTitle),
        ),
      ],
    );
  }
}
