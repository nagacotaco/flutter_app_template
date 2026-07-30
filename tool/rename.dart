// テンプレートをコピーした直後に1回だけ実行する、アプリ名・Bundle ID の一括リネームスクリプト。
//
// 実行例:
//   fvm dart run tool/rename.dart --name "MyApp" --bundle-id com.example.myapp --dry-run
//   fvm dart run tool/rename.dart --name "MyApp" --bundle-id com.example.myapp
//
// 前提:
// - アプリ名・Bundle ID の唯一の定義元は pubspec.yaml の `flavorizr:` セクション。
//   このスクリプトは pubspec と「flavorizr が生成済みのネイティブ設定ファイル」を直接書き換える。
//   `flutter_flavorizr -f` は実行しない（iOS の APNs entitlements / URL scheme 等の手動設定を壊すため）。
// - テンプレートの初期状態から1回だけ実行する想定。2回目以降は対象が見つからずエラーになる。

import 'dart:io';

// ---------------------------------------------------------------------------
// テンプレート側の現在値（唯一の定義元。テンプレートの値を変えたらここも直す）
// ---------------------------------------------------------------------------

const _oldPackage = 'flutter_app_template';
const _oldAndroidAppId = 'tech.tetrabox.flutter_app_template';
const _oldIosBundleId = 'tech.tetrabox.flutterAppTemplate';
const _oldAppName = 'Template';

const _usage = '''
使い方:
  fvm dart run tool/rename.dart --name <アプリ名> --bundle-id <Bundle ID> [options]

必須:
  --name <string>        アプリ表示名（prod）。dev は "<name> Dev" になる。例: "MyApp"
  --bundle-id <string>   Bundle ID / applicationId（prod）。dev は "<bundle-id>.dev" になる。
                         iOS / Android で同じ値を使う。例: com.example.myapp

任意:
  --package <string>     Dart のパッケージ名（snake_case）。省略時は --name から生成する。
  --dry-run              変更内容を表示するだけで書き込まない。
  --yes                  確認プロンプトを出さずに実行する。
  --force                git の作業ツリーが汚れていても実行する。
  -h, --help             このヘルプを表示する。
''';

void main(List<String> args) {
  final opts = _parseArgs(args);
  if (opts == null) return;

  final plan = _buildPlan(opts);

  _printPlan(plan, opts);

  if (opts.dryRun) {
    stdout.writeln('\n--dry-run のため書き込みは行っていない。');
    return;
  }

  if (!opts.yes && !_confirm()) {
    stdout.writeln('中止した。');
    return;
  }

  _apply(plan);
  _printChecklist(opts);
}

// ---------------------------------------------------------------------------
// 引数
// ---------------------------------------------------------------------------

class _Options {
  _Options({
    required this.appName,
    required this.bundleId,
    required this.package,
    required this.dryRun,
    required this.yes,
  });

  final String appName;
  final String bundleId;
  final String package;
  final bool dryRun;
  final bool yes;

  String get devAppName => '$appName Dev';
  String get devBundleId => '$bundleId.dev';
}

_Options? _parseArgs(List<String> args) {
  String? name;
  String? bundleId;
  String? package;
  var dryRun = false;
  var yes = false;
  var force = false;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    String next(String flag) {
      if (i + 1 >= args.length) _fail('$flag に値が指定されていない。');
      return args[++i];
    }

    switch (arg) {
      case '--name':
        name = next(arg);
      case '--bundle-id':
        bundleId = next(arg);
      case '--package':
        package = next(arg);
      case '--dry-run':
        dryRun = true;
      case '--yes':
        yes = true;
      case '--force':
        force = true;
      case '-h':
      case '--help':
        stdout.writeln(_usage);
        return null;
      default:
        _fail('不明な引数: $arg\n\n$_usage');
    }
  }

  if (name == null || bundleId == null) {
    _fail('--name と --bundle-id は必須。\n\n$_usage');
  }

  final appName = name.trim();
  if (appName.isEmpty) _fail('--name が空。');

  _validateBundleId(bundleId);

  final pkg = package ?? _toSnakeCase(appName);
  _validateDartPackageName(pkg);

  if (!File('pubspec.yaml').existsSync()) {
    _fail('pubspec.yaml が見つからない。プロジェクトルートで実行すること。');
  }
  if (!dryRun && !force) _requireCleanGitTree();

  return _Options(
    appName: appName,
    bundleId: bundleId,
    package: pkg,
    dryRun: dryRun,
    yes: yes,
  );
}

