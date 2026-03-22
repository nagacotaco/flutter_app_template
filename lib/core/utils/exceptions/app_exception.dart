import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
sealed class AppException with _$AppException implements Exception {
  /// ネットワーク接続エラー。
  ///
  /// オフライン状態やタイムアウトなど、通信そのものが失敗した場合に使用する。
  const factory AppException.network({
    @Default('ネットワークに接続できませんでした') String message,
  }) = NetworkException;

  /// サーバーエラー（4xx / 5xx）。
  ///
  /// HTTP レスポンスが返ってきたが、エラーステータスだった場合に使用する。
  const factory AppException.server({
    required int statusCode,
    @Default('サーバーエラーが発生しました') String message,
  }) = ServerException;

  /// 認証・認可エラー。
  ///
  /// ログイン失敗、トークン期限切れ、権限不足などに使用する。
  const factory AppException.auth({
    @Default('認証エラーが発生しました') String message,
  }) = AuthException;

  /// その他の予期しないエラー。
  ///
  /// [error] に元の例外オブジェクトを渡すとデバッグ時に役立つ。
  ///
  /// ```dart
  /// } catch (e) {
  ///   throw AppException.unknown(error: e);
  /// }
  /// ```
  const factory AppException.unknown({
    @Default('予期しないエラーが発生しました') String message,
    Object? error,
  }) = UnknownException;
}
