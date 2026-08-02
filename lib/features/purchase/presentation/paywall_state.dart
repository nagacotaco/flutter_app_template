import 'package:flutter_app_template/core/purchase/paywall_package.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paywall_state.freezed.dart';

@freezed
abstract class PaywallState with _$PaywallState {
  const factory PaywallState({
    /// 現在の Offering のパッケージ一覧。空 = 商品未設定（テンプレート状態）。
    @Default([]) List<PaywallPackage> packages,

    /// 選択中のパッケージ ID。
    String? selectedPackageId,

    /// 購入・復元の処理中。
    @Default(false) bool isProcessing,

    String? errorMessage,

    /// 復元したが有効な購入が見つからなかった。
    @Default(false) bool restoreNotFound,
  }) = _PaywallState;
}
