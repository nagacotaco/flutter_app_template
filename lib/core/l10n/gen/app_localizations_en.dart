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
  String get signupTitle => 'Sign up';

  @override
  String get signupButton => 'Sign up';

  @override
  String get signupEmailSent =>
      'A confirmation email has been sent. Follow the link in the email to complete sign up.';

  @override
  String get passwordResetTitle => 'Reset password';

  @override
  String get passwordResetButton => 'Send reset email';

  @override
  String get passwordResetSent =>
      'A password reset email has been sent. Follow the link in the email to reset your password.';

  @override
  String get phoneLoginTitle => 'Phone login';

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
}
