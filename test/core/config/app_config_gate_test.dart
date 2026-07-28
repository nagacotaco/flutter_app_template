import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/config/app_config.dart';
import 'package:flutter_app_template/core/config/app_config_gate.dart';
import 'package:flutter_app_template/core/config/app_config_repository.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  Widget buildGate({required AppConfig config, required int buildNumber}) {
    return ProviderScope(
      overrides: [
        appConfigProvider.overrideWith((ref) => config),
        currentBuildNumberProvider.overrideWith((ref) => buildNumber),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppConfigGate(child: Text('app content')),
      ),
    );
  }

  testWidgets('制限なしなら子ウィジェットを表示する', (tester) async {
    await tester.pumpWidget(
      buildGate(config: const AppConfig(), buildNumber: 1),
    );
    await tester.pumpAndSettle();

    expect(find.text('app content'), findsOneWidget);
  });

  testWidgets('メンテナンスモードならメンテナンス画面を表示する', (tester) async {
    await tester.pumpWidget(
      buildGate(config: const AppConfig(maintenanceMode: true), buildNumber: 1),
    );
    await tester.pumpAndSettle();

    expect(find.text('Under maintenance'), findsOneWidget);
    expect(find.text('app content'), findsNothing);
  });

  testWidgets('サーバー配信のメンテナンス文言があればそれを表示する', (tester) async {
    await tester.pumpWidget(
      buildGate(
        config: const AppConfig(
          maintenanceMode: true,
          maintenanceMessage: '深夜2時まで停止します',
        ),
        buildNumber: 1,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('深夜2時まで停止します'), findsOneWidget);
  });

  testWidgets('ビルド番号が min_build_number 未満なら強制アップデート画面を表示する', (tester) async {
    await tester.pumpWidget(
      buildGate(config: const AppConfig(minBuildNumber: 10), buildNumber: 9),
    );
    await tester.pumpAndSettle();

    expect(find.text('Update required'), findsOneWidget);
    expect(find.text('app content'), findsNothing);
  });
}
