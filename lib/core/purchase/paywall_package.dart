import 'package:freezed_annotation/freezed_annotation.dart';

part 'paywall_package.freezed.dart';

/// ペイウォールに表示する購入パッケージ。
/// RevenueCat SDK の型（Package / StoreProduct）を UI 層へ漏らさないための薄いモデル。
@freezed
abstract class PaywallPackage with _$PaywallPackage {
  const factory PaywallPackage({
    /// RevenueCat の Package identifier（例: `$rc_monthly`）。
    required String id,

    /// ストアに登録した商品名。
    required String title,

    /// ストアに登録した商品説明。
    required String description,

    /// 端末ロケールで整形済みの価格表示（例: ¥480）。
    required String priceString,
  }) = _PaywallPackage;
}
