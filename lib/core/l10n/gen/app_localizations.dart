import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// アプリ名
  ///
  /// In ja, this message translates to:
  /// **'Flutter App Template'**
  String get appTitle;

  /// ホーム画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'ホーム'**
  String get homeTitle;

  /// アイテム一覧画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'アイテム'**
  String get itemsTitle;

  /// 設定画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'設定'**
  String get settingsTitle;

  /// 設定: テーマ選択の項目名
  ///
  /// In ja, this message translates to:
  /// **'テーマ'**
  String get settingsThemeTitle;

  /// 設定: テーマ「端末設定に従う」
  ///
  /// In ja, this message translates to:
  /// **'システム'**
  String get settingsThemeSystem;

  /// 設定: ライトテーマ
  ///
  /// In ja, this message translates to:
  /// **'ライト'**
  String get settingsThemeLight;

  /// 設定: ダークテーマ
  ///
  /// In ja, this message translates to:
  /// **'ダーク'**
  String get settingsThemeDark;

  /// 設定: 言語選択の項目名
  ///
  /// In ja, this message translates to:
  /// **'言語'**
  String get settingsLanguageTitle;

  /// 設定: 言語「端末設定に従う」
  ///
  /// In ja, this message translates to:
  /// **'システム'**
  String get settingsLanguageSystem;

  /// 共通エラー表示の文言
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました'**
  String get errorMessage;

  /// 再試行ボタン
  ///
  /// In ja, this message translates to:
  /// **'再試行'**
  String get retry;

  /// ログイン画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'ログイン'**
  String get loginTitle;

  /// ログイン実行ボタン
  ///
  /// In ja, this message translates to:
  /// **'ログイン'**
  String get loginButton;

  /// 認証: メールアドレス入力欄のラベル
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス'**
  String get authEmailLabel;

  /// 認証: パスワード入力欄のラベル
  ///
  /// In ja, this message translates to:
  /// **'パスワード'**
  String get authPasswordLabel;

  /// Google ログインボタン
  ///
  /// In ja, this message translates to:
  /// **'Googleでログイン'**
  String get loginWithGoogle;

  /// Apple ログインボタン
  ///
  /// In ja, this message translates to:
  /// **'Appleでログイン'**
  String get loginWithApple;

  /// ログイン画面からサインアップ画面へのリンク
  ///
  /// In ja, this message translates to:
  /// **'アカウント登録はこちら'**
  String get loginToSignup;

  /// ログイン画面からパスワード再設定画面へのリンク
  ///
  /// In ja, this message translates to:
  /// **'パスワードをお忘れの方'**
  String get loginToPasswordReset;

  /// ログイン画面から電話番号ログイン画面へのリンク
  ///
  /// In ja, this message translates to:
  /// **'電話番号でログイン'**
  String get loginToPhoneLogin;

  /// サインアップ画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'アカウント登録'**
  String get signupTitle;

  /// サインアップ実行ボタン
  ///
  /// In ja, this message translates to:
  /// **'登録する'**
  String get signupButton;

  /// サインアップ後の確認メール案内
  ///
  /// In ja, this message translates to:
  /// **'確認メールを送信しました。メール内のリンクから登録を完了してください。'**
  String get signupEmailSent;

  /// パスワード再設定画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'パスワード再設定'**
  String get passwordResetTitle;

  /// パスワード再設定メール送信ボタン
  ///
  /// In ja, this message translates to:
  /// **'再設定メールを送信'**
  String get passwordResetButton;

  /// パスワード再設定メール送信後の案内
  ///
  /// In ja, this message translates to:
  /// **'パスワード再設定メールを送信しました。メール内のリンクから再設定してください。'**
  String get passwordResetSent;

  /// 電話番号ログイン画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'電話番号ログイン'**
  String get phoneLoginTitle;

  /// 認証: 電話番号入力欄のラベル
  ///
  /// In ja, this message translates to:
  /// **'電話番号（+81... 形式）'**
  String get authPhoneLabel;

  /// 認証: SMS 認証コード入力欄のラベル
  ///
  /// In ja, this message translates to:
  /// **'認証コード'**
  String get authOtpLabel;

  /// SMS 認証コード送信ボタン
  ///
  /// In ja, this message translates to:
  /// **'認証コードを送信'**
  String get phoneSendOtpButton;

  /// SMS 認証コード検証ボタン
  ///
  /// In ja, this message translates to:
  /// **'認証してログイン'**
  String get phoneVerifyButton;

  /// OTP 入力から電話番号入力へ戻るリンク
  ///
  /// In ja, this message translates to:
  /// **'電話番号を変更する'**
  String get phoneBackToInput;

  /// プロフィール画面のタイトル・設定画面の項目名
  ///
  /// In ja, this message translates to:
  /// **'プロフィール'**
  String get profileTitle;

  /// プロフィール編集画面のタイトル・編集ボタン
  ///
  /// In ja, this message translates to:
  /// **'プロフィール編集'**
  String get profileEditTitle;

  /// プロフィール: 表示名のラベル
  ///
  /// In ja, this message translates to:
  /// **'表示名'**
  String get profileDisplayNameLabel;

  /// プロフィール編集の保存ボタン
  ///
  /// In ja, this message translates to:
  /// **'保存'**
  String get profileSaveButton;

  /// アバター画像の変更ボタン
  ///
  /// In ja, this message translates to:
  /// **'アバター画像を変更'**
  String get profileChangeAvatarButton;

  /// プロフィール項目が未設定のときの表示
  ///
  /// In ja, this message translates to:
  /// **'未設定'**
  String get profileNotSet;

  /// 設定: 利用規約リンク
  ///
  /// In ja, this message translates to:
  /// **'利用規約'**
  String get settingsTermsOfService;

  /// 設定: プライバシーポリシーリンク
  ///
  /// In ja, this message translates to:
  /// **'プライバシーポリシー'**
  String get settingsPrivacyPolicy;

  /// 設定: アプリバージョン表示の項目名
  ///
  /// In ja, this message translates to:
  /// **'アプリバージョン'**
  String get settingsVersion;

  /// 設定: ログアウト
  ///
  /// In ja, this message translates to:
  /// **'ログアウト'**
  String get settingsLogout;

  /// 設定: 退会
  ///
  /// In ja, this message translates to:
  /// **'退会（アカウント削除）'**
  String get settingsDeleteAccount;

  /// 退会確認ダイアログのタイトル
  ///
  /// In ja, this message translates to:
  /// **'退会しますか？'**
  String get settingsDeleteAccountConfirmTitle;

  /// 退会確認ダイアログの本文
  ///
  /// In ja, this message translates to:
  /// **'アカウントとすべてのデータが削除されます。この操作は取り消せません。'**
  String get settingsDeleteAccountConfirmMessage;

  /// 退会確認ダイアログの実行ボタン
  ///
  /// In ja, this message translates to:
  /// **'退会する'**
  String get settingsDeleteAccountConfirmButton;

  /// 共通: キャンセルボタン
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get commonCancel;

  /// メンテナンス画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'メンテナンス中'**
  String get appConfigMaintenanceTitle;

  /// メンテナンス画面のデフォルト本文（サーバー配信の文言がない場合）
  ///
  /// In ja, this message translates to:
  /// **'ただいまメンテナンス中です。しばらくしてからもう一度お試しください。'**
  String get appConfigMaintenanceMessage;

  /// 強制アップデート画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'アップデートが必要です'**
  String get appConfigUpdateTitle;

  /// 強制アップデート画面の本文
  ///
  /// In ja, this message translates to:
  /// **'新しいバージョンが公開されています。ストアから最新版に更新してください。'**
  String get appConfigUpdateMessage;

  /// 強制アップデート画面のストア誘導ボタン
  ///
  /// In ja, this message translates to:
  /// **'更新する'**
  String get appConfigUpdateButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
