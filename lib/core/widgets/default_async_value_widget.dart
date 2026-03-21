import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultAsyncValueWidget<T> extends StatelessWidget {
  const DefaultAsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.builder,
  });
  final AsyncValue<T> asyncValue;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: (value) => builder(context, value),
      error: (error, stackTrace) => Center(
        // TODO: FLAVOR Devならエラー詳細を表示
        child: Text('エラーが発生しました'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
