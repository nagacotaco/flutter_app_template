import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム画面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/detail');
          },
          child: const Text('詳細画面へ遷移'),
        ),
      ),
    );
  }
}
