import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/config/app_config_repository.dart';
import 'package:flutter_app_template/core/constants/app_links.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// アプリ設定による起動ゲート。MaterialApp.router の builder で全画面をラップする。
/// メンテナンス中はメンテナンス画面、ビルド番号が min_build_number 未満なら
/// 強制アップデート画面を出す。取得中・取得失敗時は通常どおりアプリを表示する
/// （オフラインで起動できなくなるのを避ける fail-open）。
class AppConfigGate extends ConsumerWidget {
  const AppConfigGate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider).value;
    final buildNumber = ref.watch(currentBuildNumberProvider).value;
    if (config == null || buildNumber == null) return child;

    if (config.maintenanceMode) {
      return _StatusScreen(
        eyebrow: context.l10n.appConfigMaintenanceEyebrow,
        title: context.l10n.appConfigMaintenanceTitle,
        message:
            config.maintenanceMessage ??
            context.l10n.appConfigMaintenanceMessage,
      );
    }
    if (buildNumber < config.minBuildNumber) {
      return _StatusScreen(
        eyebrow: context.l10n.appConfigUpdateEyebrow,
        title: context.l10n.appConfigUpdateTitle,
        message: context.l10n.appConfigUpdateMessage,
        // アプリ設定は「必要なビルド番号」しか持たないので、バージョン名ではなく
        // ビルド番号で現在 → 必要を示す（既存の取得値だけで完結させる）
        meta: '$buildNumber  →  ${config.minBuildNumber}',
        action: FilledButton(
          onPressed: () => launchUrl(
            AppLinks.storePage,
            mode: LaunchMode.externalApplication,
          ),
          child: Text(context.l10n.appConfigUpdateButton),
        ),
      );
    }
    return child;
  }
}

/// 操作できない全画面のゲート表示。
///
/// 64px のアイコンは置かず、**小見出し（欧文）＋大型見出し＋本文**の
/// タイポグラフィだけで構成する（DESIGN.md §6）。
/// サーバー配信の日本語本文が長くても崩れないよう、本文は最大6行で打ち切る。
class _StatusScreen extends StatelessWidget {
  const _StatusScreen({
    required this.eyebrow,
    required this.title,
    required this.message,
    this.meta,
    this.action,
  });

  final String eyebrow;
  final String title;
  final String message;

  /// 「現在 → 必要」などの補足行。Archivo で出す。
  final String? meta;

  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final action = this.action;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: AppSpacing.screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eyebrow,
                      style: theme.textTheme.labelSmall.archivo?.copyWith(
                        letterSpacing: 10 * 0.16,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(title, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (meta != null) ...[
                      const SizedBox(height: AppSpacing.xl),
                      Text(meta!, style: theme.textTheme.bodySmall.archivo),
                    ],
                  ],
                ),
              ),
            ),
            if (action != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  0,
                  AppSpacing.screenHorizontal,
                  AppSpacing.xxl,
                ),
                child: action,
              ),
          ],
        ),
      ),
    );
  }
}
