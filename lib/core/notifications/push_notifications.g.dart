// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notifications.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// プッシュ通知の初期化。App から watch され、起動時に1回実行される。
/// - 通知許可のリクエスト（タイミングを変えたいアプリはここから移す）
/// - FCM トークンの取得（バックエンドへの保存はアプリ固有のため TODO）
/// - 通知タップ時に data の `path` へ遷移するリスナー登録

@ProviderFor(pushNotificationInit)
final pushNotificationInitProvider = PushNotificationInitProvider._();

/// プッシュ通知の初期化。App から watch され、起動時に1回実行される。
/// - 通知許可のリクエスト（タイミングを変えたいアプリはここから移す）
/// - FCM トークンの取得（バックエンドへの保存はアプリ固有のため TODO）
/// - 通知タップ時に data の `path` へ遷移するリスナー登録

final class PushNotificationInitProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// プッシュ通知の初期化。App から watch され、起動時に1回実行される。
  /// - 通知許可のリクエスト（タイミングを変えたいアプリはここから移す）
  /// - FCM トークンの取得（バックエンドへの保存はアプリ固有のため TODO）
  /// - 通知タップ時に data の `path` へ遷移するリスナー登録
  PushNotificationInitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushNotificationInitProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushNotificationInitHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return pushNotificationInit(ref);
  }
}

String _$pushNotificationInitHash() =>
    r'27f5fbad165b328ea50a6e6f5e04ba6193019cc3';
