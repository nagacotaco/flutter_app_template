import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/firebase/firebase_options_dev.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/features/auth/presentation/login_screen.dart';
import 'package:flutter_app_template/features/auth/presentation/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';

/// Google / Apple ログインの設定不備（クライアント ID・URL scheme・
/// entitlement）を、ネイティブ UI の起動可否で検出するスモークテスト。
///
/// - Google: サインインシートの起動まで到達し、設定エラーが出ないことを検証する
///   （アカウント選択以降は自動化できないため行わない）
/// - Apple: シミュレータに Apple ID が入っていないと必ずエラーになるため、
///   結果をログに出すだけで合否判定はしない。完全な確認は実機で行う
///
/// 実行: `fvm flutter test integration_test/social_login_smoke_test.dart
/// --flavor dev --dart-define-from-file=env/dev.json -d <デバイスID>`
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> pumpLoginScreen(WidgetTester tester) async {
    final container = ProviderContainer();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('ja'),
          home: const LoginScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  /// ボトムシートを開いて [label] の行をタップし、数秒待って画面状態を返す。
  Future<String?> tapSocialLogin(
    WidgetTester tester,
    ProviderContainer container,
    String label,
  ) async {
    await tester.tap(find.text('他の方法でログイン'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(label));
    // ネイティブ UI 起動待ち。isSubmitting 中は進捗バーが動き続けるため
    // pumpAndSettle は使えない
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 500));
    }
    return container.read(loginViewModelProvider).errorMessage;
  }

  testWidgets('Google サインインが設定エラーなくネイティブ UI 起動まで到達する', (tester) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final container = await pumpLoginScreen(tester);

    final errorMessage = await tapSocialLogin(tester, container, 'Googleでログイン');

    // 設定不備（クライアント ID 未設定・URL scheme 不一致等）は
    // authenticate() が即座に例外を投げ InlineError に表示される
    expect(errorMessage, isNull);
    expect(find.byType(InlineError), findsNothing);
  });

  testWidgets('Apple サインイン起動プローブ（ログ確認用・合否判定なし）', (tester) async {
    final container = await pumpLoginScreen(tester);

    final errorMessage = await tapSocialLogin(tester, container, 'Appleでログイン');

    // Apple ID 未ログインのシミュレータでは AuthorizationErrorCode.unknown が
    // 返るのが正常。entitlement 欠落は error 1000 以外の形で現れることがあるため
    // 結果を目視確認できるようログに残す
    debugPrint(
      'Apple sign-in probe result: '
      '${errorMessage ?? 'エラーなし（ネイティブシート起動）'}',
    );
  });
}
