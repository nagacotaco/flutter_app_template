// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Flutter App Template';

  @override
  String get homeTitle => 'ホーム';

  @override
  String get itemsTitle => 'アイテム';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsThemeTitle => 'テーマ';

  @override
  String get settingsThemeSystem => 'システム';

  @override
  String get settingsThemeLight => 'ライト';

  @override
  String get settingsThemeDark => 'ダーク';

  @override
  String get settingsLanguageTitle => '言語';

  @override
  String get settingsLanguageSystem => 'システム';

  @override
  String get errorMessage => 'エラーが発生しました';

  @override
  String get errorRetryBody => '通信状況を確認して、もう一度お試しください。';

  @override
  String get retry => '再試行';

  @override
  String get loginTitle => 'ログイン';

  @override
  String get loginButton => 'ログイン';

  @override
  String get authEmailLabel => 'メールアドレス';

  @override
  String get authPasswordLabel => 'パスワード';

  @override
  String get loginWithGoogle => 'Googleでログイン';

  @override
  String get loginWithApple => 'Appleでログイン';

  @override
  String get loginToSignup => 'アカウント登録はこちら';

  @override
  String get loginToPasswordReset => 'パスワードをお忘れの方';

  @override
  String get loginToPhoneLogin => '電話番号でログイン';

  @override
  String get authOtherMethods => '他の方法でログイン';

  @override
  String get authBackToLogin => 'ログインに戻る';

  @override
  String get signupTitle => 'アカウント登録';

  @override
  String get signupHeadline => 'はじめる';

  @override
  String get signupButton => '登録する';

  @override
  String get signupEmailSentTitle => '確認メールを送信しました';

  @override
  String get signupEmailSentBody => 'メール内のリンクから登録を完了してください。';

  @override
  String get passwordResetTitle => 'パスワード再設定';

  @override
  String get passwordResetButton => '再設定メールを送信';

  @override
  String get passwordResetSentTitle => '再設定メールを送信しました';

  @override
  String get passwordResetSentBody =>
      'メール内のリンクから新しいパスワードを設定してください。届かない場合は迷惑メールフォルダをご確認ください。';

  @override
  String get phoneLoginTitle => '電話番号ログイン';

  @override
  String phoneStepLabel(int n) {
    return 'STEP $n';
  }

  @override
  String get phoneStep1Headline => '電話番号を入力';

  @override
  String get phoneStep2Headline => '認証コードを入力';

  @override
  String get authPhoneLabel => '電話番号（+81... 形式）';

  @override
  String get authOtpLabel => '認証コード';

  @override
  String get phoneSendOtpButton => '認証コードを送信';

  @override
  String get phoneVerifyButton => '認証してログイン';

  @override
  String get phoneBackToInput => '電話番号を変更する';

  @override
  String get profileTitle => 'プロフィール';

  @override
  String get profileEditTitle => 'プロフィール編集';

  @override
  String get profileDisplayNameLabel => '表示名';

  @override
  String get profileSaveButton => '保存';

  @override
  String get profileChangeAvatarButton => 'アバター画像を変更';

  @override
  String get profileNotSet => '未設定';

  @override
  String get settingsTermsOfService => '利用規約';

  @override
  String get settingsPrivacyPolicy => 'プライバシーポリシー';

  @override
  String get settingsPurchases => 'プランと購入';

  @override
  String get settingsVersion => 'アプリバージョン';

  @override
  String get settingsLogout => 'ログアウト';

  @override
  String get settingsDeleteAccount => '退会（アカウント削除）';

  @override
  String get settingsDeleteAccountConfirmTitle => '退会しますか？';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'アカウントとすべてのデータが削除されます。この操作は取り消せません。';

  @override
  String get settingsDeleteAccountConfirmButton => '退会する';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get appConfigMaintenanceEyebrow => 'MAINTENANCE';

  @override
  String get appConfigMaintenanceTitle => 'メンテナンス中';

  @override
  String get appConfigMaintenanceMessage =>
      'ただいまメンテナンス中です。しばらくしてからもう一度お試しください。';

  @override
  String get appConfigUpdateEyebrow => 'UPDATE REQUIRED';

  @override
  String get appConfigUpdateTitle => 'アップデートが必要です';

  @override
  String get appConfigUpdateMessage => '新しいバージョンが公開されています。ストアから最新版に更新してください。';

  @override
  String get appConfigUpdateButton => '更新する';

  @override
  String get onboardingTitle1 => 'ようこそ';

  @override
  String get onboardingBody1 => 'このアプリでできることを数ステップで紹介します。';

  @override
  String get onboardingTitle2 => '自分好みに';

  @override
  String get onboardingBody2 => 'テーマや言語は設定画面からいつでも変更できます。';

  @override
  String get onboardingTitle3 => '準備完了';

  @override
  String get onboardingBody3 => 'さっそく始めましょう。';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingStart => 'はじめる';

  @override
  String get itemsEmptyMessage => 'アイテムがまだありません';

  @override
  String get itemsEmptyBody => '最初のアイテムを追加すると、ここに一覧が表示されます。';

  @override
  String get itemsCountUnit => '件';

  @override
  String itemsDetailMeta(String id) {
    return 'ID $id';
  }

  @override
  String get homeEmptyTitle => '表示できる情報がまだありません';

  @override
  String get homeEmptyBody => 'アイテムを追加すると、ここに概要が表示されます。';

  @override
  String get homePlaceholderPendingUnit => '件の未対応';

  @override
  String get homePlaceholderWeeklyDone => '今週の完了';

  @override
  String get homePlaceholderLastSync => '最終同期';

  @override
  String get homePlaceholderRecentItems => '最近のアイテム';

  @override
  String get homePlaceholderViewItems => 'アイテムを見る';

  @override
  String get paywallTitle => 'プラン';

  @override
  String get paywallProActive => 'Pro プランをご利用中です';

  @override
  String get paywallPurchaseButton => '購入する';

  @override
  String get paywallRestore => '購入を復元';

  @override
  String get paywallRestoreNotFound => '復元できる購入が見つかりませんでした';

  @override
  String get paywallUnavailableTitle => '商品を読み込めません';

  @override
  String get paywallUnavailableBody => '現在購入できる商品がありません。時間をおいてもう一度お試しください。';
}
