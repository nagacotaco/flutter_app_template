import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/config/app_config.dart';
import 'package:flutter_app_template/core/config/app_config_gate.dart';
import 'package:flutter_app_template/core/config/app_config_repository.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:flutter_app_template/features/auth/presentation/login_screen.dart';
import 'package:flutter_app_template/features/auth/presentation/password_reset_screen.dart';
import 'package:flutter_app_template/features/auth/presentation/phone_login_screen.dart';
import 'package:flutter_app_template/features/auth/presentation/signup_screen.dart';
import 'package:flutter_app_template/features/home/data/home_summary_repository.dart';
import 'package:flutter_app_template/features/home/presentation/home_screen.dart';
import 'package:flutter_app_template/features/items/data/item_repository.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_screen.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_screen.dart';
import 'package:flutter_app_template/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter_app_template/features/profile/data/profile_repository.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_edit_screen.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_screen.dart';
import 'package:flutter_app_template/features/purchase/presentation/paywall_screen.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/purchase/fake_purchase_repository.dart';
import 'features/home/fake_home_summary_repository.dart';
import 'features/items/fake_item_repository.dart';
import 'features/profile/fake_profile_repository.dart';

/// 全画面をライト/ダーク × 日本語/英語で描画し、レイアウトが破綻しないことを見る。
///
/// Pure Mono は余白と字の大きさだけで階層を作るので、文言が長い言語や
/// 大きなフォントで**はみ出し（RenderFlex overflow）が出やすい**。
/// 画面を追加したら [screens] に1行足すこと。
///
/// 見た目そのものの正しさ（DESIGN.md との一致）はここでは検証しない。
void main() {
  const user = AppUser(id: 'u1', email: 'taro.yamada@example.com');

  Future<void> pumpScreen(
    WidgetTester tester,
    Widget screen, {
    ThemeMode themeMode = ThemeMode.light,
    Locale locale = const Locale('ja'),
  }) async {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'app',
      packageName: 'app',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          itemRepositoryProvider.overrideWithValue(FakeItemRepository()),
          homeSummaryRepositoryProvider.overrideWithValue(
            FakeHomeSummaryRepository(),
          ),
          profileRepositoryProvider.overrideWithValue(FakeProfileRepository()),
          purchaseRepositoryProvider.overrideWithValue(
            FakePurchaseRepository(),
          ),
          currentUserProvider.overrideWith((ref) => user),
          authStateChangesProvider.overrideWith(
            (ref) => Stream<AppUser?>.value(user),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: screen,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  final screens = <String, Widget>{
    'login': const LoginScreen(),
    'signup': const SignupScreen(),
    'passwordReset': const PasswordResetScreen(),
    'phoneLogin': const PhoneLoginScreen(),
    'itemList': const ItemListScreen(),
    'itemDetail': const ItemDetailScreen(itemId: '1'),
    'settings': const SettingsScreen(),
    'profile': const ProfileScreen(),
    'profileEdit': const ProfileEditScreen(),
    'onboarding': const OnboardingScreen(),
    'home': const HomeScreen(),
    'paywall': const PaywallScreen(),
  };

  for (final entry in screens.entries) {
    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      for (final locale in [const Locale('ja'), const Locale('en')]) {
        testWidgets('${entry.key} / ${mode.name} / ${locale.languageCode}', (
          tester,
        ) async {
          tester.view.physicalSize = const Size(1125, 2436);
          tester.view.devicePixelRatio = 3;
          addTearDown(tester.view.reset);
          await pumpScreen(
            tester,
            entry.value,
            themeMode: mode,
            locale: locale,
          );
          expect(tester.takeException(), isNull);
        });
      }
    }
  }

  testWidgets('maintenance gate', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWith(
            (ref) => const AppConfig(
              maintenanceMode: true,
              maintenanceMessage:
                  'サーバー設備の入れ替え作業のため、本日 02:00 から 06:00 まで全機能を停止しています。'
                  '作業終了後は自動的にご利用いただけます。詳細はお知らせページをご確認ください。',
            ),
          ),
          currentBuildNumberProvider.overrideWith((ref) => 1),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          locale: const Locale('ja'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AppConfigGate(child: Text('app')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('force update gate', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWith(
            (ref) => const AppConfig(minBuildNumber: 20),
          ),
          currentBuildNumberProvider.overrideWith((ref) => 10),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AppConfigGate(child: Text('app')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
