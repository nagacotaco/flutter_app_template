// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter App Template';

  @override
  String get homeTitle => 'Home';

  @override
  String get itemsTitle => 'Items';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeTitle => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSystem => 'System';

  @override
  String get errorMessage => 'Something went wrong';

  @override
  String get errorRetryBody => 'Check your connection and try again.';

  @override
  String get retry => 'Retry';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginButton => 'Log in';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get loginWithGoogle => 'Continue with Google';

  @override
  String get loginWithApple => 'Continue with Apple';

  @override
  String get loginToSignup => 'Create an account';

  @override
  String get loginToPasswordReset => 'Forgot your password?';

  @override
  String get loginToPhoneLogin => 'Log in with phone number';

  @override
  String get authOtherMethods => 'Other sign-in options';

  @override
  String get authBackToLogin => 'Back to sign in';

  @override
  String get signupTitle => 'Sign up';

  @override
  String get signupHeadline => 'Get started';

  @override
  String get signupButton => 'Sign up';

  @override
  String get signupEmailSentTitle => 'Confirmation email sent';

  @override
  String get signupEmailSentBody =>
      'Follow the link in the email to complete sign up.';

  @override
  String get passwordResetTitle => 'Reset password';

  @override
  String get passwordResetButton => 'Send reset email';

  @override
  String get passwordResetSentTitle => 'Reset email sent';

  @override
  String get passwordResetSentBody =>
      'Follow the link in the email to set a new password. If it does not arrive, check your spam folder.';

  @override
  String get phoneLoginTitle => 'Phone login';

  @override
  String phoneStepLabel(int n) {
    return 'STEP $n';
  }

  @override
  String get phoneStep1Headline => 'Enter your phone number';

  @override
  String get phoneStep2Headline => 'Enter the code';

  @override
  String get authPhoneLabel => 'Phone number (+81... format)';

  @override
  String get authOtpLabel => 'Verification code';

  @override
  String get phoneSendOtpButton => 'Send verification code';

  @override
  String get phoneVerifyButton => 'Verify and log in';

  @override
  String get phoneBackToInput => 'Change phone number';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEditTitle => 'Edit profile';

  @override
  String get profileDisplayNameLabel => 'Display name';

  @override
  String get profileSaveButton => 'Save';

  @override
  String get profileChangeAvatarButton => 'Change avatar';

  @override
  String get profileNotSet => 'Not set';

  @override
  String get settingsTermsOfService => 'Terms of Service';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsPurchases => 'Plans & Purchases';

  @override
  String get settingsVersion => 'App version';

  @override
  String get settingsLogout => 'Log out';

  @override
  String get settingsDeleteAccount => 'Delete account';

  @override
  String get settingsDeleteAccountConfirmTitle => 'Delete account?';

  @override
  String get settingsDeleteAccountConfirmMessage =>
      'Your account and all data will be deleted. This cannot be undone.';

  @override
  String get settingsDeleteAccountConfirmButton => 'Delete';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get appConfigMaintenanceEyebrow => 'MAINTENANCE';

  @override
  String get appConfigMaintenanceTitle => 'Under maintenance';

  @override
  String get appConfigMaintenanceMessage =>
      'The app is currently under maintenance. Please try again later.';

  @override
  String get appConfigUpdateEyebrow => 'UPDATE REQUIRED';

  @override
  String get appConfigUpdateTitle => 'Update required';

  @override
  String get appConfigUpdateMessage =>
      'A new version is available. Please update from the store.';

  @override
  String get appConfigUpdateButton => 'Update';

  @override
  String get onboardingTitle1 => 'Welcome';

  @override
  String get onboardingBody1 =>
      'A quick tour of what you can do with this app.';

  @override
  String get onboardingTitle2 => 'Make it yours';

  @override
  String get onboardingBody2 =>
      'Change the theme and language anytime in Settings.';

  @override
  String get onboardingTitle3 => 'You\'re all set';

  @override
  String get onboardingBody3 => 'Let\'s get started.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get itemsEmptyMessage => 'No items yet';

  @override
  String get itemsEmptyBody => 'Add your first item and it will appear here.';

  @override
  String get itemsCountUnit => 'items';

  @override
  String itemsDetailMeta(String id) {
    return 'ID $id';
  }

  @override
  String get homeEmptyTitle => 'Nothing to show yet';

  @override
  String get homeEmptyBody => 'Add an item and a summary will appear here.';

  @override
  String get homePlaceholderPendingUnit => 'pending';

  @override
  String get homePlaceholderWeeklyDone => 'Done this week';

  @override
  String get homePlaceholderLastSync => 'Last sync';

  @override
  String get homePlaceholderRecentItems => 'Recent items';

  @override
  String get homePlaceholderViewItems => 'View items';

  @override
  String get paywallTitle => 'Plans';

  @override
  String get paywallProActive => 'You\'re on the Pro plan';

  @override
  String get paywallPurchaseButton => 'Purchase';

  @override
  String get paywallRestore => 'Restore Purchases';

  @override
  String get paywallRestoreNotFound => 'No purchases to restore';

  @override
  String get paywallUnavailableTitle => 'Products unavailable';

  @override
  String get paywallUnavailableBody =>
      'No products are available right now. Please try again later.';
}
