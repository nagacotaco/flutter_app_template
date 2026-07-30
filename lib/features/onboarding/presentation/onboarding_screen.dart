import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:flutter_app_template/features/onboarding/data/onboarding_providers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 初回起動時のウォークスルー。完了/スキップでフラグを保存すると
/// router の redirect が次の画面（ログイン or ホーム）へ進める。
///
/// 96px の大アイコンは置かず、**「01 / 02 / 03」の大型数字**で番号を示す
/// （DESIGN.md §6）。ページ中央には差し替え用の空き領域を確保してあるので、
/// コピー先アプリはそこへイラストやスクリーンショットを入れる。
class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();
    final pageIndex = useState(0);
    final l10n = context.l10n;
    final pages = [
      (title: l10n.onboardingTitle1, body: l10n.onboardingBody1),
      (title: l10n.onboardingTitle2, body: l10n.onboardingBody2),
      (title: l10n.onboardingTitle3, body: l10n.onboardingBody3),
    ];
    final isLastPage = pageIndex.value == pages.length - 1;

    Future<void> complete() =>
        ref.read(onboardingCompletedProvider.notifier).complete();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: AppSpacing.screenHorizontal,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  style: AppButtonStyles.subtleText(context),
                  onPressed: complete,
                  child: Text(l10n.onboardingSkip),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) => pageIndex.value = index,
                itemCount: pages.length,
                itemBuilder: (context, index) => _OnboardingPage(
                  number: index + 1,
                  title: pages[index].title,
                  body: pages[index].body,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                0,
                AppSpacing.screenHorizontal,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      for (var i = 0; i < pages.length; i++)
                        _PageBar(isActive: i == pageIndex.value),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  FilledButton(
                    onPressed: isLastPage
                        ? complete
                        : () => controller.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          ),
                    child: Text(
                      isLastPage ? l10n.onboardingStart : l10n.onboardingNext,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.number,
    required this.title,
    required this.body,
  });

  final int number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number.toString().padLeft(2, '0'),
            style: AppTextTheme.display(theme.textTheme),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          // 差し替え領域。コピー先アプリはここにイラスト / スクリーンショットを入れる。
          // 枠線もプレースホルダー文言も置かない（面を作らないため）。
          // Flexible で包んでいるのは、画面が低いときに 16:9 を諦めて縮むようにするため
          // （文字が読めなくなるより空き領域が痩せるほうがよい）。
          const Flexible(
            child: AspectRatio(aspectRatio: 16 / 9, child: SizedBox.expand()),
          ),
        ],
      ),
    );
  }
}

/// ページインジケータ。ドットではなく幅の違う下線バーで現在位置を示す。
class _PageBar extends StatelessWidget {
  const _PageBar({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
      width: isActive ? 26 : 12,
      height: 2,
      color: isActive ? colors.onSurface : colors.outlineVariant,
    );
  }
}
