import 'package:flutter_app_template/core/purchase/purchase_providers.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';
import 'package:flutter_app_template/features/purchase/presentation/paywall_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'paywall_view_model.g.dart';

@riverpod
class PaywallViewModel extends _$PaywallViewModel {
  @override
  Future<PaywallState> build() async {
    // SDK の初期化完了を待ってから商品を取る（キー未設定なら即座に空が返る）
    await ref.watch(purchaseInitProvider.future);
    final packages = await ref
        .watch(purchaseRepositoryProvider)
        .fetchCurrentPackages();
    return PaywallState(
      packages: packages,
      // 先頭を初期選択にする（1プランのアプリでは選択操作が不要になる）
      selectedPackageId: packages.firstOrNull?.id,
    );
  }

  void select(String packageId) {
    final current = state.value;
    if (current == null || current.isProcessing) return;
    state = AsyncData(current.copyWith(selectedPackageId: packageId));
  }

  /// 購入成功の画面反映（pro 表示への切り替え）は isProProvider が拾うので、
  /// ここでは処理中フラグとエラーだけを管理する。キャンセルは何も表示しない。
  Future<void> purchase() async {
    final current = state.value;
    final packageId = current?.selectedPackageId;
    if (current == null || packageId == null || current.isProcessing) return;
    state = AsyncData(
      current.copyWith(
        isProcessing: true,
        errorMessage: null,
        restoreNotFound: false,
      ),
    );
    try {
      await ref.read(purchaseRepositoryProvider).purchase(packageId);
      state = AsyncData(current.copyWith(isProcessing: false));
    } on Exception catch (e) {
      state = AsyncData(
        current.copyWith(isProcessing: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> restore() async {
    final current = state.value;
    if (current == null || current.isProcessing) return;
    state = AsyncData(
      current.copyWith(
        isProcessing: true,
        errorMessage: null,
        restoreNotFound: false,
      ),
    );
    try {
      final restored = await ref.read(purchaseRepositoryProvider).restore();
      state = AsyncData(
        current.copyWith(isProcessing: false, restoreNotFound: !restored),
      );
    } on Exception catch (e) {
      state = AsyncData(
        current.copyWith(isProcessing: false, errorMessage: e.toString()),
      );
    }
  }
}
