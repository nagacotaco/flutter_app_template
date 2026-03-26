import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:flutter_app_template/features/home/repositories/mock/sample_repository_mock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/home/domain/repositories/sample_repository.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        sampleRepositoryProvider.overrideWithValue(SampleRepositoryMock()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouter);
    return MaterialApp.router(
      title: 'Flutter App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
