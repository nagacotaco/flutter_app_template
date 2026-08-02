import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/constants/app_links.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/widgets/display_header.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/core/widgets/label_value.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_state.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// 設定画面。
///
/// 項目を2種類に分けている（DESIGN.md §6）。
/// - **いまの状態が値として見えるもの**（テーマ・言語・アカウント・バージョン）→ 2列の [LabelValue]
/// - **遷移するだけのもの**（プロフィール・規約・ポリシー）→ テキスト行
///
/// leading アイコンは全廃。モノクロだとアイコンが情報を持たず視覚ノイズになるため。
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsViewModelProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.xl,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayHeader(title: l10n.settingsTitle),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.settingsTitle,
                    style: theme.textTheme.displayMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.section),
            Expanded(
              child: switch (state) {
                AsyncData(:final value) => _Body(state: value),
                AsyncError(:final error) => ErrorView(
                  error: error,
                  onRetry: () => ref.invalidate(settingsViewModelProvider),
                ),
                _ => const SkeletonListView(itemCount: 4),
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

  final SettingsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);
    final viewModel = ref.read(settingsViewModelProvider.notifier);
    final email = ref.watch(currentUserProvider)?.email;
    final l10n = context.l10n;

    final themeLabel = switch (settings.themeMode) {
      ThemeMode.light => l10n.settingsThemeLight,
      ThemeMode.dark => l10n.settingsThemeDark,
      ThemeMode.system => l10n.settingsThemeSystem,
    };
    final languageCode = settings.locale?.languageCode ?? 'system';
    final languageLabel = switch (languageCode) {
      'ja' => '日本語',
      'en' => 'English',
      _ => l10n.settingsLanguageSystem,
    };

    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _DropdownValue<ThemeMode>(
                label: l10n.settingsThemeTitle,
                valueLabel: themeLabel,
                value: settings.themeMode,
                onChanged: settingsNotifier.setThemeMode,
                items: [
                  (ThemeMode.system, l10n.settingsThemeSystem),
                  (ThemeMode.light, l10n.settingsThemeLight),
                  (ThemeMode.dark, l10n.settingsThemeDark),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: _DropdownValue<String>(
                label: l10n.settingsLanguageTitle,
                valueLabel: languageLabel,
                value: languageCode,
                onChanged: (code) => settingsNotifier.setLocale(
                  code == 'system' ? null : Locale(code),
                ),
                items: [
                  ('system', l10n.settingsLanguageSystem),
                  ('ja', '日本語'),
                  ('en', 'English'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.item),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LabelValue(
                label: l10n.authEmailLabel,
                value: email ?? l10n.profileNotSet,
                mono: true,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: LabelValue(
                label: l10n.settingsVersion,
                value: state.appVersion,
                mono: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        _LinkRow(
          label: l10n.profileTitle,
          onTap: () => const ProfileRoute().go(context),
        ),
        const SizedBox(height: AppSpacing.lg),
        _LinkRow(
          label: l10n.settingsPurchases,
          onTap: () => const PaywallRoute().push<void>(context),
        ),
        const SizedBox(height: AppSpacing.lg),
        _LinkRow(
          label: l10n.settingsTermsOfService,
          isExternal: true,
          onTap: () => launchUrl(AppLinks.termsOfService),
        ),
        const SizedBox(height: AppSpacing.lg),
        _LinkRow(
          label: l10n.settingsPrivacyPolicy,
          isExternal: true,
          onTap: () => launchUrl(AppLinks.privacyPolicy),
        ),
        const SizedBox(height: AppSpacing.section),
        // エラーは SnackBar ではなく、原因になった操作の近くにインライン表示する
        if (state.errorMessage != null) ...[
          InlineError(message: state.errorMessage!),
          const SizedBox(height: AppSpacing.item),
        ],
        _LinkRow(
          label: l10n.settingsLogout,
          onTap: state.isProcessing ? null : viewModel.signOut,
        ),
        const SizedBox(height: AppSpacing.lg),
        // 退会は最下部・太字＋下線・確認ダイアログの3段構え
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: state.isProcessing
                ? null
                : () => _confirmDeleteAccount(context, viewModel),
            child: Text(l10n.settingsDeleteAccount),
          ),
        ),
      ],
    );
  }

  /// モノクロでは色で危険を示せないので、**主ボタン（塗り）をキャンセルに割り当て**、
  /// 「退会する」をテキストボタンに降格して誤タップを防ぐ（DESIGN.md §6）。
  Future<void> _confirmDeleteAccount(
    BuildContext context,
    SettingsViewModel viewModel,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final l10n = dialogContext.l10n;
        return AlertDialog(
          title: Text(l10n.settingsDeleteAccountConfirmTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.settingsDeleteAccountConfirmMessage),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.commonCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(l10n.settingsDeleteAccountConfirmButton),
              ),
            ],
          ),
        );
      },
    );
    if (confirmed ?? false) {
      await viewModel.deleteAccount();
    }
  }
}

/// 遷移するだけの行。枠も面も持たず、右端の記号だけで遷移先の種類を示す。
class _LinkRow extends StatelessWidget {
  const _LinkRow({
    required this.label,
    required this.onTap,
    this.isExternal = false,
  });

  final String label;
  final VoidCallback? onTap;

  /// 外部ブラウザで開くなら true（記号を「↗」にする）。
  final bool isExternal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = onTap != null;

    return Opacity(
      // 無効は色ではなく不透明度 30% で示す（DESIGN.md §4）
      opacity: enabled ? 1 : 0.3,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: AppSize.minTarget,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                // 記号なので l10n には置かない
                isExternal ? '↗' : '→',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ラベル＋値＋「▼」だけの選択項目。枠も下線も持たない（DESIGN.md §6）。
///
/// `DropdownButton` ではなく `PopupMenuButton` を使っているのは、
/// DropdownButton が選択中の表示を固定高に押し込むため、
/// 2段の [LabelValue] がそのまま入らないから。
class _DropdownValue<T> extends StatelessWidget {
  const _DropdownValue({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;

  /// 閉じているときに見せる文字列。
  final String valueLabel;
  final T value;
  final List<(T, String)> items;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopupMenuButton<T>(
      initialValue: value,
      onSelected: onChanged,
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      tooltip: label,
      itemBuilder: (context) => [
        for (final (itemValue, itemLabel) in items)
          PopupMenuItem(
            value: itemValue,
            child: Text(itemLabel, style: theme.textTheme.titleMedium),
          ),
      ],
      child: SizedBox(
        height: AppSize.minTarget,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: LabelValue(
            label: label,
            value: valueLabel,
            trailing: Text('▼', style: theme.textTheme.labelSmall),
          ),
        ),
      ),
    );
  }
}
