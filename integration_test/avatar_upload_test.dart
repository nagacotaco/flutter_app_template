import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_template/core/firebase/firebase_options_dev.dart';
import 'package:flutter_app_template/features/profile/data/firebase_profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// 実 Firebase（dev プロジェクト）に対するアバターアップロードの動作確認。
/// 捨てアカウントを作成してアップロードし、終了時にアカウントを削除する。
/// 実行: `fvm flutter test integration_test/avatar_upload_test.dart
/// --flavor dev --dart-define-from-file=env/dev.json -d <デバイスID>`
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('uploadAvatar が実 Firebase Storage に対して成功する', (tester) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final auth = FirebaseAuth.instance;
    final email =
        'probe-${DateTime.now().millisecondsSinceEpoch}@example.com';
    final cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: 'Probe-Passw0rd!',
    );
    final uid = cred.user!.uid;
    try {
      final repository = FirebaseProfileRepository(
        auth,
        FirebaseStorage.instance,
      );
      // 1x1 透過 PNG
      final png = Uint8List.fromList([
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
        0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
        0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
        0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
        0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, //
        0x54, 0x78, 0x9C, 0x63, 0xF8, 0xFF, 0xFF, 0x3F, //
        0x00, 0x05, 0xFE, 0x02, 0xFE, 0xA7, 0x35, 0x81, //
        0x84, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, //
        0x44, 0xAE, 0x42, 0x60, 0x82,
      ]);
      final url = await repository.uploadAvatar(
        bytes: png,
        contentType: 'image/png',
      );
      expect(url, contains('avatars%2F$uid%2Favatar'));

      final profile = await repository.fetchMyProfile();
      expect(profile.avatarUrl, url);
    } finally {
      await auth.currentUser?.delete();
    }
  });
}
