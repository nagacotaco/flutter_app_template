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
  String get settingsPlaceholder => '設定画面は Phase 3 で実装予定';

  @override
  String get errorMessage => 'エラーが発生しました';

  @override
  String get retry => '再試行';
}
