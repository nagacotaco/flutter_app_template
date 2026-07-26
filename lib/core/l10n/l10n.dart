import 'package:flutter/widgets.dart';

import 'package:flutter_app_template/core/l10n/gen/app_localizations.dart';

export 'package:flutter_app_template/core/l10n/gen/app_localizations.dart';

/// 文言へは `context.l10n.xxx` でアクセスする。
/// 文言の追加は `lib/core/l10n/arb/` の arb ファイルに行い、
/// `fvm flutter gen-l10n` で再生成する。
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
