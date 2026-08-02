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

  /// 共通エラー表示の見出し
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました'**
  String get errorMessage;

  /// 共通エラー表示の説明文（ErrorView）
  ///
  /// In ja, this message translates to:
  /// **'通信状況を確認して、もう一度お試しください。'**
  String get errorRetryBody;

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

  /// ログイン画面下部のリンク／ボトムシートの見出し（Google・Apple・電話番号をまとめる）
  ///
  /// In ja, this message translates to:
  /// **'他の方法でログイン'**
  String get authOtherMethods;

  /// 送信完了状態からログイン画面へ戻るリンク
  ///
  /// In ja, this message translates to:
  /// **'ログインに戻る'**
  String get authBackToLogin;

  /// サインアップ画面のタイトル（AppBar）
  ///
  /// In ja, this message translates to:
  /// **'アカウント登録'**
  String get signupTitle;

  /// サインアップ画面の大型見出し
  ///
  /// In ja, this message translates to:
  /// **'はじめる'**
  String get signupHeadline;

  /// サインアップ実行ボタン
  ///
  /// In ja, this message translates to:
  /// **'登録する'**
  String get signupButton;

  /// サインアップ後の見出し
  ///
  /// In ja, this message translates to:
  /// **'確認メールを送信しました'**
  String get signupEmailSentTitle;

  /// サインアップ後の説明文
  ///
  /// In ja, this message translates to:
  /// **'メール内のリンクから登録を完了してください。'**
  String get signupEmailSentBody;

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

  /// パスワード再設定メール送信後の見出し
  ///
  /// In ja, this message translates to:
  /// **'再設定メールを送信しました'**
  String get passwordResetSentTitle;

  /// パスワード再設定メール送信後の説明文
  ///
  /// In ja, this message translates to:
  /// **'メール内のリンクから新しいパスワードを設定してください。届かない場合は迷惑メールフォルダをご確認ください。'**
  String get passwordResetSentBody;

  /// 電話番号ログイン画面のタイトル（AppBar）
  ///
  /// In ja, this message translates to:
  /// **'電話番号ログイン'**
  String get phoneLoginTitle;

  /// 電話番号ログインのステップインジケータ
  ///
  /// In ja, this message translates to:
  /// **'STEP {n}'**
  String phoneStepLabel(int n);

  /// 電話番号ログイン STEP 1 の大型見出し
  ///
  /// In ja, this message translates to:
  /// **'電話番号を入力'**
  String get phoneStep1Headline;

  /// 電話番号ログイン STEP 2 の大型見出し
  ///
  /// In ja, this message translates to:
  /// **'認証コードを入力'**
  String get phoneStep2Headline;

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

  /// 設定: ペイウォール画面への遷移リンク
  ///
  /// In ja, this message translates to:
  /// **'プランと購入'**
  String get settingsPurchases;

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

  /// メンテナンス画面の小見出し（欧文固定。Archivo で表示する）
  ///
  /// In ja, this message translates to:
  /// **'MAINTENANCE'**
  String get appConfigMaintenanceEyebrow;

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

  /// 強制アップデート画面の小見出し（欧文固定。Archivo で表示する）
  ///
  /// In ja, this message translates to:
  /// **'UPDATE REQUIRED'**
  String get appConfigUpdateEyebrow;

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

  /// オンボーディング1ページ目タイトル（プレースホルダー）
  ///
  /// In ja, this message translates to:
  /// **'ようこそ'**
  String get onboardingTitle1;

  /// オンボーディング1ページ目本文（プレースホルダー）
  ///
  /// In ja, this message translates to:
  /// **'このアプリでできることを数ステップで紹介します。'**
  String get onboardingBody1;

  /// オンボーディング2ページ目タイトル（プレースホルダー）
  ///
  /// In ja, this message translates to:
  /// **'自分好みに'**
  String get onboardingTitle2;

  /// オンボーディング2ページ目本文（プレースホルダー）
  ///
  /// In ja, this message translates to:
  /// **'テーマや言語は設定画面からいつでも変更できます。'**
  String get onboardingBody2;

  /// オンボーディング3ページ目タイトル（プレースホルダー）
  ///
  /// In ja, this message translates to:
  /// **'準備完了'**
  String get onboardingTitle3;

  /// オンボーディング3ページ目本文（プレースホルダー）
  ///
  /// In ja, this message translates to:
  /// **'さっそく始めましょう。'**
  String get onboardingBody3;

  /// オンボーディングのスキップボタン
  ///
  /// In ja, this message translates to:
  /// **'スキップ'**
  String get onboardingSkip;

  /// オンボーディングの次ページボタン
  ///
  /// In ja, this message translates to:
  /// **'次へ'**
  String get onboardingNext;

  /// オンボーディング最終ページの完了ボタン
  ///
  /// In ja, this message translates to:
  /// **'はじめる'**
  String get onboardingStart;

  /// アイテム一覧の空状態の見出し
  ///
  /// In ja, this message translates to:
  /// **'アイテムがまだありません'**
  String get itemsEmptyMessage;

  /// アイテム一覧の空状態の説明文
  ///
  /// In ja, this message translates to:
  /// **'最初のアイテムを追加すると、ここに一覧が表示されます。'**
  String get itemsEmptyBody;

  /// アイテム一覧の件数の単位（大型数値の隣に置く）
  ///
  /// In ja, this message translates to:
  /// **'件'**
  String get itemsCountUnit;

  /// アイテム詳細のメタ行
  ///
  /// In ja, this message translates to:
  /// **'ID {id}'**
  String itemsDetailMeta(String id);

  /// ホームの空状態の見出し
  ///
  /// In ja, this message translates to:
  /// **'表示できる情報がまだありません'**
  String get homeEmptyTitle;

  /// ホームの空状態の説明文
  ///
  /// In ja, this message translates to:
  /// **'アイテムを追加すると、ここに概要が表示されます。'**
  String get homeEmptyBody;

  /// 【雛形のダミー文言】ホームの主数値の単位。コピー先アプリで homePlaceholder* ごと差し替える
  ///
  /// In ja, this message translates to:
  /// **'件の未対応'**
  String get homePlaceholderPendingUnit;

  /// 【雛形のダミー文言】ホームのラベル値ペア1
  ///
  /// In ja, this message translates to:
  /// **'今週の完了'**
  String get homePlaceholderWeeklyDone;

  /// 【雛形のダミー文言】ホームのラベル値ペア2
  ///
  /// In ja, this message translates to:
  /// **'最終同期'**
  String get homePlaceholderLastSync;

  /// 【雛形のダミー文言】ホームの直近リストの見出し
  ///
  /// In ja, this message translates to:
  /// **'最近のアイテム'**
  String get homePlaceholderRecentItems;

  /// 【雛形のダミー文言】ホーム空状態の CTA
  ///
  /// In ja, this message translates to:
  /// **'アイテムを見る'**
  String get homePlaceholderViewItems;

  /// ペイウォール画面のタイトル
  ///
  /// In ja, this message translates to:
  /// **'プラン'**
  String get paywallTitle;

  /// ペイウォール: すでに pro が有効なときの見出し
  ///
  /// In ja, this message translates to:
  /// **'Pro プランをご利用中です'**
  String get paywallProActive;

  /// ペイウォール: 購入ボタン
  ///
  /// In ja, this message translates to:
  /// **'購入する'**
  String get paywallPurchaseButton;

  /// ペイウォール: 購入の復元リンク
  ///
  /// In ja, this message translates to:
  /// **'購入を復元'**
  String get paywallRestore;

  /// ペイウォール: 復元しても有効な購入がなかったときの表示
  ///
  /// In ja, this message translates to:
  /// **'復元できる購入が見つかりませんでした'**
  String get paywallRestoreNotFound;

  /// ペイウォール: 商品が1件もないときの見出し（テンプレート状態でも表示される）
  ///
  /// In ja, this message translates to:
  /// **'商品を読み込めません'**
  String get paywallUnavailableTitle;

  /// ペイウォール: 商品が1件もないときの説明文
  ///
  /// In ja, this message translates to:
  /// **'現在購入できる商品がありません。時間をおいてもう一度お試しください。'**
  String get paywallUnavailableBody;
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
