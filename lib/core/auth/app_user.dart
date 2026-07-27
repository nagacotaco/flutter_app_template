import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// ログインユーザーのバックエンド非依存表現。
/// Supabase の User / Firebase の User をこの型に変換して扱う。
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    String? email,
    String? phoneNumber,
  }) = _AppUser;
}
