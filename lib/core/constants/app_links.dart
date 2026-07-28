/// 利用規約等の外部リンク。
/// IMPORTANT: コピー先アプリでは必ず自社の URL に差し替えること。
abstract final class AppLinks {
  static final Uri termsOfService = Uri.parse('https://example.com/terms');

  static final Uri privacyPolicy = Uri.parse('https://example.com/privacy');

  /// 強制アップデート画面から誘導するストアページ。
  /// iOS は App Store の URL、Android は Play ストアの URL に差し替える
  /// （プラットフォーム別に分けたい場合は Platform.isIOS で分岐させる）。
  static final Uri storePage = Uri.parse('https://example.com/store');
}