const _reservedSegments = {
  // Java / Kotlin の予約語。ディレクトリ名兼パッケージ名になるので弾く。
  'abstract', 'assert', 'boolean', 'break', 'byte', 'case', 'catch', 'char',
  'class', 'const', 'continue', 'default', 'do', 'double', 'else', 'enum',
  'extends', 'final', 'finally', 'float', 'for', 'fun', 'goto', 'if',
  'implements', 'import', 'in', 'instanceof', 'int', 'interface', 'is', 'long',
  'native', 'new', 'object', 'package', 'private', 'protected', 'public',
  'return', 'short', 'static', 'strictfp', 'super', 'switch', 'synchronized',
  'this', 'throw', 'throws', 'transient', 'try', 'typealias', 'val', 'var',
  'void', 'volatile', 'when', 'while',
};

void _validateBundleId(String value) {
  final segments = value.split('.');
  if (segments.length < 2) {
    _fail('--bundle-id は2つ以上のセグメントが必要（例: com.example.myapp）: $value');
  }
  final pattern = RegExp(r'^[a-z][a-z0-9_]*$');
  for (final segment in segments) {
    if (!pattern.hasMatch(segment)) {
      _fail(
        '--bundle-id のセグメント "$segment" が不正。'
        '英小文字で始まり、英小文字・数字・アンダースコアのみ使える: $value',
      );
    }
    if (_reservedSegments.contains(segment)) {
      _fail('--bundle-id のセグメント "$segment" は Java/Kotlin の予約語で使えない: $value');
    }
  }
  if (segments.last == 'dev') {
    _fail('--bundle-id の末尾を "dev" にはできない（dev flavor と衝突する）: $value');
  }
}

void _validateDartPackageName(String value) {
  if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(value)) {
    _fail('--package は英小文字で始まる snake_case にすること: $value');
  }
  if (_dartReserved.contains(value)) {
    _fail('--package が Dart の予約語になっている: $value');
  }
}

const _dartReserved = {
  'assert', 'break', 'case', 'catch', 'class', 'const', 'continue', 'default',
  'do', 'else', 'enum', 'extends', 'false', 'final', 'finally', 'for', 'if',
  'in', 'is', 'new', 'null', 'rethrow', 'return', 'super', 'switch', 'this',
  'throw', 'true', 'try', 'var', 'void', 'while', 'with',
};

