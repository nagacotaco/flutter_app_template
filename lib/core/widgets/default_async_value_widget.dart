import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultAsyncValueWidget<T> extends StatelessWidget {
  const DefaultAsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.builder,
    this.onRetry,
  });
  final AsyncValue<T> asyncValue;
  final Widget Function(BuildContext context, T value) builder;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: (value) => builder(context, value),
      error: (error, stackTrace) => Center(
        // TODO: FLAVOR Devならエラー詳細を表示
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('エラーが発生しました: $error'),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('再試行'),
              ),
            ],
          ],
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