String _toSnakeCase(String value) {
  final normalized = value
      .replaceAllMapped(
        RegExp('([a-z0-9])([A-Z])'),
        (m) => '${m[1]}_${m[2]}',
      )
      .replaceAll(RegExp(r'[\s\-]+'), '_')
      .toLowerCase()
      .replaceAll(RegExp('[^a-z0-9_]'), '')
      .replaceAll(RegExp('_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
  if (normalized.isEmpty || RegExp('^[0-9]').hasMatch(normalized)) {
    _fail('--name から Dart パッケージ名を生成できなかった。--package を明示すること。');
  }
  return normalized;
}

void _requireCleanGitTree() {
  final ProcessResult result;
  try {
    result = Process.runSync('git', ['status', '--porcelain']);
  } on ProcessException {
    return; // git が無い環境ではチェックしない
  }
  if (result.exitCode != 0) return; // git リポジトリではない
  if ((result.stdout as String).trim().isNotEmpty) {
    _fail(
      'git の作業ツリーに未コミットの変更がある。'
      'リネームは広範囲を書き換えるので、コミットしてから実行すること（--force で無視できる）。',
    );
  }
}

// ---------------------------------------------------------------------------
// 変更計画
// ---------------------------------------------------------------------------

/// 1ファイルに対する文字列置換。
class _Edit {
  _Edit(this.path, this.subs);

  final String path;
  final List<(String from, String to)> subs;
}

class _Move {
  _Move(this.from, this.to);

  final String from;
  final String to;
}

class _Plan {
  final edits = <_Edit>[];
  final moves = <_Move>[];
}

_Plan _buildPlan(_Options o) {
  final plan = _Plan();

  // 1. Dart のパッケージ import
  for (final dir in ['lib', 'test', 'integration_test']) {
    final root = Directory(dir);
    if (!root.existsSync()) continue;
    for (final entity in root.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      plan.edits.add(
        // 長い識別子から先に置換する（短い方が部分文字列になっているため）。
        _Edit(entity.path, [
          // firebase_options_*.dart の iosBundleId。ファイル自体は
          // flutterfire configure で作り直す前提だが、旧 ID を残さない。
          (_oldIosBundleId, o.bundleId),
          // settings のテストが PackageInfo のモック値として持っている packageName。
          (_oldAndroidAppId, o.bundleId),
          ('package:$_oldPackage/', 'package:${o.package}/'),
          ("appName: '$_oldPackage'", "appName: '${o.package}'"),
        ]),
      );
    }
  }

  // 2. pubspec.yaml（アプリ名・Bundle ID の唯一の定義元）
  plan.edits.add(
    _Edit('pubspec.yaml', [
      ('name: $_oldPackage\n', 'name: ${o.package}\n'),
      ('name: "$_oldAppName Dev"', 'name: "${o.devAppName}"'),
      ('name: "$_oldAppName"', 'name: "${o.appName}"'),
      ('applicationId: "$_oldAndroidAppId.dev"', 'applicationId: "${o.devBundleId}"'),
      ('applicationId: "$_oldAndroidAppId"', 'applicationId: "${o.bundleId}"'),
      ('bundleId: "$_oldIosBundleId.dev"', 'bundleId: "${o.devBundleId}"'),
      ('bundleId: "$_oldIosBundleId"', 'bundleId: "${o.bundleId}"'),
    ]),
  );

  // 3. Android
  plan.edits
    ..add(
      _Edit('android/app/build.gradle.kts', [
        ('namespace = "$_oldAndroidAppId"', 'namespace = "${o.bundleId}"'),
        ('applicationId = "$_oldAndroidAppId"', 'applicationId = "${o.bundleId}"'),
      ]),
    )
    ..add(
      _Edit('android/app/flavorizr.gradle.kts', [
        ('applicationId = "$_oldAndroidAppId.dev"', 'applicationId = "${o.devBundleId}"'),
        ('applicationId = "$_oldAndroidAppId"', 'applicationId = "${o.bundleId}"'),
        ('value = "$_oldAppName Dev"', 'value = "${o.devAppName}"'),
        ('value = "$_oldAppName"', 'value = "${o.appName}"'),
      ]),
    );

  // 4. Kotlin の MainActivity（パッケージ宣言 + ディレクトリ移動）
  final oldKotlinDir =
      'android/app/src/main/kotlin/${_oldAndroidAppId.replaceAll('.', '/')}';
  final newKotlinDir =
      'android/app/src/main/kotlin/${o.bundleId.replaceAll('.', '/')}';
  if (Directory(oldKotlinDir).existsSync()) {
    plan.edits.add(
      _Edit('$oldKotlinDir/MainActivity.kt', [
        ('package $_oldAndroidAppId', 'package ${o.bundleId}'),
      ]),
    );
    plan.moves.add(_Move(oldKotlinDir, newKotlinDir));
  }

  // 5. iOS の xcconfig（表示名）
  for (final flavor in ['dev', 'prod']) {
    for (final mode in ['Debug', 'Profile', 'Release']) {
      final path = 'ios/Flutter/$flavor$mode.xcconfig';
      if (!File(path).existsSync()) continue;
      final name = flavor == 'dev' ? o.devAppName : o.appName;
      final oldName = flavor == 'dev' ? '$_oldAppName Dev' : _oldAppName;
      plan.edits.add(
        _Edit(path, [
          ('BUNDLE_NAME=$oldName\n', 'BUNDLE_NAME=$name\n'),
          ('BUNDLE_DISPLAY_NAME=$oldName\n', 'BUNDLE_DISPLAY_NAME=$name\n'),
        ]),
      );
    }
  }

  // 6. iOS の pbxproj（Bundle ID）。.dev / .RunnerTests は接尾辞として残る
  plan.edits.add(
    _Edit('ios/Runner.xcodeproj/project.pbxproj', [
      (_oldIosBundleId, o.bundleId),
    ]),
  );

  // 7. ドキュメントの見出し
  plan.edits
    ..add(_Edit('README.md', [('# $_oldPackage\n', '# ${o.package}\n')]))
    ..add(_Edit('CLAUDE.md', [('# $_oldPackage\n', '# ${o.package}\n')]));

  // 8. IntelliJ のモジュールファイル（gitignore 済みだが手元に残るので合わせる）
  if (File('$_oldPackage.iml').existsSync()) {
    plan.moves.add(_Move('$_oldPackage.iml', '${o.package}.iml'));
  }

  return plan;
}

// ---------------------------------------------------------------------------
// 表示・適用
// ---------------------------------------------------------------------------

int _countHits(String content, String from) {
  if (from.isEmpty) return 0;
  return from.allMatches(content).length;
}

void _printPlan(_Plan plan, _Options o) {
  stdout
    ..writeln('リネーム内容:')
    ..writeln('  アプリ名   : $_oldAppName / $_oldAppName Dev'
        ' -> ${o.appName} / ${o.devAppName}')
    ..writeln('  Bundle ID  : $_oldAndroidAppId (Android)'
        ' / $_oldIosBundleId (iOS)'
        ' -> ${o.bundleId}')
    ..writeln('  dev        : ${o.devBundleId}')
    ..writeln('  パッケージ : $_oldPackage -> ${o.package}')
    ..writeln('');

  var changedFiles = 0;
  var totalHits = 0;
  final missing = <String>[];

  for (final edit in plan.edits) {
    final file = File(edit.path);
    if (!file.existsSync()) {
      missing.add(edit.path);
      continue;
    }
    final content = file.readAsStringSync();
    final hits = edit.subs.fold<int>(
      0,
      (sum, sub) => sum + _countHits(content, sub.$1),
    );
    if (hits == 0) continue;
    changedFiles++;
    totalHits += hits;
    stdout.writeln('  [edit] ${edit.path} ($hits 箇所)');
  }

  for (final move in plan.moves) {
    stdout.writeln('  [move] ${move.from} -> ${move.to}');
  }

  if (missing.isNotEmpty) {
    stdout.writeln('\n見つからなかったファイル（スキップ）:');
    for (final path in missing) {
      stdout.writeln('  - $path');
    }
  }

  stdout.writeln(
    '\n合計: $changedFiles ファイル / $totalHits 箇所'
    ' / ${plan.moves.length} 件の移動',
  );

  if (changedFiles == 0 && plan.moves.isEmpty) {
    _fail(
      '置換対象が1件も見つからなかった。'
      'テンプレートの初期状態ではない（既にリネーム済み）可能性が高い。',
    );
  }
}

bool _confirm() {
  stdout.write('\n実行する? [y/N]: ');
  final answer = stdin.readLineSync()?.trim().toLowerCase();
  return answer == 'y' || answer == 'yes';
}

void _apply(_Plan plan) {
  for (final edit in plan.edits) {
    final file = File(edit.path);
    if (!file.existsSync()) continue;
    final original = file.readAsStringSync();
    var content = original;
    for (final (from, to) in edit.subs) {
      content = content.replaceAll(from, to);
    }
    if (content != original) file.writeAsStringSync(content);
  }

  for (final move in plan.moves) {
    _moveEntity(move.from, move.to);
  }

  stdout.writeln('\nリネーム完了。');
}

void _moveEntity(String from, String to) {
  final dir = Directory(from);
  if (dir.existsSync()) {
    Directory(to).parent.createSync(recursive: true);
    dir.renameSync(to);
    _pruneEmptyParents(Directory(from).parent, 'android/app/src/main/kotlin');
    return;
  }
  final file = File(from);
  if (file.existsSync()) {
    file.renameSync(to);
  }
}

/// 移動元の親ディレクトリが空になったら [stopAt] まで遡って削除する。
void _pruneEmptyParents(Directory dir, String stopAt) {
  var current = dir;
  while (true) {
    final path = current.path.replaceAll(r'\', '/');
    if (!path.startsWith(stopAt) || path == stopAt) return;
    if (!current.existsSync() || current.listSync().isNotEmpty) return;
    final parent = current.parent;
    current.deleteSync();
    current = parent;
  }
}

void _printChecklist(_Options o) {
  stdout.writeln('''

次にやること（このスクリプトの対象外。手作業）:

  1. fvm flutter clean && fvm flutter pub get
  2. fvm dart fix --apply
     （パッケージ名が変わって import の並び順が崩れるため。これで analyze が通る）
  3. Firebase を作り直す
     - fvm dart run flutterfire_cli:flutterfire configure（または firebase コンソール）
     - android/app/google-services.json と ios/Runner/GoogleService-Info.plist を差し替え
     - lib/core/firebase/firebase_options_dev.dart / _prod.dart を再生成
     - firebase.json の projectId / appId を更新
     - ios/Flutter/*.xcconfig の FIREBASE_APP_ID_SCHEME を新しい appId に更新
  4. Google ログインを使うなら ios/Runner/Info.plist の URL scheme
     （REVERSED_CLIENT_ID）を新しい OAuth クライアントのものに差し替え
  5. Supabase を使うなら新規プロジェクトを作り、supabase/migrations/ を適用
  6. env/dev.json と env/prod.json のキーを埋める
  7. assets/icon/icon.png（本番）と icon_dev.png（dev）を差し替えて
     fvm dart run flutter_launcher_icons
  8. docs/DEVELOPMENT_PLAN.md はテンプレート自体の計画書。コピー先では削除するか書き換える
  9. fvm flutter analyze && fvm flutter test で確認

  署名まわり（Apple Developer の App ID / Provisioning Profile、
  Android のキーストア）は Bundle ID: ${o.bundleId} で作り直すこと。
''');
}

Never _fail(String message) {
  stderr.writeln('エラー: $message');
  exit(1);
}
